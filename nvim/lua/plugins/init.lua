vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    local icons = require('plugins.mini-icons')
    local treesitter = require('plugins.treesitter')
    local fzf = require('plugins.fzf')

    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end

    local statusline = require('plugins.statusline')
    if type(statusline.init) == 'function' then statusline.init() end

    require('mini.icons').setup(icons.opts)
    require('fzf-lua').setup(fzf.opts)

    vim.schedule(function()
      local neotree = require('plugins.neotree')
      local window_picker = require('plugins.window-picker')
      local mason = require('plugins.mason')
      local statuscol = require('plugins.statuscol')
      local textobjects = require('plugins.treesitter-textobjects')

      if type(neotree.init) == 'function' then neotree.init() end

      require('neo-tree').setup(neotree.opts)
      require('window-picker').setup(window_picker.opts)
      require('mason').setup(mason)
      vim.cmd('packadd statuscol')
      require('statuscol').setup(statuscol.opts)
      require('tree-sitter-manager').setup(treesitter.opts)
      require('nvim-treesitter-textobjects').setup(textobjects.opts)

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
        for _, name in ipairs(mason.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok then
            if not pkg:is_installed() then pkg:install() end
          end
        end
      end)
    end)

    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, function() vim.cmd(rhs) end, { desc = desc })
    end
    local select = require('nvim-treesitter-textobjects.select')
    local function mapxo(lhs, query)
      vim.keymap.set({ 'x', 'o' }, lhs, function() select.select_textobject(query, 'textobjects') end)
    end

    -- Files & buffers
    map('<leader>fb', 'FzfLua buffers sort_mru=true sort_lastused=true', 'Buffers')
    map('<leader>fp', 'FzfLua files', 'Find Files')
    map('<leader>fo', 'FzfLua oldfiles', 'Recent')
    map('<leader>fh', 'FzfLua history', 'History')

    -- Search
    map('<leader>fs', 'FzfLua live_grep', 'Grep')
    map('<leader>fS', 'FzfLua live_grep resume=true', 'Grep resume')
    map('<leader>fi', 'FzfLua grep_curbuf', 'Buffer')

    map('<leader>fd', 'FzfLua diagnostics_document', 'Diagnostics')
    map('<leader>fk', 'FzfLua keymaps', 'Keymaps')
    map('<leader>fH', 'FzfLua highlights', 'Highlights')
    map('<leader>fm', 'FzfLua marks', 'Marks')
    map('<leader>f:', 'FzfLua command_history', 'Command history')

    -- Git
    map('<leader>fgs', 'FzfLua git_status', 'Git status')
    map('<leader>fgb', 'FzfLua git_branches', 'Git branches')

    -- LSP
    map('<leader>fl', 'FzfLua lsp_document_symbols', 'LSP symbols')

    -- function
    mapxo('af', '@function.outer')
    mapxo('if', '@function.inner')

    -- class
    mapxo('ac', '@class.outer')
    mapxo('ic', '@class.inner')

    -- parameter
    mapxo('aa', '@parameter.outer')
    mapxo('ia', '@parameter.inner')

    -- conditional
    mapxo('ai', '@conditional.outer')
    mapxo('ii', '@conditional.inner')

    -- loop
    mapxo('al', '@loop.outer')
    mapxo('il', '@loop.inner')

    -- statement
    mapxo('as', '@statement.outer')

    vim.keymap.set('n', '<leader>e', function() require('neo-tree.command').execute({ toggle = true }) end)

    vim.keymap.set('n', '<leader>n', function() require('neo-tree.command').execute({ focus = true }) end)
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    local bufferline = require('plugins.bufferline')
    local dressing = require('plugins.dressing')
    local eyeliner = require('plugins.eyeliner')
    local statusline = require('plugins.statusline')
    local autotag = require('plugins.autotag')
    local conform = require('plugins.conform')
    vim.cmd('packadd statusline')

    vim.o.showtabline = 2
    require('bufferline').setup(bufferline.opts)
    require('dressing').setup(dressing.opts)
    require('nvim-surround').setup()
    require('statusline').setup(statusline.opts)
    require('nvim-ts-autotag').setup(autotag.opts)
      require('eyeliner').setup()
    require('conform').setup(conform.opts)

    vim.keymap.set('n', '<leader>bd', bufferline.keys.bufremove, { desc = 'Delete Buffer' })

    vim.keymap.set(
      { 'n', 'v' },
      'gf',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end
    )
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
  once = true,
  callback = function()
    local indent = require('plugins.blink-indent')
    local pairs = require('plugins.blink-pairs')
    local colorizer = require('plugins.colorizer')
    local comment = require('plugins.comment')
    local git = require('plugins.git')

    require('blink.indent').setup(indent.opts)
    require('blink.pairs').setup(pairs.opts)
    require('colorizer').setup(colorizer.opts)
    require('gitsigns').setup(git.opts)
    require('mini.comment').setup(comment.mini_comment)
    require('ts_context_commentstring').setup(comment.ts_context)
    require('todo-comments').setup(comment.todo_comment)

    vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })
  end,
})


vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  pattern = { '*.html', '*.tsx', '*.vue' },
  callback = function()
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineChanged', 'CmdlineEnter' }, {
  once = true,
  callback = function()
    local cmp = require('plugins.blink-cmp')

    require('colorful-menu').setup()
    require('blink.cmp').setup(cmp.opts)
  end,
})

local lsp_file_ops_loaded = false
vim.api.nvim_create_autocmd('LspAttach', {
  once = true,
  callback = function()
    local fidget = require('plugins.fidget')
    local lsp = require('plugins.lsp')

    vim.cmd('packadd lsp')

    require('lsp').setup(lsp.opts)
    require('fidget').setup(fidget.opts)

    if lsp_file_ops_loaded then return end
    lsp_file_ops_loaded = true
    local lsp_file = require('plugins.lsp-file')

    require('lsp-file-operations').setup(lsp_file.opts)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    local lang = vim.treesitter.language.get_lang(ft)
    if not lang then return end

    local ok_add = pcall(vim.treesitter.language.add, lang)
    if not ok_add then return end

    pcall(vim.treesitter.start, buf, lang)
  end,
})
