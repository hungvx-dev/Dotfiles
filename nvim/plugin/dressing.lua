local dressing = require('plugins.dressing')

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/stevearc/dressing.nvim' })

    require('dressing').setup(dressing.opts)
  end,
})
