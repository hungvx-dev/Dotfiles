if HVIM.plugins.git then
  local git = require('plugins.git')

  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
    once = true,
    callback = function()
      vim.pack.add({
        {
          src = 'https://github.com/lewis6991/gitsigns.nvim',
          version = vim.version.range('*'),
        },
      })
      require('gitsigns').setup(git.opts)
    end,
  })
end
