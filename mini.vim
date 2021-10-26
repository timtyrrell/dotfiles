set nocompatible
filetype plugin indent on
syntax on
set hidden

let mapleader = ','

call plug#begin('~/.config/nvim/plugged')

Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
let g:registers_window_border = "double" "'none' by default, can be 'none', 'single','double', 'rounded', 'solid', or 'shadow'
let g:registers_show_empty_registers = 0 "1 by default, an additional line with the registers without content

" Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" nnoremap <leader>te :Telescope<cr>

" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Plug 'ElPiloto/telescope-vimwiki.nvim'
" nnoremap <leader>vw <cmd>lua require('telescope').extensions.vimwiki.vimwiki()<cr>
" nnoremap <leader>vg <cmd>lua require('telescope').extensions.vw.live_grep()<cr>

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [ 'coc-yank' ]
" Plug 'antoinemadec/coc-fzf'
" Plug 'gelguy/wilder.nvim'
" Plug 'mattn/calendar-vim'
" Plug 'ggandor/lightspeed.nvim'
call plug#end()

lua << EOF

-- require('telescope').setup {}
-- require('telescope').load_extension('vimwiki')
-- require('telescope').load_extension('fzf')

EOF
