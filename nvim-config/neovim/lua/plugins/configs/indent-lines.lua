local M = {}
local opts = {
  exclude = { filetypes = { "lazy", "neo-tree", "mason", "alpha", "dashboard" } },
  indent = { char = hvim.icons.UI.Line.Left },
}

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

  indent_blankline.setup(opts)
end

return M
