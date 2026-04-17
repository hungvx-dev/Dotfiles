return {
  "statusline",
  dev = true,
  enabled = HVIM.plugins.statuscol,
  event = "VeryLazy",
  dependencies = { "mini.icons" },
  init = function()
    vim.g.st_laststatus = 3
    if vim.fn.argc(-1) > 0 then
      vim.go.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = {},
}
