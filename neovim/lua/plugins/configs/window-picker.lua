require("window-picker").setup {
  hint = "statusline-winbar",
  autoselect_one = true,
  include_current = false,
  -- selection_chars = 'FJDKSLA;CMRUEIWOQP',
  -- selection_chars = "ABCDEFG;CMRUEIWOQP",
  picker_config = {
    statusline_winbar_picker = {
      -- You can change the display string in status bar.
      -- It supports '%' printf style. Such as `return char .. ': %f'` to display
      -- buffer file path. See :h 'stl' for details.
      selection_display = function(char, windowid)
        return "%=" .. char .. "%="
      end,

      -- whether you want to use winbar instead of the statusline
      -- "always" means to always use winbar,
      -- "never" means to never use winbar
      -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
      use_winbar = "never", -- "always" | "never" | "smart"
    },

    floating_big_letter = {
      -- window picker plugin provides bunch of big letter fonts
      -- fonts will be lazy loaded as they are being requested
      -- additionally, user can pass in a table of fonts in to font
      -- property to use instead

      font = "ansi-shadow", -- ansi-shadow |
    },
  },

  -- whether to show 'Pick window:' prompt
  show_prompt = true,

  -- prompt message to show to get the user input
  prompt_message = "Pick window: ",
  filter_rules = {
    -- filter using buffer options
    -- when there is only one window available to pick from, use that window
    -- without prompting the user to select
    autoselect_one = true,

    -- whether you want to include the window you are currently on to window
    -- selection or not
    include_current_win = false,

    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { "NvimTree", "neo-tree", "notify" },

      -- if the file type is one of following, the window will be ignored
      buftype = { "terminal", "quickfix" },
    },

    -- filter using window options
    wo = {},

    -- if the file path contains one of following names, the window
    -- will be ignored
    file_path_contains = {},

    -- if the file name contains one of following names, the window will be
    -- ignored
    file_name_contains = {},
  },
  highlights = {
    statusline = {
      focused = {
        fg = "#ededed",
        bg = "NONE",
        bold = true,
      },
      unfocused = {
        fg = "#e35e4f",
        bg = "NONE",
        bold = true,
      },
    },
    winbar = {
      focused = {
        fg = "#ededed",
        bg = "NONE",
        bold = true,
      },
      unfocused = {
        fg = "#e35e4f",
        bg = "NONE",
        bold = true,
      },
    },
  },
}
