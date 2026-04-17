local conform = require('plugins.conform')

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.pack.add({
      'https://github.com/mason-org/mason.nvim',
      'https://github.com/stevearc/conform.nvim',
    })
    require('conform').setup(conform.opts)

    vim.keymap.set(
      { 'n', 'v' },
      'gf',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end
    )
  end,
})
