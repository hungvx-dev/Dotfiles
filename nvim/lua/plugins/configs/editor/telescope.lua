local M = {}

M.keys = {
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
}
function M.opts()
  local actions = require("telescope.actions")
  -- local previewers = require("telescope.previewers")
  local sorters = require("telescope.sorters")

  return {
    defaults = {
      prompt_prefix = HVIM.icons.UI.Search,
      selection_caret = HVIM.icons.UI.SelectionCaret,
      path_display = { "smart" },
      initial_mode = "insert",
      vimgrep_arguments = {
        "rg",
        -- "--color=never",
        -- "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        preview_cutoff = 5,
        prompt_position = "top",
      },
      mappings = {
        i = {
          -- ["<c-t>"] = function(...)
          --   return require("trouble.providers.telescope").open_with_trouble(...)
          -- end,
          -- ["<a-t>"] = function(...)
          --   return require("trouble.providers.telescope").open_selected_with_trouble(...)
          -- end,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-v>"] = actions.select_vertical,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,
          ["<C-q>"] = actions.close,
        },
        n = {
          ["q"] = function(...)
            return actions.close(...)
          end,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-v>"] = actions.select_vertical,
          ["<C-x>"] = actions.select_horizontal,
        },
      },
      file_ignore_patterns = M.file_ignore_patterns,
      winblend = 0,
      border = {},
      borderchars = nil,
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    -- file_previewer = previewers.vim_buffer_cat.new,
    -- grep_previewer = previewers.vim_buffer_vimgrep.new,
    -- qflist_previewer = previewers.vim_buffer_qflist.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },

    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
      },
      grep_string = {
        only_sort_text = true,
      },
      buffers = {
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      git_files = {
        hidden = true,
        show_untracked = true,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
  }
end

function M.setup()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end
  local opts = M.opts()

  telescope.setup(opts)
  telescope.load_extension("fzf")
end

M.file_ignore_patterns = {
  "CHANGELOG.md",
  "^.git/",
  "%.lock",
  "%.sqlite3",
  "node_modules/*",
  "%.svg",
  "%.otf",
  "%.ttf",
  "%.webp",
  ".github/",
  ".idea/",
  ".settings/",
  ".vscode/",
  "build/",
  "node_modules/",
  "%.class",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
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
}

return M
