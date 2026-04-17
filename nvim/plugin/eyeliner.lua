if HVIM.plugins.eyeliner then
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    once = true,
    callback = function()
      vim.pack.add({
        { src = 'https://github.com/jinh0/eyeliner.nvim' },
      })
      require('eyeliner').setup({
        highlight_on_key = true,
        default_keymaps = true,
        dim = true,
        max_length = 100,
        disabled_filetypes = { 'alpha', 'neo-tree', 'fzf', 'mason', 'lazy' },
        disabled_buftypes = { 'terminal', 'nofile', 'prompt', 'help', 'quickfix' },
      })
    end,
  })
end
