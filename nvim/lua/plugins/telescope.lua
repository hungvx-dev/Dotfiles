-- local actions = require 'telescope.actions'

-- require("telescope").setup {
--   defaults = {
--     prompt_prefix = " ",
--     selection_caret = " ",
--     entry_prefix = "  ",
--     sorting_strategy = 'ascending',
--     winblend = 0,
--     hidden = true,
--     -- preview = false,
--     file_ignore_patterns = {"node_modules", ".git"},
--     mappings = {
--       i = {
--         ["<C-d>"] = actions.close,
--         -- ["<Esc>"] = actions.close,
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--         ["<C-b>"] = actions.preview_scrolling_up,
--         ["<C-f>"] = actions.preview_scrolling_down,
--         ["<C-t>"] = trouble.open_with_trouble
--       },
--       n = {
--         ["<C-d>"] = actions.close,
--         ["<Esc>"] = actions.close,
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--         ["<C-b>"] = actions.preview_scrolling_up,
--         ["<C-f>"] = actions.preview_scrolling_down,
--         ["<C-t>"] = trouble.open_with_trouble
--       }
--     },
--     layout_config = {
--       height = 0.75,
--       width = 0.75
--     },
--     initial_mode = "insert",
--     layout_strategy = "horizontal",
--   }
-- }
-- require('telescope').setup {
--   defaults = {
--     layout_config = {
--       width = 0.75,
--       prompt_position = "top",
--       preview_cutoff = 120,
--       horizontal = {mirror = false},
--       vertical = {mirror = false}
--     },
--     find_command = {
--       'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
--     },
--     prompt_prefix = " ",
--     selection_caret = " ",
--     entry_prefix = "  ",
--     path_display = {},
--     winblend = 0,
--     border = {},
--     borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
--   },
--   pickers = {
--     find_files = {theme = "dropdown"},
--     live_grep = {theme = "dropdown"},
--     buffers = {theme = "dropdown"},
--     lsp_code_actions = {theme = "dropdown"}
--   }
--
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local trouble = require 'trouble.providers.telescope'
local actions = require "telescope.actions"
telescope.load_extension "media_files"
local icons = require "plugins.icons"

telescope.setup {
  defaults = {
    prompt_prefix = icons.ui.Telescope .. " ",
    selection_caret = " ",
    path_display = { "smart" },
    -- file_ignore_patterns = { ".git/", "node_modules/", "target/", "docs/", ".settings/" },
    file_ignore_patterns = {
      ".git/",
      "target/",
      "docs/",
      "vendor/*",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "node_modules/*",
      -- "%.jpg",
      -- "%.jpeg",
      -- "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "%.webp",
      ".dart_tool/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "%.pdb",
      "%.dll",
      "%.class",
      "%.exe",
      "%.cache",
      "%.ico",
      "%.pdf",
      "%.dylib",
      "%.jar",
      "%.docx",
      "%.met",
      "smalljre_*/*",
      ".vale/",
      "%.burp",
      "%.mp4",
      "%.mkv",
      "%.rar",
      "%.zip",
      "%.7z",
      "%.tar",
      "%.bz2",
      "%.epub",
      "%.flac",
      "%.tar.gz",
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    file_browser = {
      -- theme = "ivy",
      -- require("telescope.themes").get_dropdown {
      --   previewer = false,
      --   -- even more opts
      -- },
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    -- ["ui-select"] = {
    --   require("telescope.themes").get_dropdown {
    --     previewer = false,
    --     -- even more opts
    --   },
    -- },
  },
}

-- telescope.load_extension "ui-select"
telescope.load_extension "file_browser"
-- }
