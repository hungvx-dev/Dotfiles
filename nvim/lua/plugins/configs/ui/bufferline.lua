local M = {}

M.keys = {
  { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  { "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "Next Buffer" },
  { "<leader>bd", HVIM.ui.bufremove, desc = "Delete Buffer" },
}

function M.diagnostics_indicator(_, _, diagnostics, _)
  local result = {}
  for name, count in pairs(diagnostics) do
    if count > 0 then
      table.insert(result, HVIM.bold_signs[name] .. count)
    end
  end
  return #result > 0 and table.concat(result, " ") or ""
end

M.opts = {
  options = {
    mode = "buffers",
    numbers = "none",
    -- stylua: ignore
    close_command = function(n) HVIM.ui.bufremove(n) end,
    -- stylua: ignore
    right_mouse_command = function(n) HVIM.ui.bufremove(n) end,
    buffer_close_icon = HVIM.icons.UI.Close,
    close_icon = HVIM.icons.UI.Close,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = M.diagnostics_indicator,
    indicator = {
      style = "underline", --"icon" | "underline" | "none", },
    },
    separator_style = { "|", "|" },
    -- separator_style = { "", "" },
    offsets = {
      {
        filetype = "neo-tree",
        text = " " .. HVIM.icons.UI.Explorer .. "Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
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

return M
