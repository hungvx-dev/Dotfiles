local M = {}

M.keys = {
  { "<leader>rc", "<cmd>Lazy reload statuscol.nvim<CR>", desc = "Reload statuscol" },
}

M.opts = function()
  local builtin = require("statuscol.builtin")

  return {
    setopt = true,
    ft_ignore = { "neo-tree" },
    bt_ignore = { "terminal" },
    segments = {
      { text = { builtin.foldfunc } },
      { text = { "%s", colwidth = 1 }, sign = { auto = true } },
      {
        text = { "%l", " " },
        condition = { true, builtin.not_empty },
      },
    },
  }
end

return M
