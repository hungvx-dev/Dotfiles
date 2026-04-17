return {
  {
    "catgoose/nvim-colorizer.lua",
    enabled = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      filetypes = {
        -- "*",
        css = { rgb_fn = true, hsl_fn = true },
        "fzf",
        "html",
        -- "css",
        -- "javascript",
        "typescript",
        "typescriptreact",
        -- "javascriptreact",
        "lua",
        "scss",
        "conf",
        "fish",
        "yml",
        "vue",
      },
      lazy_load = true, -- Lazily schedule buffer highlighting setup function
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
            custom = false, -- table|function|false
          },
          hex = {
            default = false, -- default value for format keys (see above)
            rgb = false, -- #RGB
            rgba = false, -- #RGBA
            rrggbb = true, -- #RRGGBB
            rrggbbaa = false, -- #RRGGBBAA
            aarrggbb = false, -- 0xAARRGGBB
          },
          rgb = { enable = false },
          hsl = { enable = false },
          oklch = { enable = true },
          tailwind = {
            enable = true, -- parse Tailwind color names
            lsp = false, -- use Tailwind LSP documentColor
            update_names = false,
          },
          sass = {
            enable = false,
            parsers = { css = true },
            variable_pattern = "^%$([%w_-]+)",
          },
          xterm = { enable = false },
        },
        display = {
          mode = "virtualtext",
          virtualtext = {
            char = HVIM.icons.Cmp.Color,
            position = "before", -- "eol"|"before"|"after"
            hl_mode = "foreground",
          },
        },
      },
    },
  },
}
