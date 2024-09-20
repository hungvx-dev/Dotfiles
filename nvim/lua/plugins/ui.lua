return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy" },
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      -- { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    config = require("plugins.configs.ui.bufferline").setup,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = require("plugins.configs.ui.lualine").setup,
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
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = require("plugins.configs.ui.alpha").setup,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "kevinhwang91/nvim-ufo",
    enabled = false,
    event = "BufReadPost",
    dependencies = {
      { "kevinhwang91/promise-async" },
      {
        "luukvbaal/statuscol.nvim",
        event = { "VeryLazy", "BufNewFile" },
        keys = {
          { "<leader>rc", "<cmd>Lazy reload statuscol.nvim<CR>", desc = "Reload statuscol" },
        },
        config = require("plugins.configs.ui.statuscol").setup,
      },
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
