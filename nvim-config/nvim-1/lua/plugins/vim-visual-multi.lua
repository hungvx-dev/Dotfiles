return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    vim.g.VM_set_statusline = 0
    vim.g.VM_silent_exit = 1
  end,
}
