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
        opts = {
          vtsls = {
            extra_info_hl = "@comment",
          },
          ["rust-analyzer"] = {
            extra_info_hl = "@comment",
            align_type_to_right = true,
            preserve_type_when_truncate = true,
          },
        },
      },
    },
    opts = {
      snippets = { preset = "default" },
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
      keymap = {
        preset = "none",
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        -- ["<S-k>"] = { "show_signature", "fallback" },
      },
      completion = {
        documentation = {
          window = { border = "rounded" },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        keyword = { range = "full" },
        trigger = {
          show_on_accept_on_trigger_character = false,
          show_on_insert_on_trigger_character = true,
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        list = {
          selection = { preselect = false, auto_insert = true },
          cycle = { from_top = true },
        },
        ghost_text = { enabled = false },
        menu = {
          border = "rounded",
          max_height = 15,
          draw = {
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
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "default",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "snippet_forward", "show", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
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
        window = { border = "rounded" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
