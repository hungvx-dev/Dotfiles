local M = {}

function M.setup(opts)
  vim.lsp.config("*", {
    on_attach = function(_, buffer)
      local opt = { noremap = true, silent = true, buffer = buffer }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, opts)
    end,
    root_markers = { ".git" },
  })
  vim.lsp.enable(opts.lsp)
end

return M
