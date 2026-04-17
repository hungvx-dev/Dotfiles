return {
  init = function()
    vim.g.st_laststatus = 3
    local has_file = vim.fn.argc() > 0
    if not has_file then
      vim.o.laststatus = 0
    end
  end,
  opts = {},
}
