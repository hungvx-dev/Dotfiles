local opts = require('plugins.mason')

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })
      require('mason').setup(opts)

      local registry = require('mason-registry')
      registry:on('package:install:success', function()
        vim.defer_fn(
          function()
            require('lazy.core.handler.event').trigger({
              event = 'FileType',
              buf = vim.api.nvim_get_current_buf(),
            })
          end,
          100
        )
      end)

      registry.refresh(function()
        for _, name in ipairs(opts.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok then
            if not pkg:is_installed() then pkg:install() end
          end
        end
      end)
    end)
  end,
})
