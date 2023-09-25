return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        enabled = true,
        name = "window-picker",
        event = "VeryLazy",
        version = "2.*",
        config = function()
          require "plugins.configs.window-picker"
        end,
      },
    },
    keys = {
      { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
      { "<leader>n", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
    },
    deactivate = function()
      vim.cmd [[Neotree close]]
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require "neo-tree"
        end
      end
    end,
    config = function(_)
      require("plugins.configs.neo-tree").setup()
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    event = { "BufRead", "BufWinEnter" },
    lazy = true,
    enabled = false,
    -- stylua: ignore
    keys = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    },
    keys = {
      { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fp", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" }, -- git
      { "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fj", "<cmd>Telescope grep_string<cr>", desc = "Word (root dir)" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    },
    config = function()
      require "plugins.configs.telescope"
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    config = function()
      require("plugins.configs.indent-lines").setup()
    end,
  },

  -- easily jump
  {
    "unblevable/quick-scope",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      require "plugins.configs.quick-scope"
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      vim.g.VM_leader = "\\"
    end,
  },

  -- which-key
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     plugins = { spelling = true },
  --     defaults = {
  --       mode = { "n", "v" },
  --       ["g"] = { name = "+goto" },
  --       ["gz"] = { name = "+surround" },
  --       ["]"] = { name = "+next" },
  --       ["["] = { name = "+prev" },
  --       ["<leader><tab>"] = { name = "+tabs" },
  --       ["<leader>b"] = { name = "+buffer" },
  --       ["<leader>c"] = { name = "+code" },
  --       ["<leader>f"] = { name = "+file/find" },
  --       ["<leader>g"] = { name = "+git" },
  --       ["<leader>gh"] = { name = "+hunks" },
  --       ["<leader>q"] = { name = "+quit/session" },
  --       ["<leader>s"] = { name = "+search" },
  --       ["<leader>u"] = { name = "+ui" },
  --       ["<leader>w"] = { name = "+windows" },
  --       ["<leader>x"] = { name = "+diagnostics/quickfix" },
  --     },
  --   },
  --   config = function(_, opts)
  --     local wk = require("which-key")
  --     wk.setup(opts)
  --     wk.register(opts.defaults)
  --   end,
  -- },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.configs.git.signs"
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    -- lazy = true,
    config = function()
      require "plugins.configs.git.conflict"
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    config = function()
      require "plugins.configs.todo-comments"
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.configs.comment").setup()
    end,
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufRead", "BufWinEnter" },
    lazy = true,
    config = function()
      require "plugins.configs.colorizer"
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    enabled = true,
    lazy = true,
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        lazy = true,
        enabled = true,
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              -- {
              --   sign = { name = { "Diagnostic" } },
              --   click = "v:lua.ScSa",
              -- },
              -- {
              --   sign = { name = { "GitSigns" }, maxwidth = 1 },
              --   click = "v:lua.ScSa",
              -- },
              {
                text = { "", builtin.lnumfunc, " " },
                -- text = { "%l", " " },
                -- sign = { fillchar = "" },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
              },
            },
          }
        end,
      },
    },
    config = function()
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      require "plugins.configs.ufo"
    end,
  },
}
