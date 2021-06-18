set nocompatible
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-yank' ]
Plug 'antoinemadec/coc-fzf'
call plug#end()

let mapleader = ','
