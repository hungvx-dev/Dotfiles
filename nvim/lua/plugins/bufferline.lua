local function diagnostics_indicator(_, _, diagnostics, _)
  local result = {}
  for name, count in pairs(diagnostics) do
    if count > 0 then
      table.insert(result, HVIM.bold_signs[name] .. count)
    end
  end
  return #result > 0 and table.concat(result, " ") or ""
end

return {
  "akinsho/bufferline.nvim",
  enabled = false,
  event = { "VeryLazy" },
  version = "*",
  dependencies = { "mini.icons" },
  keys = {
    { "[b",         "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>bf", "<cmd>BufferLinePick<cr>",      desc = "Next Buffer" },
    { "<leader>bd", HVIM.ui.bufremove,              desc = "Delete Buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      -- stylua: ignore
      close_command = HVIM.ui.bufremove,
      -- stylua: ignore
      right_mouse_command = HVIM.ui.bufremove,
      buffer_close_icon = HVIM.icons.UI.Close,
      close_icon = HVIM.icons.UI.Close,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = diagnostics_indicator,
      indicator = {
        style = "underline",   --"icon" | "underline" | "none", },
      },
      separator_style = { "|", "|" },
      -- separator_style = { "", "" },
      offsets = {
        {
          filetype = "neo-tree",
          text = HVIM.icons.UI.Explorer .. "Explorer",
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
  },
}
