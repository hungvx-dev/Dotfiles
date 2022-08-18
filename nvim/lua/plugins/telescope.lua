local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")
local icons = require("plugins.icons")

telescope.setup({
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = " ",
		path_display = { "smart" },
		initial_mode = "insert",
		layout_strategy = "vertical",
		entry_prefix = "  ",
		winblend = 0,
		-- vimgrep_arguments = {
		-- 	"rg",
		-- 	"--hidden",
		-- 	"--color=never",
		-- 	"--no-heading",
		-- 	"--with-filename",
		-- 	"--line-number",
		-- 	"--column",
		-- 	"--smart-case",
		-- },
		layout_config = {
			width = 0.8,
			height = 0.8,
			-- prompt_position = "bottom",
			preview_cutoff = 10,
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		file_ignore_patterns = {
			".git/",
			"target/",
			"docs/",
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			-- "%.jpg",
			-- "%.jpeg",
			-- "%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".settings/",
			".vscode/",
			"__pycache__/",
			"build/",
			"env/",
			"gradle/",
			"node_modules/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
		},

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = trouble.open_with_trouble,
				["<C-b>"] = actions.results_scrolling_up,
				["<C-f>"] = actions.results_scrolling_down,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		-- media_files = {
		-- 	-- filetypes whitelist
		-- 	-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
		-- 	filetypes = { "png", "webp", "jpg", "jpeg" },
		-- 	find_cmd = "rg", -- find command (defaults to `fd`)
		-- },
		-- file_browser = {
		-- 	-- theme = "ivy",
		-- 	-- require("telescope.themes").get_dropdown {
		-- 	--   previewer = false,
		-- 	--   -- even more opts
		-- 	-- },
		-- 	mappings = {
		-- 		["i"] = {
		-- 			-- your custom insert mode mappings
		-- 		},
		-- 		["n"] = {
		-- 			-- your custom normal mode mappings
		-- 		},
		-- 	},
		-- },
	},
})

telescope.load_extension("fzf")
-- telescope.load_extension("media_files")
-- telescope.load_extension("file_browser")

local function setup_custom_highlights()
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = "#e06c75" })
end

setup_custom_highlights()
