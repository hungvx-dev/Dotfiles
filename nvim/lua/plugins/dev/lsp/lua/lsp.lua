local diagnostics = require("diagnostics")

local M = {}
local keymap = vim.keymap

function M.capabilities()
  local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
  local has_blink, blink = pcall(require, "blink.cmp")
  return vim.tbl_deep_extend("force", {}, has_blink and blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()) or {}, has_lsp_file and lsp_file.default_capabilities() or {})
end

function M.setup(opts)
  M.opts = opts
  diagnostics.config_diagnostic(opts.diagnostic)

  vim.lsp.config(
    "*",
    ---@type vim.lsp.Config
    {
      capabilities = M.capabilities(),
      on_attach = function(client, buf)
        local opt = { buffer = buf }

        -- if client:supports_method("textDocument/documentColor") then
        --   vim.lsp.document_color.enable(true, buf)
        -- end

        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
        -- vim.keymap.set("n", "gd", function()
        --   vim.lsp.buf.definition({ reuse_win = true })
        -- end, opt)
        -- vim.keymap.set("n", "K", function()
        --   vim.lsp.buf.hover({ border = "rounded" })
        -- end, opt)
        keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opt)
        keymap.set("n", "gR", vim.lsp.buf.rename, opt)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opt)

        keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>", opt)
        -- vim.keymap.set("n", "gd", function()
        --   require("fzf-lua").lsp_definitions({ jump1 = true, reuse_win = true  })
        -- end, { desc = "Goto Definition" })
        keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", opt)
        keymap.set("n", "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>", opt)
        keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>", opt)

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
          vim.keymap.set("n", "<leader>gh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
          end, opt)
          client.server_capabilities.semanticTokensProvider = nil
        end
        local ok, navic = pcall(require, "nvim-navic")
        if ok and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, buf)
        end
        vim.o.winborder = "rounded"
        -- if client:supports_method("textDocument/foldingRange") then
        --   local win = vim.api.nvim_get_current_win()
        --   vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        -- end
      end,
      root_markers = { ".git" },
    }
  )

  vim.lsp.enable(opts.lsp)
end

return M
