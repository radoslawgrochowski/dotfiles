local packer = require 'lib.packer-init'

packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'airblade/vim-rooter' }
  use { 'farmergreg/vim-lastplace' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-projectionist' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-eunuch' } -- Adds :Rename, :SudoWrite
  use { 'tpope/vim-sleuth' } -- Indent autodetection with editorconfig support
  use { 'jessarcher/vim-heritage' } -- Automatically create parent dirs when saving
  use { 'sickill/vim-pasta' }

  use {
    'tiagovla/tokyodark.nvim',
    requires = {
      { 'nvim-lualine/lualine.nvim' }
    },
    config = function()
      require 'user.plugins.tokyodark'
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    },
    config = function()
      require 'user.plugins.cmp'
    end
  }

  use {
    'mbbill/undotree',
    config = function()
      require 'user.plugins.tokyodark'
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'lewis6991/spellsitter.nvim',
    },
    config = function()
      require('spellsitter').setup()
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'b0o/schemastore.nvim',
      'weilbith/nvim-code-action-menu',
    },
    config = function()
      require 'user.plugins.lspconfig'
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
    },
    config = function()
      require 'user.plugins.telescope'
    end
  }

  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('user.plugins.splitjoin')
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'user.plugins.gitsigns'
    end,
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup {}
    end,
  }
  -- plugins up to this line have been reviewed by me
  -- and I don't really know what are plugins below capable of
  --

  -- this doesn't work somehow
  --  use {
  --    'romgrk/nvim-treesitter-context',
  --    config = function()
  --      require 'user.plugins.treesitter-context'
  --    end
  --  }

  -- use { 'sbdchd/neoformat' }


end)
