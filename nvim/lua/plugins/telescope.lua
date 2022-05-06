local actions = require 'telescope.actions'
local trouble = require 'trouble.providers.telescope'

require("telescope").setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    sorting_strategy = 'ascending',
    winblend = 0,
    hidden = true,
    -- preview = false,
    file_ignore_patterns = {"node_modules", ".git"},
    mappings = {
      i = {
        ["<C-d>"] = actions.close,
        ["<Esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-t>"] = trouble.open_with_trouble
      },
      n = {
        ["<C-d>"] = actions.close,
        ["<Esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-t>"] = trouble.open_with_trouble
      }
    },
    layout_config = {
      height = 0.75,
      width = 0.75
    },
    initial_mode = "insert",
    layout_strategy = "horizontal",
  }
}
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
-- }
