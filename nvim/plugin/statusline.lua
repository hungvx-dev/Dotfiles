local statusline = require('plugins.statusline')

if type(statusline.init) == 'function' then statusline.init() end

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.cmd('packadd statusline')
      require('statusline').setup({})
    end)
  end,
})
