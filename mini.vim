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
Plug 'ggandor/lightspeed.nvim'
Plug 'folke/which-key.nvim'
call plug#end()

lua << EOF
require("which-key").setup {
triggers_blacklist = {
    -- n = { "f" },
  },
}
require'lightspeed'.setup {
  limit_ft_matches = 5,
  -- For instant-repeat, pressing the trigger key again (f/F/t/T) always works
  instant_repeat_fwd_key = ';',
  instant_repeat_bwd_key = ':',
}
function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', ':', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('x', ':', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})

EOF
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

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
