local M = {}

M.opts = {
  pre_hook = function(...)
    local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
    if loaded and ts_comment then
      return ts_comment.create_pre_hook()(...)
    end
  end,
}

function M.setup()
  local comment = require("Comment")

  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })
  local get_option = vim.filetype.get_option

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
  end

  comment.setup(M.opts)
end

return M
