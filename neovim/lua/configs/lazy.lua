local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
local opts = {
    install = {
        missing = true
    },
    ui = {
        border = "rounded"
    },
    git = {
        timeout = 120
    },
    performance = {
        rtp = {
            disabled_plugins = {"gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin"}
        }
    },
    debug = false,
    defaults = {
        lazy = false,
        version = nil
    }
}

require("lazy").setup(plugins, opts)
vim.keymap.set('n', '<Leader>l', '<cmd>Lazy<CR>')
