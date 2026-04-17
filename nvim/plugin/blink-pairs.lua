if HVIM.plugins.blink_pairs then
  local pairs = require('plugins.blink-pairs')

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
    once = true,
    callback = function()
      vim.pack.add({
        'https://github.com/saghen/blink.download',
        {
          src = 'https://github.com/saghen/blink.pairs',
          version = vim.version.range('*'),
        },
      })

      require('blink.pairs').setup(pairs.opts)
    end,
  })
end
