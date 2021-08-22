set nocompatible
filetype plugin indent on
syntax on
set hidden

let mapleader = ','

call plug#begin('~/.config/nvim/plugged')
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [ 'coc-yank' ]
" Plug 'antoinemadec/coc-fzf'
" Plug 'gelguy/wilder.nvim'
" Plug 'mattn/calendar-vim'
call plug#end()

" let g:calendar_no_mappings=0
" nmap <Leader>cL <Plug>CalendarH
" nmap <Leader>cl <Plug>CalendarV

" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" cmap <expr> <Tab> wilder#in_context() ? wilder#next() : '\<Tab>'
" cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : '\<S-Tab>'

" " only / and ? are enabled by default
" call wilder#set_option('modes', ['/', '?', ':'])

" call wilder#enable_cmdline_enter()
" set wildcharm=<Tab>
" call wilder#set_option('modes', ['/', '?', ':'])

" " cmap <expr> <Tab> wilder#in_context() ? wilder#next() : '\<Tab>'
" " cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : '\<S-Tab>'

" function! WilderInit() abort
"   " use wilder#wildmenu_lightline_theme() if using Lightline
"   " 'highlights' : can be overriden, see :h wilder#wildmenu_renderer()
"   call wilder#set_option('renderer', wilder#wildmenu_renderer(
"         \ wilder#wildmenu_lightline_theme({
"         \   'highlights': {},
"         \   'highlighter': wilder#basic_highlighter(),
"         \   'separator': ' · ',
"         \ })))

"   " 'highlighter' : applies highlighting to the candidates
"   call wilder#set_option('renderer', wilder#popupmenu_renderer({
"         \ 'highlighter': wilder#basic_highlighter(),
"         \ }))

"   call wilder#set_option('pipeline', [
"         \   wilder#branch(
"         \     wilder#cmdline_pipeline({
"         \       'fuzzy': 1,
"         \     }),
"         \     wilder#python_search_pipeline({
"         \       'pattern': 'fuzzy',
"         \     }),
"         \   ),
"         \ ])

"   let s:highlighters = [
"           \ wilder#pcre2_highlighter(),
"           \ wilder#basic_highlighter(),
"           \ ]

"   call wilder#set_option('renderer', wilder#renderer_mux({
"         \ ':': wilder#popupmenu_renderer({
"         \   'highlighter': s:highlighters,
"         \ }),
"         \ '/': wilder#wildmenu_renderer({
"         \   'highlighter': s:highlighters,
"         \ }),
"         \ }))

"   call wilder#set_option('renderer', wilder#popupmenu_renderer({
"         \ 'highlighter': wilder#basic_highlighter(),
"         \ 'left': [
"         \   wilder#popupmenu_devicons(),
"         \ ],
"         \ }))
" endfunction

" autocmd CmdlineEnter * ++once WilderInit()
