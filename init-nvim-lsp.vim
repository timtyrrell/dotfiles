call plug#begin('~/.config/nvim/plugged')

" lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'seblj/nvim-echo-diagnostics'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'David-Kunz/cmp-npm'
Plug 'andersevenrud/cmp-tmux'
Plug 'lukas-reineke/cmp-rg'
Plug 'hrsh7th/nvim-cmp'
" key config for selecting items
" https://github.com/hrsh7th/nvim-cmp/issues/916

" lsp snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" more cmp sources
" Plug 'davidsierradz/cmp-conventionalcommits'
" Plug 'dmitmel/cmp-cmdline-history'
" Plug 'kristijanhusak/vim-dadbod-completion
" Plug 'rcarriga/cmp-dap'

Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim' " or https://github.com/ray-x/navigator.lua?
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'folke/trouble.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'rmagatti/goto-preview'
Plug 'ii14/lsp-command'
Plug 'ray-x/lsp_signature.nvim'
Plug 'filipdutescu/renamer.nvim', { 'branch': 'master' }
Plug 'lukas-reineke/lsp-format.nvim'

" if i don't want to configure the LSP but test it
" Plug 'VonHeikemen/lsp-zero.nvim'

" https://github.com/jose-elias-alvarez/null-ls.nvim
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

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
Plug 'lewis6991/gitsigns.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'folke/tokyonight.nvim'
" Plug 'EdenEast/nightfox.nvim'
" Plug 'andersevenrud/nordic.nvim' or different nord or nordfox?

Plug 'tami5/sqlite.lua'
Plug 'AckslD/nvim-neoclip.lua'

call plug#end()

colorscheme tokyonight

" rounded boarders on hover and signature help:
" vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
" vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

" rounded boards for diagnostic popup
" local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
" for type, icon in pairs(signs) do
"     local hl = "DiagnosticSign" .. type
"     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl     })
" end

" local config = {
"     -- disable virtual text
"     virtual_text = false,
"     -- show signs
"     signs = { active = signs },
"     update_in_insert = true,
"     underline = true,
"     severity_sort = true,
"     float = {
" 	    focusable = false,
"     	    style = "minimal",
" 	    border = "rounded",
" 	    source = "always",
" 	    header = "",
" 	    prefix = "",
"     },
" }

" vim.diagnostic.config(config)

"toggle LSP diagnostics in Neovim 0.7
"vim.g.diagnostics_active = true
" vim.keymap.set('n', '<leader>d', function()
"   vim.g.diagnostics_active = not vim.g.diagnostics_active
"   if vim.g.diagnostics_active then
"     vim.diagnostic.show()
"   else
"     vim.diagnostic.hide()
"   end
" end)
