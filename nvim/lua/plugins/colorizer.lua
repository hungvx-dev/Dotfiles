return {
  opts = {
    filetypes = {
      css = { rgb_fn = true, hsl_fn = true },
      'fzf',
      'html',
      'typescript',
      'typescriptreact',
      'lua',
      'scss',
      'conf',
      'fish',
      'yml',
      'vue',
    },
    lazy_load = true,
    options = {
      parsers = {
        css = false,
        css_fn = false,
        names = {
          enable = false,
          lowercase = true,
          uppercase = false,
          camelcase = false,
          strip_digits = false,
          custom = false,
        },
        hex = {
          default = false,
          rgb = false,
          rgba = false,
          rrggbb = true,
          rrggbbaa = false,
          aarrggbb = false,
        },
        rgb = { enable = false },
        hsl = { enable = false },
        oklch = { enable = true },
        tailwind = {
          enable = true,
          lsp = false,
          update_names = false,
        },
        sass = {
          enable = false,
          parsers = { css = true },
          variable_pattern = '^%$([%w_-]+)',
        },
        xterm = { enable = false },
      },
      display = {
        mode = 'virtualtext',
        virtualtext = {
          char = HVIM.icons.Cmp.Color,
          position = 'before',
          hl_mode = 'foreground',
        },
      },
    },
  },
}
