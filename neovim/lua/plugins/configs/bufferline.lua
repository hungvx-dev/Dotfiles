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

local setup = {
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
return M
