local colorizer = require('plugins.colorizer')

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/catgoose/nvim-colorizer.lua' })
    require('colorizer').setup(colorizer.opts)
  end,
})
