local M = {}

function M.setup()
  local present, statuscol = pcall(require, "statuscol")
  if not present then
    return
  end
  local builtin = require("statuscol.builtin")
  M.opts = {
    setopt = true,
    ft_ignore = { "neo-tree" },
    bt_ignore = { "terminal" },
    segments = {
      { text = { builtin.foldfunc } },
      { text = { "%s", colwidth = 1 }, sign = { auto = true } },
      {
        text = { builtin.lnumfunc, " " },
        condition = { true, builtin.not_empty },
      },
    },
  }

  statuscol.setup(M.opts)
end

return M
