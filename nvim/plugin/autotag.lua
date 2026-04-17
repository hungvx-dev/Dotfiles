local autotag = require('plugins.autotag')

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  pattern = { 'html', 'typescriptreact', 'vue' },
  callback = function()
    vim.pack.add({ 'https://github.com/windwp/nvim-ts-autotag' })
    require('nvim-ts-autotag').setup(autotag.opts)
  end,
})
