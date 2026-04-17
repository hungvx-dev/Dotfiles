vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePre' }, {
  once = true,
  callback = function()
    vim.pack.add({
      { src = 'https://github.com/echasnovski/mini.comment' },
      { src = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' },
      { src = 'https://github.com/folke/todo-comments.nvim' },
    })

    require('mini.comment').setup({
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })
    require('ts_context_commentstring').setup({
      enable_autocmd = false,
    })

    -- FIX: Fix
    -- TODO: Todo
    -- HACK: Hack
    -- WARN: Warn
    -- PERF: Perf
    -- NOTE: Note
    -- TEST: Test
    require('todo-comments').setup({
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = HVIM.icons.Comment.Fix },
        TODO = { icon = HVIM.icons.Comment.Todo },
        HACK = { icon = HVIM.icons.Comment.Hack, color = 'hack' },
        WARN = { icon = HVIM.icons.Comment.Warn },
        PERF = { icon = HVIM.icons.Comment.Perf },
        NOTE = { icon = HVIM.icons.Comment.Note },
        TEST = { icon = HVIM.icons.Comment.Test },
      },
      colors = {
        test = { '@comment.test' },
        hack = { '@comment.hack' },
      },
      highlight = {
        before = '',
        keyword = 'wide',
        after = 'fg',
        comments_only = true,
      },
    })

    vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
    vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })
  end,
})
