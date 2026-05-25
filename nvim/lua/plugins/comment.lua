return {
  mini_comment = {
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
  ts_context = {
      enable_autocmd = false,
  },
  todo_comment = {
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
  }
}
