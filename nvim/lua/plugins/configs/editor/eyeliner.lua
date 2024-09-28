local M = {}

function M.setup()
  require("eyeliner").setup({
    highlight_on_key = true,
    default_keymaps = true,
    dim = true,
    max_length = 120,
    disabled_filetypes = { "neo-tree", "Trouble", "alpha", "notify" },
    disable_buftypes = { "terminal", "nofile" },
  })
end

return M
