if HVIM.plugins.statuscol then
  local statuscol = require('plugins.statuscol')

  vim.api.nvim_create_autocmd('BufWinEnter', {
    once = true,
    callback = function()
      vim.schedule(function()
        vim.cmd('packadd statuscol')
        require('statuscol').setup(statuscol.opts)
      end)
    end,
  })
end
