return {
	-- Themes
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("configs.colorscheme")
		end,
	},

	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("plugins.alpha")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		config = function()
			require("plugins.treesitter")
		end,
		dependencies = {
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "RRethy/nvim-treesitter-textsubjects",
			{
				"m-demare/hlargs.nvim",
				config = function()
					require("hlargs").setup({ color = "#F7768E" })
				end,
			},
		},
	},

	-- Navigating (Telescope/Tree/Refactor)
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		config = function()
			require("plugins.telescope")
		end,
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- { "cljoly/telescope-repo.nvim" },
		},
	},
	{ "nvim-pack/nvim-spectre" },
	{
		"nvim-tree/nvim-tree.lua",
    lazy = false,
		config = function()
			require("plugins.tree")
		end,
	},
	{
		"gbprod/stay-in-place.nvim",
		lazy = false,
		config = true, -- run require("stay-in-place").setup()
	},

	-- LSP Base
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		servers = nil,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	},

	-- Formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		config = function()
			require("lsp.null-ls")
		end,
	},

	-- LSP Cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",
			{ "tzachar/cmp-tabnine", build = "./install.sh" },
			{ "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("lsp.cmp")
		end,
	},

	-- LSP Addons
	{ "onsails/lspkind-nvim" },
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("plugins.trouble")
		end,
	},
	{ "nvim-lua/popup.nvim" },
	{
		"j-hui/fidget.nvim",
		config = function()
			require("plugins.fidget")
		end,
	},
	{
		"ChristianChiarulli/nvim-gps",
		branch = "text_hl",
		config = function()
			require("plugins.gps")
		end,
	},
	{ "jose-elias-alvarez/typescript.nvim" },
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "main", -- or "anticonceal"
		config = function()
			require("lsp.inlay-hints")
		end,
	},

	-- General
	{
		"numToStr/Comment.nvim",
		lazy = false,
		branch = "jsx",
		config = function()
			require("plugins.comment")
		end,
	},
	{
		"mg979/vim-visual-multi",
		config = function()
			vim.g.VM_leader = ","
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		event = "BufEnter",
		config = function()
			require("plugins.todo-comments")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("plugins.lualine")
		end,
		event = "VeryLazy",
	},
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "BufAdd",
		config = function()
			require("plugins.barbar")
		end,
	},
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = "cd app && npm install",
	-- 	setup = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },
	-- {
	-- 	"declancm/cinnamon.nvim",
	-- 	config = function()
	-- 		require("plugins.cinnamon")
	-- 	end,
	-- },
	{
		"Shatur/neovim-session-manager",
		lazy = false,
		config = function()
			require("plugins.session-manager")
		end,
	},
	{ "kylechui/nvim-surround", lazy = false, config = true },
	{ "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } },
	{
		"unblevable/quick-scope",
		config = function()
			require("plugins.quick-scope")
		end,
	},
	{
		"sunjon/shade.nvim",
		config = function()
			require("shade").setup()
			require("shade").toggle()
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
		end,
	},
	-- {
	-- 	"echasnovski/mini.align",
	-- 	lazy = false,
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.align").setup()
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("plugins.indent")
		end,
	},
	--[[ {
		"echasnovski/mini.indentscope",
		event = "BufReadPre",
		config = function()
			require("mini.indentscope").setup()
		end,
	}, ]]

	-- Snippets & Language & Syntax
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.autopairs")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.git.signs")
		end,
	},
	-- {
	-- 	"sindrets/diffview.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("plugins.git.diffview")
	-- 	end,
	-- },
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("plugins.git.conflict")
		end,
	},
	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- 	keys = {
	-- 		"<Leader>gwc",
	-- 		"<Leader>gww",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.git.worktree")
	-- 	end,
	-- },
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilterCurrentFile", "LazyGitFilter" },
	-- 	config = function()
	-- 		vim.g.lazygit_floating_window_scaling_factor = 1
	-- 	end,
	-- },

	-- Testing
}
