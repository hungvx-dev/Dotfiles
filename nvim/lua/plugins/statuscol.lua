return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>rc", "<cmd>Lazy reload statuscol.nvim<CR>", desc = "Reload statuscol" },
  },
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
      setopt = true,
      ft_ignore = { "neo-tree" },
      bt_ignore = { "terminal" },
      segments = {
        { text = { builtin.foldfunc, "" } },
        { text = { "%s" } },
        { text = { "", builtin.lnumfunc, " " }, condition = { true, builtin.not_empty } },
      },
    }
  end,
}
