set nocompatible
set runtimepath^=~/.vim
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()
