local autocmd = vim.api.nvim_create_autocmd

local function augroup(name) return vim.api.nvim_create_augroup('hungvx_' .. name, { clear = true }) end

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function() vim.hl.on_yank({ timeout = 300 }) end,
  desc = 'Highlight when yanking',
})

autocmd('FileType', {
  pattern = { 'lua', 'javascript', 'typescript', 'cpp', 'rust', 'go', 'luau', 'vue' },
  group = augroup('new_line_comment'),
  callback = function() vim.opt_local.formatoptions:remove({ 'o' }) end,
  desc = 'Disable New Line Comment',
})

autocmd('VimResized', {
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd = | tabnext ' .. current_tab)
  end,
  desc = 'Equalize Splits',
})

autocmd('FileType', {
  pattern = { 'qf', 'help', 'netrw', 'terminal', 'scratch', 'diffthis' },
  callback = function()
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'wipe'
    vim.bo.swapfile = false
  end,
})

vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
	-- checks if any argument is passed
    if opts.args:match("%S") then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		-- update only specified plugins
        vim.pack.update(plugins)
    else
        -- update all
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })
