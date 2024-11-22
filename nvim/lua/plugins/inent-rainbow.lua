return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
        opts.indent.highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        }

        local hooks = require("ibl.hooks")
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          for i, hi in ipairs(opts.indent.highlight) do
            vim.api.nvim_set_hl(0, hi, { fg = HVIM.ui.colors[i] })
          end
        end)
        vim.g.rainbow_delimiters = { highlight = opts.indent.highlight }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      end
      require("ibl").setup(opts)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter" },
    opts = function()
      return {
        query = {
          javascript = "rainbow-parens",
          vue = "rainbow-script",
          tsx = "rainbow-parens",
          html = "rainbow-parens",
        },
      }
    end,
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
