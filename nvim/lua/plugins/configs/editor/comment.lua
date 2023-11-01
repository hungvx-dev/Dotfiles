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
  local status_ok, nvim_comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

  nvim_comment.setup(M.opts)
end

return M
