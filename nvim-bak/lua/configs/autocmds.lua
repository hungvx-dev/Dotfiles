vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf", "help", "netrw", "terminal", "scratch", "diffthis" },
  callback = function()
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
  end,
})

vim.api.nvim_create_user_command('HLLinksTo', function(opts)
  local target = opts.args
  local found = {}
  for _, group in ipairs(vim.fn.getcompletion('', 'highlight')) do
    local info = vim.api.nvim_get_hl(0, { name = group, link = true })
    if info.link == target then
      table.insert(found, group)
    end
  end

  if #found == 0 then
    print("No highlight groups link to '" .. target .. "'.")
  else
    print("Highlight groups linking to '" .. target .. "':")
    for _, name in ipairs(found) do
      print("  " .. name)
    end
  end
end, {
  nargs = 1,
  complete = function(_, _, _)
    return vim.fn.getcompletion('', 'highlight')
  end,
  desc = 'List all highlight groups that link to the given group',
})
