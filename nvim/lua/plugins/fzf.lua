return {
  opts = {
    'skim',
    fzf_bin = 'sk',
    defaults = {
      file_icons = 'mini',
      prompt = HVIM.icons.UI.Search,
      formatter = 'path.dirname_first',
    },
    winopts = {
      height = 0.9,
      width = 0.9,
      preview = {
        layout = 'vertical',
      },
    },
    files = {
      cwd_prompt = false,
      actions = false,
    },
    grep = {
      actions = false,
    },
    lsp = {
      cwd_only = true,
    },
    oldfiles = {
      cwd_only = true,
    },
    buffers = {
      cwd_only = true,
    },
    keymap = {
      builtin = {
        ['<C-f>'] = 'preview-page-down',
        ['<C-b>'] = 'preview-page-up',
        ['<C-d>'] = 'preview-down',
        ['<C-u>'] = 'preview-up',
      },
    },
  },
}
