local M = {}

local function diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = hvim.icons.diagnostics.BoldError,
    warning = hvim.icons.diagnostics.BoldWarning,
    info = hvim.icons.diagnostics.BoldInformation,
  }
  if not hvim.use_icons then
    return "(" .. num .. ")"
  end
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

local hl = {
  fill = { bg = "none" },
  background = { bg = "none" },
  tab = { bg = "none" },
  tab_selected = { bg = "none" },
  tab_close = { bg = "none" },
  close_button = { bg = "none" },
  close_button_visible = { bg = "none" },
  buffer_visible = { bg = "none" },
  buffer_selected = { bg = "none" },
  numbers = { bg = "none" },
  numbers_visible = { bg = "none" },
  numbers_selected = { bg = "none" },
  diagnostic = { bg = "none" },
  diagnostic_visible = { bg = "none" },
  diagnostic_selected = { bg = "none" },
  hint = { bg = "none" },
  hint_visible = { bg = "none" },
  hint_selected = { bg = "none" },
  hint_diagnostic = { bg = "none" },
  hint_diagnostic_visible = { bg = "none" },
  hint_diagnostic_selected = { bg = "none" },
  info = { bg = "none" },
  info_visible = { bg = "none" },
  info_selected = { bg = "none" },
  info_diagnostic = { bg = "none" },
  info_diagnostic_visible = { bg = "none" },
  info_diagnostic_selected = { bg = "none" },
  warning = { bg = "none" },
  warning_visible = { bg = "none" },
  warning_selected = { bg = "none" },
  warning_diagnostic = { bg = "none" },
  warning_diagnostic_visible = { bg = "none" },
  warning_diagnostic_selected = { bg = "none" },
  error = { bg = "none" },
  error_visible = { bg = "none" },
  error_selected = { bg = "none" },
  error_diagnostic = { bg = "none" },
  error_diagnostic_visible = { bg = "none" },
  error_diagnostic_selected = { bg = "none" },
  modified = { bg = "none" },
  modified_visible = { bg = "none" },
  modified_selected = { bg = "none" },
  duplicate_selected = { bg = "none" },
  duplicate_visible = { bg = "none" },
  duplicate = { bg = "none" },
  separator_selected = { bg = "none" },
  separator_visible = { bg = "none" },
  separator = { bg = "none" },
  indicator_selected = { bg = "none" },
  pick_selected = { bg = "none" },
  pick_visible = { bg = "none" },
  pick = { bg = "none" },
  offset_separator = { bg = "none" },
}

local setup = {
  highlights = hl,
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = function(bufnr)
      require("mini.bufremove").delete(bufnr, false)
    end,
    right_mouse_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    buffer_close_icon = hvim.icons.ui.Close,
    close_icon = hvim.icons.ui.BoldClose,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "flutterToolsOutline",
        text = "Flutter Outline",
        highlight = "PanelHeading",
      },
      {
        filetype = "lazy",
        text = "Lazy",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
  },
}

M.setup = function()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  -- can't be set in settings.lua because default tabline would flash before bufferline is loaded
  vim.opt.showtabline = 2

  bufferline.setup {
    options = setup.options,
    highlights = setup.highlights,
  }
end

--stylua: ignore

return M
