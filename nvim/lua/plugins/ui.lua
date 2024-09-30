local mini_starter = require("plugins.configs.ui.mini-starter")
local alpha = require("plugins.configs.ui.alpha")
local bufferline = require("plugins.configs.ui.bufferline")
local lualine = require("plugins.configs.ui.lualine")

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
    config = bufferline.setup,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = lualine.init,
    dependencies = { "mini.icons" },
    config = lualine.setup,
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
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "luukvbaal/statuscol.nvim",
    event = { "VeryLazy", "BufNewFile" },
    keys = {
      { "<leader>rc", "<cmd>Lazy reload statuscol.nvim<CR>", desc = "Reload statuscol" },
    },
    config = require("plugins.configs.ui.statuscol").setup,
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
    config = require("plugins.configs.ui.ufo").setup,
  },

  {
    "3rd/image.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("plugins.configs.ui.image")
    end,
  },
}
