vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    vim.pack.add({
      { src = 'https://github.com/j-hui/fidget.nvim' },
    })

    require('fidget').setup({
      notification = {
        window = {
          border = 'rounded',
          winblend = 0,
        },
      },
      integration = {
        ['neo-tree'] = {
          enable = true,
        },
      },
    })
  end,
})
