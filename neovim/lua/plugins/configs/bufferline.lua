local M = {}

local function diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = hvim.icons.Diagnostics.BoldError,
    warning = hvim.icons.Diagnostics.BoldWarning,
    info = hvim.icons.Diagnostics.BoldInformation,
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

-- local transparent = { bg = "none" }

-- local hl = {
--   fill = transparent,
--   background = transparent,
--   tab = transparent,
--   tab_selected = transparent,
--   tab_close = transparent,
--   close_button = transparent,
--   close_button_visible = transparent,
--   buffer_visible = transparent,
--   buffer_selected = transparent,
--   numbers = transparent,
--   numbers_visible = transparent,
--   numbers_selected = transparent,
--   diagnostic = transparent,
--   diagnostic_visible = transparent,
--   diagnostic_selected = transparent,
--   hint = transparent,
--   hint_visible = transparent,
--   hint_selected = transparent,
--   hint_diagnostic = transparent,
--   hint_diagnostic_visible = transparent,
--   hint_diagnostic_selected = transparent,
--   info = transparent,
--   info_visible = transparent,
--   info_selected = transparent,
--   info_diagnostic = transparent,
--   info_diagnostic_visible = transparent,
--   info_diagnostic_selected = transparent,
--   warning = transparent,
--   warning_visible = transparent,
--   warning_selected = transparent,
--   warning_diagnostic = transparent,
--   warning_diagnostic_visible = transparent,
--   warning_diagnostic_selected = transparent,
--   error = transparent,
--   error_visible = transparent,
--   error_selected = transparent,
--   error_diagnostic = transparent,
--   error_diagnostic_visible = transparent,
--   error_diagnostic_selected = transparent,
--   modified = transparent,
--   modified_visible = transparent,
--   modified_selected = transparent,
--   duplicate_selected = transparent,
--   duplicate_visible = transparent,
--   duplicate = transparent,
--   separator_selected = transparent,
--   separator_visible = transparent,
--   separator = transparent,
--   indicator_selected = transparent,
--   pick_selected = transparent,
--   pick_visible = transparent,
--   pick = transparent,
--   offset_separator = transparent,
-- }

local setup = {
  -- highlights = hl,
  options = {
    mode = "buffers",
    numbers = "none",
    close_command = function(bufnr)
      require("mini.bufremove").delete(bufnr, false)
    end,
    right_mouse_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    buffer_close_icon = hvim.icons.UI.Close,
    close_icon = hvim.icons.UI.Close,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = diagnostics_indicator,
    indicator = {
      style = "underline", --"icon" | "underline" | "none",
    },
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "neo-tree",
        text = "Explorer",
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

  bufferline.setup { options = setup.options }
end

--stylua: ignore

return M
