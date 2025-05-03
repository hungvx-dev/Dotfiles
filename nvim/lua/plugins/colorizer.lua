return {
  {
    "catgoose/nvim-colorizer.lua",
    enabled = true,
    event = "VeryLazy",
    opts = {
      filetypes = {
        "*",
        css = { rgb_fn = true, hsl_fn = true },
        -- "html",
        -- "css",
        -- "javascript",
        -- "typescript",
        -- "typescriptreact",
        -- "javascriptreact",
        -- "lua",
        -- "scss",
        -- "conf",
        -- "fish",
        -- "yml",
        -- "vue",
        -- "php",
      },
      -- buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
      -- Boolean | List of usercommands to enable.  See User commands section.
      -- user_commands = true, -- Enable all or some usercommands
      lazy_load = true, -- Lazily schedule buffer highlighting setup function
      user_default_options = {
        names = false,
        RRGGBB = true,
        -- rgb_fn = true,
        -- hsl_fn = true,
        tailwind = "lsp",
        -- tailwind_opts = {
        --   update_names = true,
        -- },
        mode = "virtualtext",
        virtualtext = "",
        virtualtext_inline = "before",
        virtualtext_mode = "foreground",
      },
    },
  },
}
