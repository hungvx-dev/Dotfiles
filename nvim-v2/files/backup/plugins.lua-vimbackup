local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Needed to load first
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'goolord/alpha-nvim', config = "require('plugins.alpha')" }

    -- Themes
    use { 'folke/tokyonight.nvim' }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', config = "require('plugins.treesitter')" }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
    -- use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require('hlargs').setup({ color = "#F7768E" }) end }
    use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }

    -- Navigating (Telescope/Tree/Refactor)
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope.nvim',
      config = "require('plugins.telescope')",
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' }
      }
    }
    use { 'cljoly/telescope-repo.nvim' }
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
    use { 'nvim-pack/nvim-spectre' }
    use { 'kyazdani42/nvim-tree.lua', config = "require('plugins.tree')" }
    use { 'gbprod/stay-in-place.nvim',
      config = function()
        require('stay-in-place').setup({})
      end
    }

    -- LSP Base
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }

    -- LSP Cmp
    use { 'hrsh7th/nvim-cmp', event = 'InsertEnter', config = "require('lsp.cmp')" }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-path', after = 'cmp-buffer' }
    use { 'hrsh7th/cmp-cmdline', after = 'cmp-path' }
    use { 'hrsh7th/cmp-calc', after = 'cmp-cmdline' }
    use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp', after = 'cmp-calc' }
    use { 'David-Kunz/cmp-npm', after = 'cmp-tabnine', requires = 'nvim-lua/plenary.nvim',
      config = "require('lsp.cmp-npm')" }
    use { 'saadparwaiz1/cmp_luasnip', after = 'cmp-npm' }
    use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' }, after = 'cmp_luasnip' }

    -- LSP Addons
    -- use { 'stevearc/dressing.nvim', requires = 'MunifTanjim/nui.nvim', config = "require('plugins.dressing')" }
    use { 'onsails/lspkind-nvim' }
    use { 'folke/lsp-trouble.nvim', config = "require('plugins.trouble')" }
    use { 'nvim-lua/popup.nvim' }
    use { 'ChristianChiarulli/nvim-gps', branch = 'text_hl', config = "require('plugins.gps')", after = 'nvim-treesitter' }
    use { 'jose-elias-alvarez/typescript.nvim' }
    use { 'axelvc/template-string.nvim', config = function() require('template-string').setup() end }


    -- General
    use { 'romgrk/barbar.nvim', branch = 'master', requires = { 'kyazdani42/nvim-web-devicons' },
      config = "require('plugins.barbar')" }
    use { 'numToStr/Comment.nvim', config = "require('plugins.comment')" }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    -- use { 'ggandor/lightspeed.nvim', config = "require('plugins.lightspeed')" }
    use { 'Shatur/neovim-session-manager', config = "require('plugins.session-manager')" }
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = "require('plugins.nvim-ufo')" }
    use {
      'nvim-lualine/lualine.nvim',
      config = "require('plugins.lualine')",
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- use { 'ecosse3/galaxyline.nvim', after = 'nvim-gps', config = "require('plugins.galaxyline')", event = "BufWinEnter" }


    -- Snippets & Language & Syntax
    use { 'windwp/nvim-autopairs', after = { 'nvim-treesitter', 'nvim-cmp' }, config = "require('plugins.autopairs')" }
    use { 'lukas-reineke/indent-blankline.nvim', config = "require('plugins.indent')" }
    use { 'NvChad/nvim-colorizer.lua', config = "require('plugins.colorizer')" }



    -- Faster code
    -- use { 'ggandor/lightspeed.nvim', config = "require('plugins.lightspeed')" }
    use { 'kylechui/nvim-surround', config = function() require("nvim-surround").setup({}) end }
    use { 'kana/vim-textobj-entire', requires = { 'kana/vim-textobj-user' } }
    use { 'unblevable/quick-scope', config = "require('plugins.quick-scope')" }
    use { 'rhysd/clever-f.vim' }


    -- Git
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = "require('plugins.git.signs')",
      event = "BufRead"
    }
    -- use { 'sindrets/diffview.nvim', config = "require('plugins.git.diffview')" }
    use { 'akinsho/git-conflict.nvim', config = "require('plugins.git.conflict')" }
    use { 'ThePrimeagen/git-worktree.nvim', config = "require('plugins.git.worktree')" }
    use { 'kdheepak/lazygit.nvim' }

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    compile_path = compile_path,
    disable_commands = true,
    max_jobs = 50,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
})
