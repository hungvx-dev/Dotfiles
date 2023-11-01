local M = {}

function M.setup()
  local present, statuscol = pcall(require, "statuscol")
  if not present then
    return
  end
  local builtin = require("statuscol.builtin")
  M.opts = {
    segments = {
      { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
      { text = { "%s" },             click = "v:lua.ScSa" },
      {
        text      = { "", builtin.lnumfunc, " " },
        condition = { true, builtin.not_empty },
        click     = "v:lua.ScLa",
      },
    },
  }

  statuscol.setup(M.opts)
end

return M
