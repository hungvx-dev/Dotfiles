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
  enabled = not HVIM.plugins.buffer and HVIM.plugins.bufferline,
  -- event = "BufWinEnter",
  event = "VeryLazy",
  version = "*",
  dependencies = { "mini.icons" },
  keys = {
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "Next Buffer" },
    { "<leader>bd", HVIM.ui.bufremove, desc = "Delete Buffer" },
  },
  init = function()
    vim.o.showtabline = 0
  end,
  opts = {
    options = {
      -- mode = "buffers",
      -- numbers = "none",
      -- themable = true,
      close_command = HVIM.ui.bufremove,
      right_mouse_command = HVIM.ui.bufremove,
      buffer_close_icon = HVIM.icons.UI.Close,
      close_icon = HVIM.icons.UI.Close,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = diagnostics_indicator,
      indicator = {
        style = "underline", --"icon" | "underline" | "none", },
      },
      separator_style = { "|", "|" },
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
  config = function(_, opts)
    vim.o.showtabline = 2           -- always show buffers/tabs
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
