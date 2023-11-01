local M = {}
M.opts = {
  signs = {
    add = { text = HVIM.icons.UI.Line.BoldMid },
    change = { text = HVIM.icons.UI.Line.BoldMid },
    delete = { text = HVIM.icons.UI.Line.BoldMid },
    topdelete = { text = HVIM.icons.UI.Line.BoldMid },
    changedelete = { text = HVIM.icons.UI.Line.BoldMid },
    untracked = { text = HVIM.icons.UI.Line.BoldMid },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 400,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = " <author_mail> | <author_time:%R, %x> | <summary>",
  preview_config = {
    -- Options passed to nvim_open_win
    border = "round",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

function M.setup()
  local status_ok, gitsigns = pcall(require, "gitsigns")
  if not status_ok then
    return
  end

  gitsigns.setup(M.opts)
end

return M
