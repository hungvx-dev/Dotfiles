local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  spec = {
    { import = "plugins.colorscheme" },
    { import = "plugins.util" },
    { import = "plugins.ui" },
    { import = "plugins.coding" },
    { import = "plugins.editor" },
  },
  install = {
    missing = true,
  },
  ui = {
    border = "rounded",
  },
  git = {
    timeout = 120,
  },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
  debug = false,
  defaults = {
    lazy = false,
    version = nil,
  },
}

require("lazy").setup(opts)
vim.keymap.set("n", "<Leader>l", "<cmd>Lazy<CR>")
