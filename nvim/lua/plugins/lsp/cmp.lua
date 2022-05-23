local cmp = require 'cmp'
local lspkind = require 'lspkind'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  completion = {completeopt = 'menu,menuone,noinsert'},
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- menu = {
      --   luasnip = "(Snippet)",
      --   nvim_lsp = "ﲳ",
      --   nvim_lua = "",
      --   treesitter = "",
      --   path = "ﱮ",
      --   buffer = "﬘",
      --   zsh = "",
      --   spell = "暈",
      --   cmp_tabnine = "[TabNine]",
      --   look = "[Look]",
      --   calc = "[Calc]",
      --   emoji = "[Emoji]",        gh_issues = "[issues]",
      --   tn = "[TabNine]",
      -- },
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  windown = {
    documentation = {
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 70,
      min_width = 50,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 3
    },
  },
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),  
    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
        )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<c-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<c-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = {{
    name = "nvim_lsp"
  }, {
    name = "luasnip"
  }, {
    name = "buffer"
  }, {
    name = "nvim_lua"
  }},
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,

    -- Let's play with this for a day or two
    ghost_text = false,
  },
  -- sources = cmp.config.sources({{name = 'nvim_lsp'}, {name = 'luasnip'}}, {{name = 'buffer'}})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    {name = 'cmp_git'} -- You can specify the `cmp_git` source if you were installed it.
  }, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
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

-- default: {}
--    symbol_map = {
--      Text = "",
--      Method = "",
--      Function = "",
--      Constructor = "",
--      Field = "ﰠ",
--      Variable = "",
--      Class = "ﴯ",
--      Interface = "",
--      Module = "",
--      Property = "ﰠ",
--      Unit = "塞",
--      Value = "",
--      Enum = "",
--      Keyword = "",
--      Snippet = "",
--      Color = "",
--      File = "",
--      Reference = "",
--      Folder = "",
--      EnumMember = "",
--      Constant = "",
--      Struct = "פּ",
--      Event = "",
--      Operator = "",
--    },
--      TypeParameter = ""

-- M.icons = {
--   Class = " ",
--   Color = " ",
--   Constant = " ",
--   Constructor = " ",
--   Enum = "了 ",
--   EnumMember = " ",
--   Field = " ",
--   File = " ",
--   Folder = " ",
--   Function = " ",
--   Interface = "ﰮ ",
--   Keyword = " ",
--   Method = "ƒ ",
--   Module = " ",
--   Property = " ",
--   Snippet = "﬌ ",
--   Struct = " ",
--   Text = " ",
--   Unit = " ",
--   Value = " ",
--   Variable = " ",
-- }
