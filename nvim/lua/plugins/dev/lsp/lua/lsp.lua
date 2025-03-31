local M = {}
local keymap = vim.keymap

function M.diagnostic_config(diagnostic)
  vim.diagnostic.config(diagnostic)
  keymap.set("n", "!", vim.diagnostic.open_float)
  keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end)
  keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end)
  keymap.set("n", "<space>q", vim.diagnostic.setloclist)
end

function M.capabilities()
  local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
  local has_blink, blink = pcall(require, "blink.cmp")
  return vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), has_lsp_file and lsp_file.default_capabilities() or {}, has_blink and blink.get_lsp_capabilities() or {})
end

function M.setup(opts)
  M.diagnostic_config(opts.diagnostic)

  vim.lsp.config(
    "*",
    ---@type vim.lsp.Config
    {
      capabilities = M.capabilities(),
      on_attach = function(client, buf)
        local opt = { buffer = buf }

        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
        -- vim.keymap.set("n", "K", function()
        --   vim.lsp.buf.hover({ border = "rounded" })
        -- end, opt)
        keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opt)
        keymap.set("n", "gR", vim.lsp.buf.rename, opt)
        keymap.set("n", "gD", vim.lsp.buf.declaration, opt)

        keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions     jump1=true ignore_current_line=true<cr>", opt)
        keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>", opt)
        keymap.set("n", "gr", "<cmd>FzfLua lsp_references      jump1=true ignore_current_line=true<cr>", opt)
        keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs        jump1=true ignore_current_line=true<cr>", opt)

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
          vim.keymap.set("n", "<leader>gh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
          end, opt)
          client.server_capabilities.semanticTokensProvider = nil
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
