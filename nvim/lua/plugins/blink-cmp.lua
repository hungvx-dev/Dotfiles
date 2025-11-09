local source_mapping = {
  LSP = HVIM.icons.Cmp.Lsp,
  Path = HVIM.icons.Cmp.Path,
  Snippets = HVIM.icons.Cmp.Snippet,
  Cmdline = HVIM.icons.Cmp.CmpLine,
  Buffer = HVIM.icons.Cmp.Buffer,
  Color = HVIM.icons.Cmp.Color,
}
return {
  {
    "saghen/blink.cmp",
    enabled = HVIM.plugins.blink_cmp,
    event = { "InsertEnter", "CmdlineChanged", "CmdlineEnter" },
    version = "*",
    -- build = "cargo build --release",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "xzbdmw/colorful-menu.nvim",
        opts = {},
      },
    },
    opts = {
      completion = {
        keyword = { range = "full" },
        accept = {
          auto_brackets = { enabled = true },
        },
        list = {
          selection = { preselect = false, auto_insert = true },
          cycle = { from_top = true },
        },
        menu = {
          -- border = "rounded",
          max_height = 15,
          draw = {
            align_to = "none",
            columns = { { "source_name" }, { "label" }, { "kind_icon", "kind", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = {
          -- window = { border = "rounded" },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = { name = source_mapping.LSP },
          path = { name = source_mapping.Path },
          snippets = { name = source_mapping.Snippets },
          buffer = { name = source_mapping.Buffer },
          cmdline = { name = source_mapping.Cmdline },
        },
      },
      snippets = { preset = "default" },
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "default",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "show", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        completion = {
          menu = { auto_show = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
          ghost_text = { enabled = false },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        -- nerd_font_variant = "normal",
        kind_icons = HVIM.icons.Kind,
      },
      fuzzy = { implementation = "rust" },
      signature = {
        enabled = true,
        -- window = { border = "rounded" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
