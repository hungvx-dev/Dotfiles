local cmd = vim.cmd
cmd 'packadd paq-nvim'

require 'paq' {
  { 'savq/paq-nvim', opt = true };
  -- { 'dracula/vim', as = 'dracula' };
  'Mofiqul/dracula.nvim';

  -- Tools
  'kyazdani42/nvim-web-devicons'; ------------------------------- For file icons
  'kyazdani42/nvim-tree.lua';
  'nvim-lualine/lualine.nvim'; ------------------------------------- Status line
  'akinsho/bufferline.nvim';
  'nvim-lua/plenary.nvim';
  'lukas-reineke/indent-blankline.nvim';
  -- Telescope
  "nvim-telescope/telescope.nvim";
  "tom-anders/telescope-vim-bookmarks.nvim";
  "nvim-telescope/telescope-media-files.nvim";
  "nvim-telescope/telescope-ui-select.nvim";
  "nvim-telescope/telescope-file-browser.nvim";
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };
  'nvim-treesitter/nvim-treesitter-textobjects';
  "JoosepAlviste/nvim-ts-context-commentstring";
  'p00f/nvim-ts-rainbow';
  "nvim-treesitter/playground";
  "windwp/nvim-ts-autotag";
  "romgrk/nvim-treesitter-context";
  "mizlan/iswap.nvim";
  -- 'karb94/neoscroll.nvim';

  -- Faster code
  { 'mg979/vim-visual-multi', branch='master' };
  'kana/vim-textobj-user';
  'kana/vim-textobj-entire';
  'tpope/vim-surround';
  'tpope/vim-commentary';
  'norcalli/nvim-colorizer.lua';
  'windwp/nvim-autopairs';
  -- 'simrat39/symbols-outline.nvim';
  -- 'unblevable/quick-scope';
  -- 'rhysd/clever-f.vim';

  -- CMP autocomplete
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/nvim-cmp';
  'onsails/lspkind-nvim';
  'L3MON4D3/LuaSnip';
  'saadparwaiz1/cmp_luasnip';
  'f3fora/cmp-spell', -------------------- Spell suggestion

  -- LSP Performance
  'neovim/nvim-lspconfig';
  'ray-x/lsp_signature.nvim';
  'folke/lsp-colors.nvim';
  'prettier/vim-prettier';
  'folke/trouble.nvim';
  'b0o/schemastore.nvim';

  --'jose-elias-alvarez/nvim-lsp-ts-utils';
  -- Git
  'f-person/git-blame.nvim';
  'airblade/vim-gitgutter';
}
