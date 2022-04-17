call plug#begin('~/.config/nvim/plugged')

" lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" lsp snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim' " or https://github.com/ray-x/navigator.lua?
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'folke/trouble.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'liuchengxu/vista.vim'

" if i don't want to configure the LSP but test it
" Plug 'VonHeikemen/lsp-zero.nvim'

" https://github.com/jose-elias-alvarez/null-ls.nvim

" utils
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'pwntester/octo.nvim'
Plug 'nvim-telescope/telescope-node-modules.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'folke/tokyonight.nvim'
" Plug 'EdenEast/nightfox.nvim'

call plug#end()

colorscheme tokyonight
