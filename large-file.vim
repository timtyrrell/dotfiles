syntax off
filetype off
set noundofile
set noswapfile
set noloadplugins

" ADD THIS TO NORMAL CONFIG?
" disable syntax highlighting in big files
" function DisableSyntaxTreesitter()
"     echo("Big file, disabling syntax, treesitter and folding")
"     if exists(':TSBufDisable')
"         exec 'TSBufDisable autotag'
"         exec 'TSBufDisable highlight'
"         " etc...
"     endif

"     set foldmethod=manual
"     syntax clear
"     syntax off    " hmmm, which one to use?
"     filetype off
"     set noundofile
"     set noswapfile
"     set noloadplugins
" endfunction

" augroup BigFileDisable
"     autocmd!
"     autocmd BufWinEnter * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
" augroup END
