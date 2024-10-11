local M = {}

M.source_mapping = {
  nvim_lsp = HVIM.icons.Cmp.Lsp .. "LSP",
  buffer = HVIM.icons.Cmp.Buffer .. "Buffer",
  luasnip = HVIM.icons.Cmp.Snippet .. "Snippet",
  path = HVIM.icons.Cmp.Path .. "Path",
  -- cmp_tabnine = HVIM.icons.Cmp.Tabnine .. "Tabnine",
  -- spell = HVIM.icons.Cmp.Spellcheck .. "Spell",
}

M.duplicates = {
  buffer = 1,
  path = 1,
  nvim_lsp = 1,
  luasnip = 1,
}

function M.opts()
  local cmp = require("cmp")
  local cmp_window = require("cmp.config.window")
  local defaults = require("cmp.config.default")()
  local luasnip = require("luasnip")

  require("luasnip.loaders.from_vscode").lazy_load()

  return {
    completion = {
      completeopt = "menu,menuone,preview",
    },
    preselect = cmp.PreselectMode.Item,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-CR>"] = cmp.mapping.abort(),
    }),
    window = {
      completion = cmp_window.bordered({
        winhighlight = "FloatBorder:Pmenu",
      }),
      documentation = cmp_window.bordered({
        winhighlight = "FloatBorder:Pmenu",
      }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 9 },
      { name = "luasnip", priority = 6, max_item_count = 10 },
      { name = "path", priority = 4 },
    }, {
      { name = "buffer", priority = 5, keywork_length = 5, max_item_count = 6 },
    }),
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, item)
        item.kind = HVIM.icons.Kind[item.kind] .. item.kind
        item.menu = M.source_mapping[entry.source.name]
        return item
      end,
    },
    sorting = defaults.sorting,
    cmdline = {
      enable = true,
      options = {
        {
          type = ":",
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
        },
        {
          type = { "/", "?" },
          sources = {
            { name = "buffer" },
          },
        },
      },
    },
  }
end

function M.setup()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end

  local opts = M.opts()

  for _, source in ipairs(opts.sources) do
    source.group_index = source.group_index or 1
  end

  cmp.setup(opts)

  if opts.cmdline.enable then
    for _, option in ipairs(opts.cmdline.options) do
      cmp.setup.cmdline(option.type, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = option.sources,
      })
    end
  end
end

return M
