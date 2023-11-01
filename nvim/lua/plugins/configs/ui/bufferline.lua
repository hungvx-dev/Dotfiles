local M = {}

function M.diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = HVIM.icons.Diagnostics.BoldError,
    warning = HVIM.icons.Diagnostics.BoldWarning,
    info = HVIM.icons.Diagnostics.BoldInformation,
    hint = HVIM.icons.Diagnostics.BoldHint,
  }
  if not HVIM.use_icons then
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

M.opts = {
  options = {
    mode                         = "buffers",
    numbers                      = "none",
    close_command                = function(bufnr)
      require("mini.bufremove").delete(bufnr, false)
    end,
    right_mouse_command          = function(n)
      require("mini.bufremove").delete(n, false)
    end,
    buffer_close_icon            = HVIM.icons.UI.Close,
    close_icon                   = HVIM.icons.UI.Close,
    diagnostics                  = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator        = M.diagnostics_indicator,
    indicator                    = {
      style = "underline", --"icon" | "underline" | "none",
    },
    separator_style              = { HVIM.icons.UI.Line.Right, HVIM.icons.UI.Line.Right },
    offsets                      = {
      {
        filetype  = "undotree",
        text      = "Undotree",
        highlight = "PanelHeading",
        padding   = 1,
      },
      {
        filetype   = "neo-tree",
        text       = "Explorer",
        highlight  = "Directory",
        text_align = "left",
      },
      {
        filetype  = "DiffviewFiles",
        text      = "Diff View",
        highlight = "PanelHeading",
        padding   = 1,
      },
      {
        filetype  = "lazy",
        text      = "Lazy",
        highlight = "PanelHeading",
        padding   = 1,
      },
    },
  },
}

M.setup = function()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup(M.opts)
end

return M
