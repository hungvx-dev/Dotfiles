local M = {}

function M.setup()
  require("eyeliner").setup({
    highlight_on_key = true,
    default_keymaps = true,
    dim = true,
    max_length = 100,
    disabled_filetypes = { "Trouble", "alpha", "notify", "neo-tree", "help" },
    disabled_buftypes = { "terminal", "nofile" },
  })
end

return M
