if HVIM.plugins.blink_cmp then
  local cmp = require('plugins.blink-cmp')

  vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineChanged', 'CmdlineEnter' }, {
    once = true,
    callback = function()
      vim.pack.add({
        'https://github.com/rafamadriz/friendly-snippets',
        'https://github.com/saghen/blink.lib',
        'https://github.com/xzbdmw/colorful-menu.nvim',
        {
          src = 'https://github.com/saghen/blink.cmp',
          version = vim.version.range('*'),
        },
      })
      require('colorful-menu').setup()
      require('blink.cmp').setup(cmp.opts)
    end,
  })
end
