local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  -- install = { missing = true },
  ui = { border = "rounded" },
  git = { timeout = 120 },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
  rocks = {
    enabled = true,
    root = vim.fn.stdpath("data") .. "/lazy-rocks",
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
    hererocks = false,
  },
  dev = {
    path = "~/.config/nvim/lua/plugins/dev",
  },
  debug = false,
  defaults = { lazy = true, version = nil },
  change_detection = { notify = false },
  checker = { enabled = true, notify = true },
}

require("lazy").setup("plugins", opts)
vim.keymap.set("n", "<Leader>l", "<cmd>Lazy<CR>")

vim.cmd.colorscheme(HVIM.colorscheme)
