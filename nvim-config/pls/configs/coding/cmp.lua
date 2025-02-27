local M = {}

M.keys = {
  {
    "<Tab>",
    function()
      return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
    end,
    expr = true,
    silent = true,
    mode = { "i", "s" },
  },
  {
    "<S-Tab>",
    function()
      return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
    end,
    expr = true,
    silent = true,
    mode = { "i", "s" },
  },
}

M.source_mapping = {
  nvim_lsp = HVIM.icons.Cmp.Lsp,
  buffer = HVIM.icons.Cmp.Buffer,
  luasnip = HVIM.icons.Cmp.Snippet,
  path = HVIM.icons.Cmp.Path,
  async_path = HVIM.icons.Cmp.Path,
  snippets = HVIM.icons.Cmp.Snippet,
  cmdline = HVIM.icons.Cmp.CmpLine,
  color = HVIM.icons.Cmp.Color,
  -- cmp_tabnine = HVIM.icons.Cmp.Tabnine .. "Tabnine",
  -- spell = HVIM.icons.Cmp.Spellcheck .. "Spell",
}

M.duplicates = {
  buffer = 1,
  path = 1,
  async_path = 1,
  nvim_lsp = 1,
  luasnip = 1,
  snippets = 1,
}

function M.opts()
  local cmp = require("cmp")
  local cmp_window = require("cmp.config.window")
  local cmp_mapping = require("cmp.config.mapping")
  local defaults = require("cmp.config.default")()
  local color_cache = {}

  return {
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-k>"] = cmp_mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-j>"] = cmp_mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-CR>"] = cmp.mapping.abort(),
    }),
    window = {
      completion = cmp_window.bordered({
        winhighlight = "FloatBorder:Pmenu,Search:None",
      }),
      documentation = cmp_window.bordered({
        winhighlight = "FloatBorder:Pmenu,Search:None",
      }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 9, group_index = 1 },
      { name = "async_path", priority = 4, group_index = 1 },
      { name = "buffer", priority = 6, keywork_length = 5, max_item_count = 6, group_index = 1 },
    }),
    formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, item)
        if item.kind == "Color" then
          local color = entry:get_completion_item().documentation
          local hl = color_cache[color]

          if not hl and color and type(color) == "string" and color:match("^#%x%x%x%x%x%x$") then
            hl = "hex-" .. color:sub(2)
            if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
              vim.api.nvim_set_hl(0, hl, { fg = color })
              color_cache[color] = hl
            end
          end

          item.menu_hl_group = hl
          item.menu = M.source_mapping.color
        else
          item.menu = M.source_mapping[entry.source.name]
        end
        item.kind = HVIM.icons.Kind[item.kind] .. item.kind
        item.dup = M.duplicates[entry.source.name] or 0

        return item
      end,
    },
    -- experimental = {
    --   ghost_text = true,
    -- },
    sorting = defaults.sorting,
  }
end

M.cmdline = function()
  local cmp = require("cmp")
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "async_path" },
    }, {
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })
end

return M
