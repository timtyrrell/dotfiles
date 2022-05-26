" fzf quickfix??
" dim linenumber color

set title "displays current file as vim title
set smartindent " Keep indentation from previous line
set autoread " do not prompt and reload file system changes
set showbreak=↳
set expandtab " Use softtabstop spaces instead of tab characters
set softtabstop=2 " Indent by 2 spaces when pressing <TAB>
set shiftwidth=2 " Indent by 2 spaces when using >>, <<, == etc.
set number

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set autoindent              " indent a new line the same amount as the line just typed
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
filetype plugin on

set nobackup
set nowritebackup
set noswapfile
" setup persistent undo
set undodir=~/.vim/undo-dir
set undofile

" let base16colorspace=256
" set termguicolors

set wildcharm=<Tab>
set wildmode=longest,list   " get bash-like tab completions
set completeopt=longest,menuone

" ignore case, example: :e TEST.js
set wildignorecase

" insert mode paste from the clipboard just like on mac
inoremap <C-v> <C-r>*

" let mapleader = ' '
let mapleader = ','

nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tm :tabmove<Space>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 10gt

" simplify split navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"sessions
" Don't save hidden and unloaded buffers in sessions
set sessionoptions-=buffers
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options
" don't restore help windows
set sessionoptions-=help
" results with those ^: sessionoptions=blank,curdir,folds,tabpages,winsize

" search highlighting/behavior
set hlsearch
set incsearch

set ignorecase
set infercase " enhances ignorecase
set smartcase
" set inccommand=nosplit "highlight :s in realtime

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin()

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" automatic session saving
Plug 'tpope/vim-obsession'

"removes trailing whitespace on save
Plug 'rondale-sc/vim-spacejam'
let g:spacejam_filetypes = '*'

Plug 'christoomey/vim-system-copy'
" cp for copying and cv for pasting
" cpiw => copy word into system clipboard
" cpi' => copy inside single quotes to system clipboard
" cvi' => paste inside single quotes from system clipboard
" cP is mapped to copy the current line directly.
" cV is mapped to paste the content of system clipboard to the next line.
" other option: Plug 'ojroques/vim-oscyank'
"
Plug 'tpope/vim-commentary'
"gcc  - comment out line
"gcap - comment out paragraph
"gcgc - uncomment a set of adjacent commented lines

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
           \ Plug 'junegunn/fzf.vim'

" Possible TODO
" file explorer side-bar, coc-explorer?
" git tooling
" LSP (language server)

call plug#end()

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>ff <cmd>Files<CR>

nnoremap <silent> <Leader>fl <cmd>RgLines<CR>
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>

" do not search filename, just file contents of all file Lines in root dir with smartcase
command! -bang -nargs=* RgLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..'] }), <bang>0)

" `gx` to open vim-plug plugin on github.com
function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

" `gx` to open package.json lib on npmjs.com
function! PackageJsonGx() abort
  let l:line = getline('.')
  let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')
  if len(l:package) > 0
    let l:package_name = l:package[1]
    let l:url = 'https://www.npmjs.com/package/' . l:package_name
    call netrw#BrowseX(l:url, 0)
  endif
endfunction

" Run PlugUpgrade and PlugUpdate every week automatically when entering Vim.
function! OnVimEnter() abort
  if exists('g:plug_home')
    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
    if filereadable(l:filename) == 0
      call writefile([], l:filename)
    endif

    let l:this_day = strftime('%Y_%V') " weekly
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_day) < 0
      " run update then run Diff when fully completed
      call execute('PlugUpgrade | PlugUpdate --sync | PlugDiff')
      call writefile([l:this_day], l:filename, 'a')
    endif
  endif
endfunction

function! s:setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
endfunction

augroup AutoGx
  autocmd!
  autocmd BufRead,BufNewFile .vimrc nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd FileType vim-plug call s:setup_extra_keys()
  autocmd VimEnter * call OnVimEnter()
augroup end
