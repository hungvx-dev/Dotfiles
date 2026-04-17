local lsp = require('plugins.lsp')

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.cmd('packadd lsp')
    require('lsp').setup(lsp.opts)
  end,
})

local lsp_file_ops_loaded = false
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    if lsp_file_ops_loaded then return end
    lsp_file_ops_loaded = true

    vim.pack.add({
      { src = 'https://github.com/nvim-lua/plenary.nvim' },
      { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
      { src = 'https://github.com/antosha417/nvim-lsp-file-operations' },
    })

    require('lsp-file-operations').setup({
      operations = {
        willRenameFiles = true,
        didRenameFiles = true,
        willCreateFiles = true,
        didCreateFiles = true,
        willDeleteFiles = true,
        didDeleteFiles = true,
      },
    })
  end,
})
