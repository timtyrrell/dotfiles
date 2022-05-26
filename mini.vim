set nocompatible
filetype plugin indent on
syntax on
set hidden

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
           \ Plug 'junegunn/fzf.vim'

" Plug 'gelguy/wilder.nvim'

call plug#end()

" Ag PATTERN DIR
" command! -bang -nargs=+ -complete=dir AgDir call fzf#vim#ag_raw(<q-args>, <bang>0)

" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : '\<Tab>'
" cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : '\<S-Tab>'

" call wilder#set_option('modes', ['/', '?', ':'])
