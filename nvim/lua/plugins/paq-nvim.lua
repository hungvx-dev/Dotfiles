local cmd = vim.cmd
cmd("packadd paq-nvim")

require("paq")({
	{ "savq/paq-nvim", opt = true },
	-- { 'dracula/vim', as = 'dracula' };
	"Mofiqul/dracula.nvim",

	-- Tools
	"kyazdani42/nvim-web-devicons", ------------------------------- For file icons
	"kyazdani42/nvim-tree.lua",
	"nvim-lualine/lualine.nvim", ------------------------------------- Status line
	"akinsho/bufferline.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"glepnir/dashboard-nvim",

	-- Telescope
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	-- "tom-anders/telescope-vim-bookmarks.nvim",
	-- "nvim-telescope/telescope-media-files.nvim",
	-- "nvim-telescope/telescope-file-browser.nvim",

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"p00f/nvim-ts-rainbow",
	"nvim-treesitter/playground",
	"windwp/nvim-ts-autotag",
	"romgrk/nvim-treesitter-context",
	"mizlan/iswap.nvim",
	-- 'karb94/neoscroll.nvim';

	-- Faster code
	{ "mg979/vim-visual-multi", branch = "master" },
	"kana/vim-textobj-user",
	"kana/vim-textobj-entire",
	"tpope/vim-surround",
	"tpope/vim-commentary",
	"norcalli/nvim-colorizer.lua",
	"windwp/nvim-autopairs",
	"unblevable/quick-scope",
	"rhysd/clever-f.vim",
	-- 'simrat39/symbols-outline.nvim';

	-- CMP autocomplete
	{
		as = "cmp",
		url = "git@github.com:jonatan-branting/nvim-cmp.git",
		branch = "add-filter-to-source",
		pin = true,
	},
	-- "hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"f3fora/cmp-spell", -------------------- Spell suggestion
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"onsails/lspkind-nvim",
	"nvim-lua/plenary.nvim",
	-- "hrsh7th/cmp-emoji",
	-- "hrsh7th/cmp-nvim-lsp-signature-help",
	-- { "tzachar/cmp-tabnine", run = "./install.sh" },

	-- LSP Performance
	"neovim/nvim-lspconfig",
	"williamboman/nvim-lsp-installer", -- simple to use language server installer
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
	"ray-x/lsp_signature.nvim",
	"folke/lsp-colors.nvim",
	{
		"prettier/vim-prettier",
		run = "yarn install --frozen-lockfile --production",
	},
	"folke/trouble.nvim",
	"RRethy/vim-illuminate",
	"SmiteshP/nvim-navic",
	"b0o/schemastore.nvim",

	-- Git
	"f-person/git-blame.nvim",
	"lewis6991/gitsigns.nvim",
	-- "airblade/vim-gitgutter",
	-- "tpope/vim-fugitive",
})
