vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.pack.add({
      {
        src = 'https://github.com/kylechui/nvim-surround',
        version = vim.version.range('4.*'),
      },
    })
    require('nvim-surround').setup()
  end,
})
