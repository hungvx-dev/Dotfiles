local source_mapping = {
  LSP = HVIM.icons.Cmp.Lsp,
  Path = HVIM.icons.Cmp.Path,
  Snippets = HVIM.icons.Cmp.Snippet,
  cmdline = HVIM.icons.Cmp.CmpLine,
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
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
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
          draw = {
            columns = { { "source_name" }, { "label", gap = 1 }, { "kind__icons" } },
            components = {
              source_name = {
                ellipsis = false,
                text = function(ctx)
                  if ctx.kind == "Color" then
                    return HVIM.icons.Cmp.Color
                  end
                  return source_mapping[ctx.source_name]
                end,
                highlight = function(ctx)
                  return ctx.kind_hl
                end,
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  return highlights_info and highlights_info.label or ctx.label
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
              },
              kind__icons = {
                ellipsis = false,
                text = function(ctx)
                  return HVIM.icons.Kind[ctx.kind] .. ctx.kind
                end,
                highlight = function(ctx)
                  return ctx.kind_hl
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
        -- kind_icons = HVIM.icons.Kind,
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
