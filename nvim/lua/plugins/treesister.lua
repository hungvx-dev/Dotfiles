local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- Auto pair tag
require("nvim-ts-autotag").setup()

local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.motoko = "typescript"

configs.setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"typescript",
		"javascript",
		"html",
		"css",
		"bash",
		"json",
		"scss",
		"tsx",
		"vue",
		"comment",
		"dockerfile",
		"graphql",
		"lua",
		"yaml",
	},
	sync_install = true,
	autotag = { enable = true },
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = { enable = true },
	highlight = {
		enable = true,
		disable = { "c", "rust" },
		additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["as"] = "@statement.outer",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["ak"] = "@block.inner",
				["ik"] = "@block.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "single",
			peek_definition_code = {
				["<Leader>df"] = "@function.outer",
				["<Leader>dc"] = "@class.outer",
			},
		},
	},
	indent = {
		enable = true,
		-- disable = { "python", "css" }
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {
			"Gold",
			"Orchid",
			"DodgerBlue",
			-- "Cornsilk",
			-- "Salmon",
			-- "LawnGreen",
		},
		disable = { "html" },
	},
	-- context_commentstring = {
	--   enable = true,
	--   config = { javascriptreact = { style_element = "{/*%s*/}" } },
	--   typescript = "// %s",
	--   css = "/* %s */",
	--   scss = "/* %s */",
	--   html = "<!-- %s -->",
	--   svelte = "<!-- %s -->",
	--   vue = "<!-- %s -->",
	--   json = "",
	-- },
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	refactor = {
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},
})
