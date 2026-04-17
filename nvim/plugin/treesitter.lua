local treesitter = require('plugins.treesitter')
local textobjects = require('plugins.treesitter-textobjects')

vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter.opts.ensure_installed,
  callback = function()
    vim.wo[0][0].fdm = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
  once = true,
  callback = function()
    vim.schedule(function()
      vim.pack.add({
        'https://github.com/romus204/tree-sitter-manager.nvim',
        {
          src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
          version = 'main',
        },
      })

      require('tree-sitter-manager').setup(treesitter.opts)
      vim.g.no_plugin_maps = true
      require('nvim-treesitter-textobjects').setup(textobjects.opts)

      vim.keymap.set('n', '@', function() vim.cmd('Inspect') end)
      local select = require('nvim-treesitter-textobjects.select')
      local function map(lhs, query)
        vim.keymap.set({ 'x', 'o' }, lhs, function() select.select_textobject(query, 'textobjects') end)
      end

      -- function
      map('af', '@function.outer')
      map('if', '@function.inner')

      -- class
      map('ac', '@class.outer')
      map('ic', '@class.inner')

      -- parameter
      map('aa', '@parameter.outer')
      map('ia', '@parameter.inner')

      -- conditional
      map('ai', '@conditional.outer')
      map('ii', '@conditional.inner')

      -- loop
      map('al', '@loop.outer')
      map('il', '@loop.inner')

      -- statement
      map('as', '@statement.outer')
    end)
  end,
})
