if HVIM.plugins.bufferline then
  local bufferline = require('plugins.bufferline')
  vim.pack.add({
    'https://github.com/echasnovski/mini.icons',
    {
      src = 'https://github.com/akinsho/bufferline.nvim',
      version = vim.version.range('*'),
    },
  })

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    once = true,
    callback = function()
      vim.o.showtabline = 2
      require('bufferline').setup(bufferline.opts)

      vim.keymap.set('n', '<leader>bd', bufferline.keys.bufremove, { desc = 'Delete Buffer' })
    end,
  })
end
