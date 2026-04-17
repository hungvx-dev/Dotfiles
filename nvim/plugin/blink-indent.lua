if HVIM.plugins.blink_indent then
  local indent = require('plugins.blink-indent')

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
    once = true,
    callback = function()
      vim.pack.add({
        {
          src = 'https://github.com/saghen/blink.indent',
          version = vim.version.range('*'),
        },
      })
      require('blink.indent').setup(indent.opts)
    end,
  })
end
