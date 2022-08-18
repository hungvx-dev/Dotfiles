local lspkind = require("lspkind")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- local tabnine_status_ok, _ = pcall(require, "plugins.tabnine")
-- if not tabnine_status_ok then
-- 	return
-- end

local protocol = require("vim.lsp.protocol")
local compare = require("cmp.config.compare")
-- local compareTabnine = require("cmp_tabnine.compare")
require("luasnip/loaders/from_vscode").lazy_load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- local icons = require("plugins.icons")
-- local kind_icons = icons.kind

-- vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	luasnip = "(Snippet)",
	spell = "暈",
	path = "ﱮ",
	buffer = "﬘",
	-- look = "[Look]",
	-- calc = "[Calc]",
	-- emoji = "[Emoji]",
	-- gh_issues = "[issues]",
	-- tn = "[TabNine]",
	-- treesitter = "",
	-- cmp_tabnine = "[TN]",
	-- zsh = "",
}

local winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Right>"] = cmp.mapping.confirm({ select = true }),
		-- ['<C-Space>'] = cmp.mapping.confirm {
		--   behavior = cmp.ConfirmBehavior.Insert,
		--   select = true,
		-- },
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		["<C-Space>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = lspkind.cmp_format({
			mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 70,
			before = function(entry, vim_item)
				-- vim_item.kind = lspkind.presets.default[vim_item.kind]
				-- vim_item.kind = kind_icons[vim_item.kind]
				-- if entry.source.name == "cmp_tabnine" then
				-- 	if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
				-- 		menu = entry.completion_item.data.detail .. " " .. menu
				-- 	end
				-- 	vim_item.kind = ""
				-- 	vim_item.kind_hl_group = "CmpItemKindTabnine"
				-- end
				vim_item.menu = source_mapping[entry.source.name]
				return vim_item
			end,
		}),
	},
	sources = {
		{
			name = "nvim_lsp",
			filter = function(entry, ctx)
				local kind = protocol.CompletionItemKind[entry:get_kind()]

				if kind == "Text" or kind == "Snippet" then
					return true
				end
			end,
		},
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
		-- { name = "spell", keyword_length = 4 },
	},
	sorting = {
		comparators = {
			compare.score,
			compare.offset,
			compare.exact,
			compare.kind,
			-- compare.sort_text,
			-- compare.length,
			compare.order,
			-- compareTabnine,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	},
	window = {
		documentation = {
			border = "rounded",
			winhighlight = winhighlight,
			max_width = 70,
			min_width = 50,
			max_height = math.floor(vim.o.lines * 0.3),
			min_height = 3,
		},
		completion = {
			border = "rounded",
			winhighlight = winhighlight,
		},
	},
	-- experimental = {
	-- 	native_menu = true,
	-- 	ghost_text = false,
	-- },
	-- view = {
	-- 	entities = "native",
	-- },
})

cmp.setup.filetype("gitcommit", {
	sources = {
		{ name = "cmp_git" },
		{ name = "buffer" },
	},
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	soures = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
