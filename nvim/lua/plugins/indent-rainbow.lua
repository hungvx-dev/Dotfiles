local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost" },
    dependencies = { "nvim-treesitter" },
    opts = {
      exclude = {
        filetypes = {
          "lazy",
          "neo-tree",
          "mason",
          "help",
          "alpha",
          "dashboard",
          "Trouble",
          "trouble",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
      indent = {
        char = HVIM.icons.UI.Line.Left,
      },
    },
    config = function(_, opts)
      if HVIM.highlight.indent then
        opts.scope = { highlight = highlight }
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          for i, hi in ipairs(highlight) do
            vim.api.nvim_set_hl(0, hi, { fg = HVIM.ui.colors[i] })
          end
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      end

      require("ibl").setup(opts)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter" },
    opts = {
      query = {
        javascript = "rainbow-parens",
        tsx = "rainbow-parens",
        -- vue = "rainbow-script",
      },
    },
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
