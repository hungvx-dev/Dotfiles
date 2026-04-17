vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() > 0 then return end

    local buf = vim.api.nvim_get_current_buf()

    -- mark buffer
    vim.bo[buf].filetype = 'intro'
  end,
})
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     if vim.fn.argc() > 0 then return end
--
--     local set = function(opt, val) vim.api.nvim_set_option_value(opt, val, { scope = 'local' }) end
--     set('bufhidden', 'wipe')
--     set('buflisted', false)
--     set('matchpairs', '')
--     set('swapfile', false)
--     set('buftype', 'nofile')
--     set('filetype', 'alpha')
--     set('synmaxcol', 0)
--     set('wrap', false)
--     set('colorcolumn', '')
--     set('foldcolumn', '0')
--     set('cursorcolumn', false)
--     set('cursorline', false)
--     set('number', false)
--     set('relativenumber', false)
--     set('list', false)
--     set('spell', false)
--     set('signcolumn', 'no')
--   end,
-- })
--
