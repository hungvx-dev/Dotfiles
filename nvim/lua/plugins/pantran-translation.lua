return {
  "potamides/pantran.nvim",
  enabled = false,
  opts = {
    default_engine = "yandex",
    engines = {
      yandex = {
        default_source = "en",
        default_target = "vi",
      },
    },
  },
  config = function(_, opts)
    local pantran = require("pantran")
    pantran.setup(opts)
    local keyopts = { noremap = true, silent = true, expr = true }
    vim.keymap.set("n", "<leader>tr", pantran.motion_translate, keyopts)
    vim.keymap.set("n", "<leader>trr", function()
      return pantran.motion_translate() .. "_"
    end, keyopts)
    vim.keymap.set("x", "<leader>tr", pantran.motion_translate, keyopts)
  end,
}
