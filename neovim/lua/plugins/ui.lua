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
    lazy = true,
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
  -- {
  --   "goolord/alpha-nvim",
  --   event = "VimEnter",
  --   opts = function()
  --     local dashboard = require "alpha.themes.dashboard"
  --     local logo = [[
  --          ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
  --          ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
  --          ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
  --          ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
  --          ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
  --          ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
  --     ]]

  --     dashboard.section.header.val = vim.split(logo, "\n")
  --     dashboard.section.buttons.val = {
  --       dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
  --       dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
  --       dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
  --       dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
  --       dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
  --       dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  --       dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
  --       dashboard.button("q", " " .. " Quit", ":qa<CR>"),
  --     }
  --     for _, button in ipairs(dashboard.section.buttons.val) do
  --       button.opts.hl = "AlphaButtons"
  --       button.opts.hl_shortcut = "AlphaShortcut"
  --     end
  --     dashboard.section.header.opts.hl = "AlphaHeader"
  --     dashboard.section.buttons.opts.hl = "AlphaButtons"
  --     dashboard.section.footer.opts.hl = "AlphaFooter"
  --     dashboard.opts.layout[1].val = 8
  --     return dashboard
  --   end,
  --   config = function(_, dashboard)
  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "AlphaReady",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end

  --     require("alpha").setup(dashboard.opts)

  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "LazyVimStarted",
  --       callback = function()
  --         local stats = require("lazy").stats()
  --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --         dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
  --         pcall(vim.cmd.AlphaRedraw)
  --       end,
  --     })
  --   end,
  -- },

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

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
}
