local diagnostics = require("diagnostics")

local M = {}
local keymap = vim.keymap

-- function M.capabilities()
--   local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
--   local has_blink, blink = pcall(require, "blink.cmp")
--   return vim.tbl_deep_extend("force", {}, has_blink and blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()) or {}, has_lsp_file and lsp_file.default_capabilities() or {})
-- end

local fzf_keymaps = {
  { "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>", desc = "Goto Definition" },
  { "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>", desc = "References", nowait = true },
  { "gi", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
  { "gt", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
}

local telescope_keymaps = {
  {
    "gd",
    function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end,
    desc = "Goto Definition",
  },
  { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
  {
    "gi",
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end,
    desc = "Goto Implementation",
  },
  {
    "gt",
    function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end,
    desc = "Goto T[y]pe Definition",
  },
}

function M.keymaps(client, buf)
  local Keys = require("lazy.core.handler.keys")
  local opts = { buffer = buf }

  if HVIM.plugins.telescope then
    for _, key in pairs(telescope_keymaps) do
      if not key.method or (key.method and client.supports_method(key.method)) then
        local _opts = Keys.opts(key)
        _opts.buffer = buf
        keymap.set(key.mode or "n", key[1], key[2], _opts)
      end
    end
  elseif HVIM.plugins.fzf then
    for _, key in pairs(fzf_keymaps) do
      if not key.method or (key.method and client.supports_method(key.method)) then
        local _opts = Keys.opts(key)
        _opts.buffer = buf
        keymap.set(key.mode or "n", key[1], key[2], _opts)
      end
    end
  else
    keymap.set("n", "gd", function()
      vim.lsp.buf.definition({ reuse_win = true })
    end, opts)
    keymap.set("n", "gi", function()
      vim.lsp.buf.implementation({ reuse_win = true })
    end, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)
    keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  end

  keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
  keymap.set("n", "gR", vim.lsp.buf.rename, opts)
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    keymap.set("n", "<leader>gh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end, opts)
    client.server_capabilities.semanticTokensProvider = nil
  end
end

function M.setup(opts)
  M.opts = opts
  diagnostics.config_diagnostic(opts.diagnostic)

  vim.lsp.config(
    "*",
    ---@type vim.lsp.Config
    {
      -- capabilities = M.capabilities(),
      on_attach = function(client, buf)
        M.keymaps(client, buf)

        -- if client:supports_method("textDocument/documentColor") then
        --   vim.lsp.document_color.enable(true, buf)
        -- end

        local ok, navic = pcall(require, "nvim-navic")
        if ok and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, buf)
        end
      end,
      root_markers = { ".git" },
    }
  )

  vim.lsp.enable(opts.lsp)
end

return M
