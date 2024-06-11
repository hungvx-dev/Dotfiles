local M = {}
M.opts = {
  exclude = {
    filetypes = {
      "lazy",
      "neo-tree",
      "mason",
      "help",
      "alpha",
      "dashboard",
      "Trouble",
      "trouble",
      "notify",
      "toggleterm",
      "lazyterm",
    },
  },
  indent = { char = HVIM.icons.UI.Line.Left },
}

M.setup = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

  indent_blankline.setup(M.opts)
end

return M
