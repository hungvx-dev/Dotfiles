local mini_starter = require("plugins.configs.ui.mini-starter")
local alpha = require("plugins.configs.ui.alpha")
local bufferline = require("plugins.configs.ui.bufferline")
local lualine = require("plugins.configs.ui.lualine")
local dressing = require("plugins.configs.ui.dressing")
local statuscol = require("plugins.configs.ui.statuscol")

return {
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy" },
    version = "*",
    dependencies = { "mini.icons" },
    keys = bufferline.keys,
    opts = bufferline.opts,
    -- config = bufferline.setup,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "mini.icons" },
    init = lualine.init,
    opts = lualine.opts,
  },

  {
    "stevearc/dressing.nvim",
    init = dressing.init,
    opts = dressing.opts,
  },

  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = statuscol.keys,
    opts = statuscol.opts,
  },

  {
    "goolord/alpha-nvim",
    enabled = true,
    event = "VimEnter",
    dependencies = { "mini.icons" },
    opts = alpha.opts,
    config = alpha.setup,
  },
  {
    "echasnovski/mini.starter",
    enabled = false,
    -- version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = mini_starter.opts,
    config = mini_starter.setup,
  },

  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = "BufReadPost",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
  },

  {
    "3rd/image.nvim",
    lazy = false,
    enabled = false,
    opts = {}
  },
}
