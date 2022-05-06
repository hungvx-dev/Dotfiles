local cmd = vim.cmd
cmd 'packadd paq-nvim'

require 'paq' {
  { 'savq/paq-nvim', opt = true };
  { 'dracula/vim', as = 'dracula' };

  -- Tools
  'kyazdani42/nvim-web-devicons'; ------------------------------- For file icons
  'kyazdani42/nvim-tree.lua';
  'nvim-lualine/lualine.nvim'; ------------------------------------- Status line
  'akinsho/bufferline.nvim';
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'lukas-reineke/indent-blankline.nvim';
  -- 'karb94/neoscroll.nvim';

  -- Faster code
  'mg979/vim-visual-multi';
  'tpope/vim-surround';
  'tpope/vim-commentary';
  'rhysd/clever-f.vim';
  'windwp/nvim-ts-autotag';
  'norcalli/nvim-colorizer.lua';
  'windwp/nvim-autopairs';

  -- CMP autocomplete
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-path';
  'hrsh7th/cmp-cmdline';
  'hrsh7th/nvim-cmp';
  'onsails/lspkind-nvim';
  'L3MON4D3/LuaSnip';
  'saadparwaiz1/cmp_luasnip';

  -- LSP Performance
  'neovim/nvim-lspconfig';
  'ray-x/lsp_signature.nvim';
  'folke/lsp-colors.nvim';
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' };
  'nvim-treesitter/nvim-treesitter-textobjects';
  'prettier/vim-prettier';
  'folke/trouble.nvim';

  --'jose-elias-alvarez/nvim-lsp-ts-utils';
  -- Git
  'f-person/git-blame.nvim';
  'airblade/vim-gitgutter';
}
