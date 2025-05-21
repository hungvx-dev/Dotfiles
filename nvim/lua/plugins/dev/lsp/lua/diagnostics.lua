local keymap = vim.keymap
local M = {}

M.diagnostics_virtual_lines = false
M.augroup_id = vim.api.nvim_create_augroup("diagnostics", { clear = true })

function M.set_virtual_lines(enabled)
  vim.diagnostic.config({ virtual_lines = (enabled and { current_line = true } or false) })
  M.diagnostics_virtual_lines = enabled
end

function M.enable_diagnostics()
  M.set_virtual_lines(true)
  vim.api.nvim_clear_autocmds({ group = M.augroup_id, event = "CursorMoved" })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = M.augroup_id,
    once = true,
    callback = function()
      M.set_virtual_lines(false)
    end,
  })
end

function M.disable_diagnostics()
  M.set_virtual_lines(false)
  vim.api.nvim_clear_autocmds({ group = M.augroup_id, event = "CursorMoved" })
end

function M.toggle_diagnostics()
  if M.diagnostics_virtual_lines then
    M.disable_diagnostics()
  else
    M.enable_diagnostics()
  end
end

function M.jump_with_diagnostics(jumpCount)
  vim.diagnostic.jump({ count = jumpCount })
  vim.defer_fn(M.enable_diagnostics, 1)
end

function M.open_float()
  vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
end

---@param diagnostic vim.diagnostic.Opts
function M.config_diagnostic(diagnostic)
  vim.diagnostic.config(diagnostic)

  -- keymap.set("n", "!", toggle_diagnostics)
  keymap.set("n", "[d", function()
    M.jump_with_diagnostics(-1)
  end)
  keymap.set("n", "]d", function()
    M.jump_with_diagnostics(1)
  end)
  keymap.set("n", "!", vim.diagnostic.open_float)
  -- keymap.set("n", "!", M.open_float)
  keymap.set("n", "<space>q", vim.diagnostic.setloclist)
end

return M
