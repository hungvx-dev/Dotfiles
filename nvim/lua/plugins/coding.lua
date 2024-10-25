local treesitter = require("plugins.configs.coding.treesitter")
local cmp = require("plugins.configs.coding.cmp")
local autotag = require("plugins.configs.coding.autotag")
local autopairs = require("plugins.configs.coding.autopairs")

return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        opts = autotag.opts,
      },
      "nvim-autopairs",
      "hiphish/rainbow-delimiters.nvim",
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
    init = treesitter.init,
    opts = treesitter.opts,
    config = treesitter.setup,
  },

  -- auto completion
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
      { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
      { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
      { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
      -- { "roobert/tailwindcss-colorizer-cmp.nvim", enabled = false },
    },
    opts = cmp.opts,
  },
  {
    "nvim-cmp",
    dependencies = {
      { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
    },
    opts = cmp.cmdline,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = { friendly_snippets = true },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "snippets", priority = 6, max_item_count = 10, group_index = 1 })
    end,
    keys = cmp.keys,
  },

  -- Comment
  {
    "echasnovski/mini.comment",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = { enable_autocmd = false },
  },

  {
    "windwp/nvim-autopairs",
    opts = autopairs.opts,
    config = autopairs.setup,
  },

  {
    "kylechui/nvim-surround",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },
}

-- local disabled = {
-- {
--   "numToStr/Comment.nvim",
--   enabled = false,
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "nvim-treesitter",
--     {
--       "JoosepAlviste/nvim-ts-context-commentstring",
--       opts = { enable_autocmd = false },
--     },
--   },
--   opts = function()
--     return {
--       pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
--     }
--   end,
-- },
-- {
--   "nvim-neorg/neorg",
--   enabled = false,
--   lazy = false,
--   version = "*",
--   config = require("plugins.configs.coding.neorg").setup,
-- },

-- {
--   "github/copilot.vim",
--   enabled = false,
--   event = { "BufReadPre", "BufNewFile" },
-- },
--   {
--     "L3MON4D3/LuaSnip",
--     enabled = false,
--     build = "make install_jsregexp",
--     dependencies = {
--       {
--         "rafamadriz/friendly-snippets",
--         config = function()
--           require("luasnip.loaders.from_vscode").lazy_load()
--         end,
--       },
--       {
--         "nvim-cmp",
--         dependencies = {
--           "saadparwaiz1/cmp_luasnip",
--         },
--         opts = function(_, opts)
--           opts.snippet = {
--             expand = function(args)
--               require("luasnip").lsp_expand(args.body)
--             end,
--           }
--           table.insert(opts.sources, { name = "luasnip", priority = 6, max_item_count = 10 })
--         end,
--       },
--     },
--     keys = require("plugins.configs.coding.lua-snip").keys,
--     opts = {
--       history = true,
--       delete_check_events = "TextChanged",
--     },
--   },
-- {
--   "saghen/blink.cmp",
--   enabled = false,
--   lazy = false,
--   dependencies = "rafamadriz/friendly-snippets",
--   version = "v0.*",
--   opts = {
--     keymap = {
--       select_prev = { "<C-k>" },
--       select_next = { "<C-j>" },
--     },
--     windows = {
--       autocomplete = {
--         min_width = 15,
--         max_height = 10,
--         border = "single",
--         winhighlight = "FloatBorder:Pmenu,Search:None,CursorLine:CursorLine",
--         scrolloff = 2,
--         direction_priority = { "s", "n" },
--         auto_show = true,
--         selection = "preselect",
--         draw = "simple",
--         cycle = {
--           from_bottom = true,
--           from_top = true,
--         },
--       },
--       documentation = {
--         min_width = 10,
--         max_width = 60,
--         max_height = 20,
--         border = "single",
--         winhighlight = "FloatBorder:Pmenu,Search:None,CursorLine:CursorLine",
--         direction_priority = {
--           autocomplete_north = { "e", "w", "n", "s" },
--           autocomplete_south = { "e", "w", "s", "n" },
--         },
--         auto_show = true,
--         auto_show_delay_ms = 500,
--         update_delay_ms = 50,
--       },
--     },
--     highlight = {
--       use_nvim_cmp_as_default = true,
--     },
--     nerd_font_variant = "normal",
--   },
-- },
-- }
