local function bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

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
  event = { "BufReadPost", "BufNewFile" },
  version = "*",
  dependencies = { "mini.icons" },
  keys = {
    -- { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    -- { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    -- { "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "Next Buffer" },
    { "<leader>bd", bufremove, desc = "Delete Buffer" },
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
    vim.o.showtabline = 2 -- always show buffers/tabs
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    -- vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
    --   callback = function()
    --     vim.schedule(function()
    --       pcall(nvim_bufferline)
    --     end)
    --   end,
    -- })
  end,
}
