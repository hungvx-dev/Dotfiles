local M = {}

M.opts = {
  use_diagnostic_signs = true,
  modes = {
    lsp = {
      win = { position = "right" },
    },
  },
}

M.keys = {
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Document Diagnostics (Trouble)" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Workspace Diagnostics (Trouble)" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
  { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List (Trouble)" },
  {
    "[q",
    function()
      if require("trouble").is_open() then
        require("trouble").prev({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cprev)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end,
    desc = "Previous trouble/quickfix item",
  },
  {
    "]q",
    function()
      if require("trouble").is_open() then
        require("trouble").next({ skip_groups = true, jump = true })
      else
        local ok, err = pcall(vim.cmd.cnext)
        if not ok then
          vim.notify(err, vim.log.levels.ERROR)
        end
      end
    end,
    desc = "Next trouble/quickfix item",
  },
}

return M
