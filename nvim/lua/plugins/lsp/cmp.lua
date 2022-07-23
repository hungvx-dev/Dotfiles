-- local cmp = require 'cmp'
local lspkind = require 'lspkind'

-- local ELLIPSIS_CHAR = '…'
-- local MAX_LABEL_WIDTH = 40
-- local MIN_LABEL_WIDTH = 40

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local tabnine_status_ok, _ = pcall(require, "plugins.tabnine")
if not tabnine_status_ok then
  return
end

local compare = require "cmp.config.compare"
local compareTabnine = require("cmp_tabnine.compare")
require("luasnip/loaders/from_vscode").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- local icons = require "plugins.icons"
-- local kind_icons = icons.kind

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

local source_mapping = {
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  luasnip = "(Snippet)",
  look = "[Look]",
  calc = "[Calc]",
  emoji = "[Emoji]",
  gh_issues = "[issues]",
  tn = "[TabNine]",
  spell = "暈",
  treesitter = "",
  path = "ﱮ",
  buffer = "﬘",
  zsh = "",
}

cmp.setup {
  completion = {completeopt = 'menu,menuone,noinsert'},
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-c>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Right>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  -- formatting = {
  --   format = function(entry, vim_item)
  --     local label = vim_item.abbr
  --     local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
  --     if truncated_label ~= label then
  --       vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
  --     elseif string.len(label) < MIN_LABEL_WIDTH then
  --       local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
  --       vim_item.abbr = label .. padding
  --     end
  --     return vim_item
  --   end,
  -- },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = lspkind.cmp_format({
      mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- The function below will be called before any actual modifications from lspkind
      before = function(entry, vim_item)
        -- vim_item.kind = lspkind.presets.default[vim_item.kind]
        -- vim_item.kind = kind_icons[vim_item.kind]
        local menu = source_mapping[entry.source.name]

        if entry.source.name == "cmp_tabnine" then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. " " .. menu
          end
          vim_item.kind = ""
          vim_item.kind_hl_group = "CmpItemKindTabnine"
        end

        vim_item.menu = menu
        return vim_item
      end,
    }),
  },
  sources = {
    { name = "nvim_lsp", group_index = 2 , priority = 7 },
    { name = "luasnip", group_index = 2, priority = 6 },
    { name = "cmp_tabnine", group_index = 2, priority = 5 },
    { name = "path", group_index = 2, priority = 5  },
    { name = "nvim_lua", group_index = 2, priority = 4  },
    { name = "buffer", group_index = 2, priority = 4 },
    { name = 'spell',  group_index = 2, priority = 3 },
    { name = "emoji", group_index = 2, priority = 1  },
  },
  sorting = {
    priority_weight = 1,
    comparators = {
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
  --     compare.offset,
  --     -- compare.locality,
  --     -- compare.recently_used,
  --     -- compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
  --     -- compare.offset,
  --     -- compare.order,
      compareTabnine,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
      max_width = 70,
      min_width = 50,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 3
    },
    completion = {
      border = "rounded",
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
  }, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  soures = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
