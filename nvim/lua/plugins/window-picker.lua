return {
  opts = {
    hint = "statusline-winbar",
    filter_rules = {
      autoselect_one = true,
      include_current_win = false,
      bo = {
        filetype = { "NvimTree", "neo-tree", "neo-tree-popup", "notify", "noice" },
        buftype = { "terminal", "quickfix" },
      },
    },
    show_prompt = false,
    picker_config = {
      statusline_winbar_picker = {
        selection_display = function(char)
          return "%=" .. char .. "%="
        end,
        use_winbar = "always", -- "always" | "never" | "smart"
      },
    },
    highlights = {
      statusline = {
        focused = { fg = "#ffffff", bg = "NONE" }, -- "#e35e4f"
        unfocused = { fg = "#2ac3de", bg = "NONE" }, -- #2ac3de
      },
      winbar = {
        focused = { fg = "#ffffff", bg = "NONE" },
        unfocused = { fg = "#2ac3de", bg = "NONE" },
      },
    },
  },
}
