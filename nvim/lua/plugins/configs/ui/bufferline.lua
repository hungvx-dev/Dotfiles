local M = {}

M.keys = {
  { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
  { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
}

function M.diagnostics_indicator(_, _, diagnostics, _)
  local result = {}
  for name, count in pairs(diagnostics) do
    if count > 0 then
      table.insert(result, HVIM.bold_signs[name] .. " " .. count)
    end
  end
  return #result > 0 and table.concat(result, " ") or ""
end

function M.opts()
  local mini_bufremove = require("mini.bufremove")
  return {
    options = {
      mode = "buffers",
      numbers = "none",
      close_command = function(bufnr)
        mini_bufremove.delete(bufnr, false)
      end,
      right_mouse_command = function(n)
        mini_bufremove.delete(n, false)
      end,
      buffer_close_icon = HVIM.icons.UI.Close,
      close_icon = HVIM.icons.UI.Close,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = M.diagnostics_indicator,
      indicator = {
        style = "underline", --"icon" | "underline" | "none",
      },
      separator_style = { HVIM.icons.UI.Line.Right, HVIM.icons.UI.Line.Right },
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
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 1,
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
end

M.setup = function()
  require("bufferline").setup(M.opts())
end

return M
