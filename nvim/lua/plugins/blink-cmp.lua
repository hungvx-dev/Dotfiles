return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  enabled = HVIM.blink,
  version = "*",
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = "enter",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      trigger = {
        show_on_accept_on_trigger_character = false,
        show_on_insert_on_trigger_character = true,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = true },
    },
    signature = {
      enabled = false,
      window = { border = "rounded" },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
