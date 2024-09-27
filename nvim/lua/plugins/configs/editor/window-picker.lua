local M = {}
M.opts = {
  hint = "statusline-winbar",
  filter_rules = {
    autoselect_one = true,
  },
  show_prompt = false,
  picker_config = {
    statusline_winbar_picker = {
      selection_display = function(char)
        return "%=" .. char .. "%="
      end,
      use_winbar = "smart", -- "always" | "never" | "smart"
    },
  },
  highlights = {
    statusline = {
      focused = { fg = "#ededed", bg = "NONE" }, -- "#e35e4f"
      unfocused = { fg = "#2ac3de", bg = "NONE" }, -- #2ac3de
    },
    winbar = {
      focused = { fg = "#ededed", bg = "NONE" },
      unfocused = { fg = "#2ac3de", bg = "NONE" },
    },
  },
}

function M.setup()
  local status_ok, window_picker = pcall(require, "window-picker")
  if not status_ok then
    return
  end

  window_picker.setup(M.opts)
end

return M
