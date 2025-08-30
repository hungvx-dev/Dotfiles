local diagnostics = require("diagnostics")

local M = {}
local map = vim.keymap.set

-- function M.capabilities()
--   local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
--   local has_blink, blink = pcall(require, "blink.cmp")
--   return vim.tbl_deep_extend("force", {}, has_blink and blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()) or {}, has_lsp_file and lsp_file.default_capabilities() or {})
-- end

function M.keymaps(client, buf)
  local opts = { buffer = buf, noremap = true }
  map("n", "gd", function()
    vim.lsp.buf.definition({ reuse_win = true })
  end, opts)
  map("n", "gi", function()
    vim.lsp.buf.implementation({ reuse_win = true })
  end, opts)
  -- map("n", "gr", vim.lsp.buf.references, opts) -- grr
  map("n", "gt", vim.lsp.buf.type_definition, opts)
  map({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
  -- map("n", "gR", vim.lsp.buf.rename, opts) -- grr
  map("n", "gD", vim.lsp.buf.declaration, opts)

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    map("n", "<leader>gi", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end, opts)
    -- client.server_capabilities.semanticTokensProvider = nil
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

        if client:supports_method("textDocument/foldingRange") then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        -- if client:supports_method("textDocument/documentColor") then
        --   vim.lsp.document_color.enable(true, buf)
        -- end

        -- local ok, navic = pcall(require, "nvim-navic")
        -- if ok and client.server_capabilities.documentSymbolProvider then
        --   navic.attach(client, buf)
        -- end
      end,
      root_markers = { ".git" },
    }
  )

  vim.lsp.enable(opts.lsp)
end

return M
