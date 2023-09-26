return {
  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    lazy = false,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    config = function()
      require("plugins.configs.bufferline").setup()
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("plugins.configs.lualine").setup()
    end,
    event = "VeryLazy",
  },

  -- dashboard
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    config = function()
      require "plugins.configs.mini-start"
    end,
  },

  -- lsp symbol navigation for lualine
  {
    "SmiteshP/nvim-navic",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("utils").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    config = function()
      require("plugins.configs.breadcrumbs").setup()
    end,
  },

  {
    "rcarriga/nvim-notify",
    enabled = false,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss { silent = true, pending = true }
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require "utils"
      if not Util.has "noice.nvim" then
        Util.on_very_lazy(function()
          vim.notify = require "notify"
        end)
      end
    end,
  },

  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = true,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    },
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true, enabled = false },
}
