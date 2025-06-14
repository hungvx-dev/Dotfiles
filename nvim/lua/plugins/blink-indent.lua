return {
  {
    "saghen/blink.indent",
    enabled = HVIM.plugins.blink_indent,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      blocked = {
        buftypes = { "terminal", "nofile", "prompt", "help", "quickfix" },
        filetypes = { "neo-tree", "alpha", "fzf", "help", "man", "mason", "lazy", "TelescopePrompt", "TelescopeResult", "lspinfo" },
      },
      static = {
        enabled = true,
        char = HVIM.icons.UI.Line.Left,
        priority = 1,
        highlights = { "BlinkIndent" },
      },
      scope = {
        enabled = true,
        char = HVIM.icons.UI.Line.Left,
        priority = 1024,
        highlights = {
          "BlinkIndentRed",
          "BlinkIndentYellow",
          "BlinkIndentBlue",
          "BlinkIndentOrange",
          "BlinkIndentGreen",
          "BlinkIndentViolet",
          "BlinkIndentCyan",
        },
        underline = {
          enabled = true,
          highlights = {
            "BlinkIndentRedUnderline",
            "BlinkIndentYellowUnderline",
            "BlinkIndentBlueUnderline",
            "BlinkIndentOrangeUnderline",
            "BlinkIndentGreenUnderline",
            "BlinkIndentVioletUnderline",
            "BlinkIndentCyanUnderline",
          },
        },
      },
      visible = true,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not HVIM.plugins.blink_indent,
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

      scope = {
        enabled = true,
        char = HVIM.icons.UI.Line.Left,
        include = {
          node_type = { ["*"] = { "*" } },
        },
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      },
      indent = {
        char = HVIM.icons.UI.Line.Left,
      },
    },
    config = function(_, opts)
      if HVIM.highlight.indent then
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          for i, hi in ipairs(opts.scope.highlight) do
            vim.api.nvim_set_hl(0, hi, { fg = HVIM.ui.colors[i] })
          end
        end)

        vim.g.rainbow_delimiters = { highlight = opts.scope.highlight }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      end

      require("ibl").setup(opts)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    enabled = not HVIM.plugins.blink_indent,
    event = { "BufReadPost", "BufNewFile" },
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
