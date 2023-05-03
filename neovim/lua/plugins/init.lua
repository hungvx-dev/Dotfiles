return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require "configs.colorscheme"
      vim.cmd("colorscheme " .. hvim.colorscheme)
    end,
  },

  {
    "nvim-lua/plenary.nvim",
    cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
    lazy = true,
  },

  { "nvim-lua/popup.nvim",  lazy = true },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = { {
      "<leader>t",
      "<cmd>Neotree toggle<cr>",
      desc = "NeoTree",
    } },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = false, -- last release is way too old and doesn't work on Windows
        config = function()
          require("window-picker").setup {
            autoselect_one = true,
            include_current = false,
            -- selection_chars = 'FJDKSLA;CMRUEIWOQP',
            selection_chars = "ABCDEFG;CMRUEIWOQP",
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          }
        end,
      },
    },
    config = function()
      require("plugins.neo-tree").setup()
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = hvim.use_icons,
    config = function()
      require("nvim-web-devicons").setup {
        default = true,
      }
    end,
    lazy = true,
  },
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    lazy = true,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = require("lazyvim.config").icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        --       .. (diag.warning and icons.Warn .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },


  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("completion.cmp").setup()
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "tzachar/cmp-tabnine",     build = "./install.sh" },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    cond = hvim.builtin.luasnip.sources.friendly_snippets,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "mrjones2014/nvim-ts-rainbow",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs { "move", "select", "swap", "lsp_interop" } do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    config = function()
      require("plugins.treesitter").setup()
    end,
  },
  {
    -- Lazy loaded by Comment.nvim pre_hook
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-lines").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      {
        "<leader>xt",
        "<cmd>TodoTrouble<cr>",
        desc = "Todo (Trouble)",
      },
      {
        "<leader>xT",
        "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      {
        "<leader>st",
        "<cmd>TodoTelescope<cr>",
        desc = "Todo",
      },
    },
    config = function()
      require "plugins.todo-comments"
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment").setup()
    end,
    event = "BufEnter",
    lazy = true,
  },

  {
    "nvim-pack/nvim-spectre",
    event   = { "BufRead", "BufWinEnter" },
    lazy    = true,
    enabled = false,
    keys    = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)", },
    },
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.autopairs").setup()
    end,
    opts = { history = true, delete_check_events = "TextChanged" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
  },

  { "kylechui/nvim-surround", config = true },
  {
    "kana/vim-textobj-entire",
    dependencies = { "kana/vim-textobj-user", lazy = true },
  },

  {
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_leader = "\\"
    end,
  },

  {
    "unblevable/quick-scope",
    enabled = true,
    config = function()
      require "plugins.quick-scope"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufRead", "BufWinEnter" },
    lazy = true,
    config = function()
      require "plugins.colorizer"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("plugins.lualine").setup()
    end,
    event = "VeryLazy",
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    -- enabled = false,
    lazy = true,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        lazy = true,
        -- enabled = false,
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" },             click = "v:lua.ScSa" },
              {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa"
              },
            },
          })
        end,
      },
    },
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      require "plugins.ufo"
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.git.signs"
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    -- lazy = true,
    config = function()
      require "plugins.git.conflict"
    end,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous {
              skip_groups = true,
              jump = true,
            }
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next {
              skip_groups = true,
              jump = true,
            }
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  }, -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now

    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
      },
    },
    keys = {
      { "<leader>fs", "<cmd>Telescope live_grep<cr>",                 desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>fp", "<cmd>Telescope find_files<cr>",                desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" }, -- git
      { "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",               desc = "Diagnostics" },
      { "<leader>fj", "<cmd>Telescope grep_string<cr>",               desc = "Word (root dir)" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
      { "<leader>fH", "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>fm", "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>f:", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
    },
    config = function()
      require "plugins.telescope"
    end,
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("utils").has "nvim-cmp"
        end,
      },
      "jose-elias-alvarez/typescript.nvim",
      { "b0o/SchemaStore.nvim", lazy = true },
    },
    config = function()
      require("lsp").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    lazy = true,
    dependencies = "mason.nvim",
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    lazy = true,
    enabled = true,
    config = function()
      require "lsp.null-ls"
    end,
  },

  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("lsp.mason").setup()
    end,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    lazy = true,
  },

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
      require("plugins.breadcrumbs").setup()
    end,
  },
}
