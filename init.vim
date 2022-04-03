"""" motions
" 0			  To the first character of the line.  |exclusive|
" ^			  To the first non-blank character of the line.
" $       To the end of the line.  When a count is given also go
" w			  [count] words forward.  |exclusive| motion.
" W			  [count] WORDS forward.  |exclusive| motion.
" e			  Forward to the end of word [count] |inclusive|.
" E			  Forward to the end of WORD [count] |inclusive|.
" b			  [count] words backward.  |exclusive| motion.
" B			  [count] WORDS backward.  |exclusive| motion.
" ge			Backward to the end of word [count] |inclusive|.
" gE			Backward to the end of WORD [count] |inclusive|.
" %			  Find the next item in this line after or under the cursor and jump to its match.
" ]m      go to next start of a method
" ]M      go to next end of a method
" [m      go to previous start of a method
" [M      go to previous end of a method
" [{      jump to beginning of code block (while, switch, if, etc)
" [(      jump to the beginning of a parenthesis
" ]}      jump to end of code block (while, switch, if, etc)
" ])      jump to the end of a parenthesis
" ]]			[count] |section|s forward or to the next '{' in the first column.
" ][			[count] |section|s forward or to the next '}' in the first column.
" [[			[count] |section|s backward or to the previous '{' in the first column
" []			[count] |section|s backward or to the previous '}' in the first column
" CTRL-O  go to [count] Older cursor position in jump list
" CTRL-I  go to [count] newer cursor position in jump list
" '.      go to position where last change was made (in current buffer)
" (			[count] sentences backward
" )			[count] sentences forward
" {			[count] paragraphs backward
" }			[count] paragraphs forward
" '<			To the first line or character of the last selected Visual area
" '>			To the last line or character of the last selected Visual area
" g;			Go to [count] older position in change list.
" g,			Go to [count] newer cursor position in change list.
" c       delete character and enter insert mode
" d       delete character and enter insert mode
" p       paste behind cursor
" P       paste in-front/on top cursor

"""" actions
" C 	    delete from the cursor to the end of the line and enter insert mode
" cc    	delete the whole line and enter insert mode (===S）
" x 	    delete the character under the cursor
" X 	    delete the character in front of the cursor
" D       clears all characters in the current line (the line is not deleted)
" dw      delete word
" de      delete until end of word
" dd      delete one line
" dl	    delete character (alias: "x")
" diw     delete inner word
" daw     delete a word
" diW     delete inner WORD
" daW     delete a WORD
" dis     delete inner sentence
" das     delete a sentence
" dib     delete inner '(' ')' block
" dab     delete a '(' ')' block
" dip     delete inner paragraph
" dap     delete a paragraph
" diB     delete inner '{' '}' block
" daB     delete a '{' '}' block
" d5j     delete 5 lines in 'j' direction
" xp      transpose 2 characters
" rc      replace the character under the cursor with c

"""" read-only registers
" "% 	    current file name
" "# 	    rotation file name
" ". 	    last inserted text
" ": 	    last executed command
" "/ 	    last found pattern
" "Ay       any upper case letter APPENDS to register

"""" special register
" "0      'y' copied text is stored in the nameless register `""`, also `"0`. `c`、`d`、`s`、`x` does not override this register.

"""" INSERT MODE KEYS
" <C-h>   delete the character before the cursor during insert mode
" <C-w>   delete word before the cursor during insert mode
" <C-j>   begin new line during insert mode
" <C-t>   indent (move right) line one shiftwidth during insert mode
" <C-d>   de-indent (move left) line one shiftwidth during insert mode
" <C-R>a  pastes the contents of the `a` register
" <C-R>"  pastes the contents of the unnamed register (last delete/yank/etc)

" send change arguments to blackhole registry
nnoremap c "_c
nnoremap C "_C

" copy paragraph
" nnoremap cp vap:t'><CR>

" insert mode paste from the clipboard just like on mac
inoremap <C-v> <C-r>*

" Indent/dedent what you just pasted
nnoremap <leader>< V`]<
nnoremap <leader>> V`]>

" reselect pasted text. gv, reselects the last visual selection
nnoremap gp `[v`]

" first character of line, end of line
" noremap H 0
" noremap L $

" scroll through time instead of space TODO (find non-mouse combo)
" map <ScrollWheelUp> :later 10m<CR>
" map <ScrollWheelDown> :earlier 10m<CR>

" Don't lose selection when shifting sidewards
"*** seems to remove the ability to '.' ***
" xnoremap < <gv
" xnoremap > >gv
" move cursor with it
" vnoremap <expr> > ">gv"..&shiftwidth.."l"
" vnoremap <expr> < "<gv"..&shiftwidth.."h"
" move cursor to beginning of line
" vnoremap > >gv^
" vnoremap < <gv^

set shell=/usr/local/bin/zsh

set title "displays current file as vim title
set visualbell "kills the bell
set t_vb= "kills the bell

" folds
" toggle folds
nnoremap <space><space> za
vnoremap <space><space> za
" zf#j creates a fold from the cursor down # lines.
" zf/ string creates a fold from the cursor to string .
" zj moves the cursor to the next fold.
" zk moves the cursor to the previous fold.
" za toggle a fold at the cursor.
" zo opens a fold at the cursor.
" zO opens all folds at the cursor.
" zc closes a fold under cursor.
" zm increases the foldlevel by one.
" zM closes all open folds.
" zr decreases the foldlevel by one.
" zR decreases the foldlevel to zero -- all folds will be open.
" zd deletes the fold at the cursor.
" zE deletes all folds.
" [z move to start of open fold.
" ]z move to end of open fold.
" treesitter
set fillchars+=fold:\    " space
" Open files without any folding
set foldlevelstart=99

" command line completion
set wildmenu

cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

set wildmode=longest:full,full
set wildoptions=pum
" set wildoptions+=pum
" Enables pseudo-transparency for the popup-menu, 0-100
set pumblend=20
set wildcharm=<Tab>
" set completeopt+=noselect,noinsert,menuone,preview
" set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,preview

" ignore case, example: :e TEST.js
set wildignorecase

" don't have vim autocomplete these ever
set wildignore+=tags
set wildignore+=package-lock.json
set wildignore+=**/*.xml
" off for telescope-node_modules usage
" set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

" give low priority to files matching the defined patterns.
set suffixes+=.lock,.scss,.sass,.min.js,.less,.json

let mapleader = ','

" save a shift in normal mode
" nnoremap ; :

" switch back and forth with two most recent files in buffer
" nnoremap <Backspace> <C-^>

" go back to last old buffer
" nnoremap <silent> <bs> <c-o><cr>
" go forward to next newest buffer
" nnoremap <silent> <tab> <c-i<cr>

" nnoremap <Leader><Tab> :buffer<Space><Tab>
" nnoremap <silent> <c-n> :bnext<CR>
" nnoremap <silent> <c-p> :bprev<CR>
" nnoremap <silent> <c-x> :bdelete<CR>

" vim tab navigation
" Next tab: gt
" Prior tab: gT
" Numbered tab: 7gt
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

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" add < and > to matched pairs
set matchpairs+=<:>

" Clear cmd line message after X seconds
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

" deep dive into configuring groups, commands, etc
" https://thevaluable.dev/vim-expert/
augroup cmd_msg_cls
  autocmd!
  autocmd CmdlineLeave : call timer_start(10000, funcref('s:empty_message'))
augroup END

augroup checktimegroup
  autocmd!
  " make it work with neovim
  augroup FocusGained * :checktime
augroup END

" hide line showing switch in insert/normal mode
set noshowmode
set noruler
set splitright
set splitbelow
set autoread " do not prompt and reload file system changes
set hidden " allows you to abandon a buffer without saving
set smartindent " Keep indentation from previous line
set showbreak=↳
set expandtab " Use softtabstop spaces instead of tab characters
set softtabstop=2 " Indent by 2 spaces when pressing <TAB>
set shiftwidth=2 " Indent by 2 spaces when using >>, <<, == etc.
set showtabline=2 " always display vim tab bar
set number
set relativenumber
set breakindent
set breakindentopt=shift:2
" display line movements unless preceded by a count
" also recording jump points for movements larger than five lines
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" use neovim nightly filetype detection
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained *.*,.* set relativenumber
  autocmd BufLeave,FocusLost   *.*,.* set norelativenumber
  " or by filetype
  " autocmd BufNewFile,BufRead *.myfile setlocal norelativenumber
augroup END

" disable relative numbers
nnoremap <leader>rn :set rnu!<cr>

" Toggle relative line numbers when entering Command mode (helpful for pair programming sessions)
" Open up Command mode ':' -> Partner can look for absolute line number -> Write down number -> Press enter
" autocmd CmdlineEnter * if &number | set norelativenumber | endif | redraw
" autocmd CmdLineLeave * if &number | set relativenumber | endif

" force decimal-based arithmetic on increment/decrement
set nrformats=
" increment and decrement
nnoremap + <C-a>
nnoremap - <C-x>
"  visual mode, also
" xnoremap + g<C-a>
" xnoremap - g<C-x>

" dot repetition over visual line selections.
xnoremap . :norm.<CR>

" run macro over visual lines (using qq to record)
xnoremap Q :'<,'>:normal @q<CR>

" https://www.reddit.com/r/neovim/comments/tsol2n/why_macros_are_so_slow_compared_to_emacs/
" overload @ key to execute the macro avoiding any auto command that may be triggred during insert mode or text change
" :noautocmd normal 10000@q
xnoremap @ :<C-U>execute "noautocmd '<,'>norm! " . v:count1 . "@" . getcharstr()<cr>

" backup/undo management
set nobackup
set nowritebackup
set noswapfile " Disable swapfile
" setup persistent undo
set undofile
set undodir=~/.vim/undo

" search highlighting/behavior
set hlsearch
set incsearch

" allow tab/s-tab to filter with incsearch in-progress
" cnoremap <expr> <Tab>   getcmdtype() =~ "[?/]" ? "<c-g>" : "<Tab>"
" cnoremap <expr> <S-Tab> getcmdtype() =~ "[?/]" ? "<c-t>" : "<S-Tab>"

" Make <C-p>/<C-n> act like <Up>/<Down> in cmdline mode, so they can be used to navigate history with partially completed commands
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <up> <c-p>
cnoremap <down> <c-n>

" use c-k/j to navigate cmdline menu
cnoremap <c-k> <Left>
cnoremap <c-j> <Right>

" juggling with jumps
nnoremap ' `
set jumpoptions=stack

set ignorecase
set infercase " enhances ignorecase
set smartcase
set inccommand=nosplit "highlight :s in realtime
set diffopt+=vertical,algorithm:patience
" allows block selections to operate across lines regardless of the underlying text
set virtualedit=block
set selection=old

set complete-=t " disable searching tags

" Toggle spell checking on/off
nmap <silent> <leader>ss :set spell!<CR>
set spelllang=en_us
set complete+=kspell
" z=, to get a suggestion
" ]s means go to next misspelling,
" [s is back. When you land on the word
" zw to add it to your Private dictionary
" zuw if you make a mistake to remove it from you dictionary
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand('<cword>'))
  return fzf#run({'source': suggestions, 'sink': function('FzfSpellSink'), 'options': '--preview-window hidden', 'down': 20})
endfunction
nnoremap z= :call FzfSpell()<CR>
nmap <silent> <leader>sz :call FzfSpell()<CR>

" keep windows same size when opening/closing splits
set equalalways

" only highlight cursorline in current active buffer, when not in insert mode
augroup STUFFS
  autocmd!
  " resize panes the host window is resized
 " NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize
  autocmd VimResume,VimResized, NvimTreeOpen, NvimTreeClose * wincmd =
  autocmd VimResized,VimResume * execute "normal! \<C-w>="
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
  " source $MYVIMRC when saving $MYVIMRC
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  " autocmd BufWritePost * if &diff | diffupdate | endif " update diff after save
  " autocmd BufWritePre *.md CocCommand markdownlint.fixAll
  " autocmd BufWritePost *.md CocCommand markdownlint.fixAll | echo 'hi'
  " autocmd BufWritePost *.jsx,*.js CocCommand eslint.executeAutofix
  autocmd FileType TelescopePrompt let b:coc_pairs_disabled = ["'"]

  " go back to previous tab when closing tab
  autocmd TabClosed * tabprevious
augroup END

"sessions
" Don't save hidden and unloaded buffers in sessions
set sessionoptions-=buffers
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options
" don't restore help windows
set sessionoptions-=help
" results with those ^: sessionoptions=blank,curdir,folds,tabpages,winsize

" split windows
nnoremap <C-w>- :new<cr>
nnoremap <C-w><bar> :vnew<cr>

function! InsertFilePath()
  execute 'normal i'.expand('%:p:h').'/'
endfunction
noremap <leader>ef :call InsertFilePath()<CR>

" open :e based on current file path
noremap <Leader>ep :e <C-R>=expand('%:p:h') . '/' <CR>
" Opens a new tab with the current buffer's path
noremap <leader>eb :tabedit <C-r>=expand("%:p:h")<CR>/
" Prompt to open file with same name, different extension
noremap <leader>er :e <C-R>=expand("%:r")."."<CR>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
" change directory to folder of current file
nnoremap <leader>cd :cd %:p:h<cr>

" open file under cursor anywhere on line
" https://www.reddit.com/r/vim/comments/mcxha4/remapping_gf_to_open_a_file_from_anywhere_on_the/
nnoremap gf ^f/gf

" open file under cursor in vertical split
map <C-w>f <C-w>vgf

"toggles whether or not the current window is automatically zoomed
function! ToggleMaxWins()
  if exists('g:windowMax')
    au! maxCurrWin
    wincmd =
    unlet g:windowMax
  else
    augroup maxCurrWin
        " au BufEnter * wincmd _ | wincmd |
        "
        " only max it vertically
        au! WinEnter * wincmd _
    augroup END
    do maxCurrWin WinEnter
    let g:windowMax=1
  endif
endfunction
nnoremap <C-w>m :call ToggleMaxWins()<cr>

" hide the command history buffer. Use fzf :History instead
nnoremap q: <nop>

" disable mouse
set mouse=

" keep foreground commands in sync
" map fg <c-z>
" or the reverse, add this to shell profile
" stty susp undef
" bind '"\C-z":"fg\n"'

" format json
nnoremap <silent> <Leader>jj :set ft=json<CR>:%!python -m json.tool<CR>

" format html
" nnoremap <silent> <Leader>ti :%!tidy -config ~/.config/tidy_config.txt %<CR>

" remove smart quotes
" %!iconv -f utf-8 -t ascii//translit

" save with Enter *except* in quickfix buffers
" https://vi.stackexchange.com/questions/3127/how-to-map-enter-to-custom-command-except-in-quick-fix
" nnoremap <expr> <silent> <CR> &buftype ==# "quickfix" ? "\<CR>" : ":write!<CR>"
nnoremap <Enter> :w<Enter>
nnoremap <leader><Enter> :w !sudo tee %<Enter>
" Keep default CR behaviour for quickfix list
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" can check type, not just name like:
" another option
" autocmd FileType qf nnoremap <buffer> <cr> <cr>

" train myself to use better commands
" ZZ - Write current file, if modified, and quit. (:x = :wq = ZZ)
" ZQ - Quit without checking for changes (same as ':q!')
map QQ :qa!<CR>
map QA :qa<CR>
cabbrev q! use ZQ
cabbrev wq use :x or ZZ
cabbrev wq! use :x!
cabbrev wqa use :xa
cabbrev wqa! use :xa!

" speedup :StartTime - :h g:python3_host_prog
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
" let g:loaded_node_provider = 1

call plug#begin('~/.config/nvim/plugged')
" if branch changes from master to main `git remote set-head origin -a` in `~/config/nvim/plugged/[plugin]`

" core code analysis and manipulation
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} |
           \ Plug 'antoinemadec/coc-fzf' |
           \ Plug 'wellle/tmux-complete.vim' " coc completion from open tmux panes
let g:coc_enable_locationlist = 0
let g:coc_global_extensions = [
          \ 'coc-coverage',
          \ 'coc-css',
          \ 'coc-cssmodules',
          \ 'coc-dash-complete',
          \ 'coc-db',
          \ 'coc-docker',
          \ 'coc-emoji',
          \ 'coc-eslint',
          \ 'coc-just-complete',
          \ 'coc-git',
          \ 'coc-html',
          \ 'coc-import-cost',
          \ 'coc-jest',
          \ 'coc-json',
          \ 'coc-just-complete',
          \ 'coc-lists',
          \ 'coc-lua',
          \ 'coc-markdownlint',
          \ 'coc-marketplace',
          \ 'coc-pairs',
          \ 'coc-prettier',
          \ 'coc-pyright',
          \ 'coc-react-refactor',
          \ 'coc-sh',
          \ 'coc-snippets',
          \ 'coc-solargraph',
          \ 'coc-spell-checker',
          \ 'coc-styled-components',
          \ 'coc-stylelintplus',
          \ 'coc-svg',
          \ 'coc-swagger',
          \ 'coc-tsserver',
          \ 'coc-vimlsp',
          \ 'coc-webpack',
          \ 'coc-yaml',
          \ 'coc-yank'
          \ ]
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } |
           \ Plug 'junegunn/fzf.vim'

" buffer management
Plug 'AndrewRadev/undoquit.vim'
"<c-w>u reopen windo
"<c-w>U reopen tab with all windows

" newer option
Plug 'kazhala/close-buffers.nvim'
map <leader>Bdo :BDelete other<CR>
map <leader>Bdh :BDelete hidden<CR>
map <leader>Bda :BDelete all<CR>
map <leader>Bdt :BDelete this<CR>
map <leader>Bdn :BDelete nameless<CR>

" undo tree visualizer
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
nmap <Leader>mt :MundoToggle<CR>
let g:mundo_right=1

augroup mundoauto
  autocmd!
  autocmd User vim-mundo echom 'vim-mundo is now loaded!'
augroup END

Plug 'NTBBloodbath/rest.nvim'
map <leader>rr <Plug>RestNvim
map <leader>rp <Plug>RestNvimPreview
map <leader>rL <Plug>RestNvimLast

" session management
Plug 'rmagatti/auto-session'

Plug 'preservim/vimux'
let g:VimuxUseNearest = 1
let g:VimuxOrientation = "v"
" Combine VimuxZoomRunner and VimuxInspectRunner in one function.
function! VimuxZoomInspectRunner()
  if exists("g:VimuxRunnerIndex")
    call VimuxTmux("select-pane -t ".g:VimuxRunnerIndex)
    call VimuxTmux("resize-pane -Z -t ".g:VimuxRunnerIndex)
    call VimuxTmux("copy-mode")
  endif
endfunction
map <Leader>vv     :call VimuxZoomInspectRunner()<CR>
map <Leader>vp     :VimuxPromptCommand<CR>
map <Leader>vl     :VimuxRunLastCommand<CR>
map <Leader>vi     :VimuxInspectRunner<CR>
map <leader>vz     :VimuxZoomRunner<CR>
map <Leader>vq     :VimuxCloseRunner<CR>
map <Leader>v<C-l> :VimuxClearTerminalScreen<CR>
map <Leader>vc     :VimuxClearRunnerHistory<CR>
map <Leader>vx     :VimuxInterruptRunner<CR>

" REPL usage
function! VimuxSlime()
  call VimuxClearTerminalScreen()
  call VimuxRunCommand(@v, 0)
  call VimuxSendKeys("Enter")
endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <leader>vs "vy :call VimuxSlime()<CR>
" Select current paragraph and send it to tmux
nmap <leader>vs vip<leader>vs<CR>
" send contents of entire buffer to tmux
nmap <leader>vb ggVG<leader>vs<CR>
" run file
nmap <Leader>vf :call VimuxRunCommand("clear; node " . bufname("%"))<CR>

" REPL
" vnoremap <leader>rn :w !node<Enter>
" vnoremap <leader>rr :w !ruby<Enter>
" vnoremap <leader>rp :w !python<Enter>

" dbs
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
let g:db_ui_show_database_icon = 1
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_force_echo_notifications = 1

" testing
Plug 'vim-test/vim-test'

" debugging
Plug 'mfussenegger/nvim-dap'

Plug 'ThePrimeagen/harpoon'
" left index finger
nnoremap <silent>\f :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent>\d :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

" lift the finger to do sth "dangerous"
nnoremap <silent>\g :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent>\f :lua require("harpoon.mark").add_file()<CR>

" right home row, no finger lifting required
nnoremap <silent>\j :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent>\k :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent>\l :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent>\; :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <silent>\n :lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent>\p :lua require("harpoon.ui").nav_prev()<CR>

nnoremap <silent>\tj :lua require("harpoon.tmux").gotoTerminal(1)<CR>
nnoremap <silent>\tk :lua require("harpoon.tmux").gotoTerminal(2)<CR>
nnoremap <silent>\cj :lua require("harpoon.tmux").sendCommand(1, 1)<CR>
nnoremap <silent>\ck :lua require("harpoon.tmux").sendCommand(1, 2)<CR>

" Plug 'plytophogy/vim-virtualenv'
" Plug 'PieterjanMontens/vim-pipenv'
" Plug 'petobens/poet-v'
" ?????????????
" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif
Plug 'mfussenegger/nvim-dap-python'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'David-Kunz/jester'

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/playground'
" :TSHighlightCapturesUnderCursor
" R: Refreshes the playground view when focused or reloads the query when the query editor is focused.
" o: Toggles the query editor when the playground is focused.
" a: Toggles visibility of anonymous nodes.
" i: Toggles visibility of highlight groups.
" I: Toggles visibility of the language the node belongs to.
" t: Toggles visibility of injected languages.
" f: Focuses the language tree under the cursor in the playground. The query editor will now be using the focused language.
" F: Unfocuses the currently focused language.
" <cr>: Go to current node in code buffer
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'mfussenegger/nvim-ts-hint-textobject'

" use tree-sitter highlighting for spellchecker
Plug 'lewis6991/spellsitter.nvim'

Plug 'andrewradev/sideways.vim'
nnoremap <A-Left> :SidewaysLeft<cr>
nnoremap <A-Right> :SidewaysRight<cr>
" cia - change an argument
" daa - delete an argument
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

Plug 'lukas-reineke/indent-blankline.nvim'
" fix blank line color issue
set colorcolumn=99999
if &diff
    let g:indent_blankline_enabled = v:false
endif
let g:indent_blankline_use_treesitter = v:true
" default listchars=tab:>,trail:-,nbsp:+
set list listchars=tab:→\ ,space:⋅,trail:•,nbsp:␣,extends:▶,precedes:◀
" extends:⟩,precedes:⟨,tab:│\ ,eol:, tab:<->
let g:indent_blankline_char = '▏'
" let g:indent_blankline_char_blankline = '┆'
" let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_filetype_exclude = [ 'startify', 'NvimTree', 'vim-plug' ]
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_bufname_exclude = ['README.md', '.*\.py']
let g:indent_blankline_show_first_indent_level = v:true
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:true
let g:indent_blankline_context_patterns = ['declaration', 'expression', 'pattern', 'primary_expression', 'statement', 'switch_body' ,'def', 'class', 'return', '^func', 'method', '^if', 'while', 'jsx_element', 'for', 'object', 'table', 'block', 'arguments', 'else_clause', '^jsx', 'try', 'catch_clause', 'import_statement', 'operation_type', 'with', 'except', 'arguments', 'argument_list', 'dictionary', 'element', 'tuple']

augroup tmuxgroups
  autocmd!
  autocmd FileType tmux nnoremap <silent><buffer> K :call tmux#man()<CR>
  " automatically source tmux config when saved
  autocmd BufWritePost .tmux.conf execute ':!tmux source-file %'
augroup END
Plug 'tmux-plugins/vim-tmux'
" https://github.com/nvim-treesitter/nvim-treesitter/issues/1019#issuecomment-812976740
let g:polyglot_disabled = [
        \ 'bash', 'comment', 'css', 'graphql',
        \ 'html', 'javascript', 'javascriptreact', 'jsdoc', 'json',
        \ 'jsonc', 'jsx', 'lua', 'python', 'regex', 'rspec', 'ruby',
        \ 'sh', 'svg', 'tmux', 'tsx', 'typescript', 'typescriptreact', 'yaml']
Plug 'sheerun/vim-polyglot'
" Plug 'sheerun/vim-polyglot', { 'commit': '2c5af8f' }
let g:polyglot_disabled = ['sensible']
let g:polyglot_disabled = ['ftdetect']
let g:polyglot_disabled = ['autoindent']
let g:markdown_fenced_languages = ['ruby', 'vim']
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
let g:shfmt_fmt_on_save = 1

Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

Plug 'rondale-sc/vim-spacejam' "removes trailing whitespace on save
let g:spacejam_filetypes = '*'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
let g:mkdp_browser = 'Chrome'
let g:mkdp_auto_start = 0
let g:mkdp_filetypes = ['markdown']
nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop
" display images in neovim
" https://github.com/edluffy/hologram.nvim

" markdown preview in nvim popup
Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
nmap <leader>mv :Glow<CR>
let g:glow_binary_path = $HOME . '/bin'
let g:glow_border = 'rounded'
let g:glow_width = 120
" q to quit, :Glow for current filepath

Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:openbrowser_default_search = 'duckduckgo'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" vim .dsl syntax https://github.com/vim/vim/pull/8764
" Plug 'shuntaka9576/preview-swagger.nvim', { 'build': 'yarn install' }
" Draw ASCII diagrams in Neovim.
" Plug 'jbyuki/venn.nvim'

" https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/
Plug 'tpope/vim-abolish'
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru)
" dash-case (cr-)
" Title Case (crt)

Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep'
" Don't jump to first match
cnoreabbrev Ack Ack!

" use ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m

" grep word under cursor in entire project into quickfix
nnoremap <leader><bs> :Ack! <C-R><C-W><CR>
" grep word under cursor all buffers in current window into quickfix
nnoremap <space><bs> :AckWindow! <C-R><C-W><CR>

" enhanced matchit
let g:loaded_matchit = 1
Plug 'andymass/vim-matchup'
let g:matchup_matchparen_offscreen = {'method': 'popup'}
" ---------------------------------------------~
"  LHS   RHS                   Mode   Module
" -----------------------------------------------~
"  %     |<plug>(matchup-%)|     nx     motion   - go forwards to its next matching word
"  g%    |<plug>(matchup-g%)|    nx     motion   - go backwards to [count]th previous matching word
"  [%    |<plug>(matchup-[%)|    nx     motion   - Go to [count]th previous outer open word
"  ]%    |<plug>(matchup-]%)|    nx     motion   - Go to [count]th next outer close word
"  z%    |<plug>(matchup-z%)|    nx     motion   - Go to inside [count]th nearest block
"  a%    |<plug>(matchup-a%)|    x      text_obj - Select an |any-block|
"  i%    |<plug>(matchup-i%)|    x      text_obj - Select the inside of an |any-block|
"  ds%   |<plug>(matchup-ds%)|   n      surround - Delete {count}th surrounding matching words
"  cs%   |<plug>(matchup-cs%)|   n      surround - Change {count}th surrounding matching words

" tab to exit enclosing character
Plug 'abecodes/tabout.nvim'

Plug 'phaazon/hop.nvim'
nmap <leader><leader> :HopWord<cr>
vmap <leader><leader> :HopWord<cr>
nmap <leader>/ :HopPattern<cr>

" Plug 'ggandor/leap.nvim'
Plug 'ggandor/lightspeed.nvim'
" nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
" nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
" nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
" nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

Plug 'drmingdrmer/vim-toggle-quickfix'

" quickfix item opening helper
Plug 'yssl/qfenter'
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

Plug 'kevinhwang91/nvim-bqf'
" https://github.com/kevinhwang91/nvim-bqf#function-table
" zf - fzf in quickfix
" zp - toggle full screen preview
" zn or zN - create new quickfix list
" < - previous quickfix list
" > - next quickfix list

" pretty qf
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'

Plug 'christoomey/vim-tmux-navigator'
" If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
let g:tmux_navigator_preserve_zoom = 1
" simplify split navigation
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

Plug 'christoomey/vim-system-copy'
" cp for copying and cv for pasting
" cpiw => copy word into system clipboard
" cpi' => copy inside single quotes to system clipboard
" cvi' => paste inside single quotes from system clipboard
" cP is mapped to copy the current line directly.
" cV is mapped to paste the content of system clipboard to the next line.
" other option: Plug 'ojroques/vim-oscyank'

" Plug 'tpope/vim-bundler' " use 'solargraph bundle' instead
"bundle bopen

Plug 'tpope/vim-commentary'
"gcc  - comment out line
"gcap - comment out paragraph
"gcgc - uncomment a set of adjacent commented lines

" add viml/lua commenting support
Plug 'suy/vim-context-commentstring',  { 'for': 'vim' }

"Vim sugar for the UNIX shell commands
Plug 'tpope/vim-eunuch'

"json motions
Plug 'tpope/vim-jdaddy'
" ij                      Text object for innermost JSON number, string, array, object, or keyword (including but not limited to true/false/null).
" aj                      Text object for outermost JSON object or array.
" gqij                    Replace the innermost JSON with a pretty printed version.
" gqaj                    Replace the outermost JSON with a pretty printed version.
" ["x]gwij                Merge the JSON from the register into the innermost JSON.  Merging extends objects, concatenates strings and arrays, and adds numbers.
" ["x]gwaj                Merge the JSON from the register into the outermost JSON.

Plug 'mogelbrod/vim-jsonpath'
" :JsonPath: Echoes the path to the identifier under the cursor.
" :JsonPath path.to.prop

" try https://github.com/kana/vim-altr/blob/master/doc/altr.txt ?
Plug 'tpope/vim-projectionist'

"gf support
Plug 'tpope/vim-apathy'

Plug 'tpope/vim-rails'
let g:loaded_ruby_provider = 0 " use language server instead
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
"automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'tpope/vim-surround'
"quoting/parenthesizing made simple
" {{{
    " mappings to quickly modify surrounding chars like ",],),},',<tag>
    " NORMAL MODE:
    "   ds<SURROUND> to delete surround
    "   cs<SURROUND><SURROUND> to change surround from/to
    "   ys<TEXT-OBJECT><SURROUND> to surround text object
    "   yS<TEXT-OBJECT><SURROUND> to surround text object on new line
    " VISUAL MODE:
    "   S<SURROUND>
    " INSERT MODE:
    "   <C-g>s<SURROUND>
  " }}}
" vitSt - add inner tag
" vatSt - add surrounding tag
" vS"    : visually surround selected text with "
" yswt : prompt & surround with a html tag
" yswf : prompt & surround with a function call
" ds" : delete surrounding "
" dst : delete surrounding tag (HTML)
" in case I need to unmap them: https://github.com/mgarort/dotvim/blob/e67260d70377c28a0d0a08d8f3733adb05d5d4bd/vimrc#L987-L1000

augroup jsconsolecmds
  autocmd!
  "wrap in console.log - yswc or yssc TODO: broken also??
  " autocmd FileType typescriptreact,javascript,javascriptreact,typescript let b:surround_{char2nr('c')} = 'console.log(\r)'
  " autocmd FileType typescriptreact,javascript,javascriptreact,typescript let b:surround_{char2nr('e')} = '${\r}'
  " move word under cursor up or down a line wrapped in a console.log
  " or use: https://github.com/meain/vim-printer
  autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <buffer> <leader>cO "zyiwOconsole.log(z)<Esc>
  autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <buffer> <leader>co "zyiwoconsole.log(z)<Esc>
augroup END

Plug 'tpope/vim-unimpaired'
" prev conflict/patch: [n , next conflict/patch: ]n , paste toggle: yop
" [<Space> and ]<Space> add newlines before and after the cursor line
" [e and ]e exchange the current line with the one above or below it.

Plug 'tpope/vim-speeddating'
" increment/decrement dates <C-A>/<C-X>

" try https://github.com/wellle/targets.vim ?
" https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
" adds 'al' and 'il' motions for a line
" 'il' ignores leading and trailing spaces. 'al' ignoes EOL

Plug 'kana/vim-textobj-indent'
" ai	<Plug>(textobj-indent-a)
" ii	<Plug>(textobj-indent-i)
" aI	<Plug>(textobj-indent-same-a)
" iI	<Plug>(textobj-indent-same-i)
Plug 'vimtaku/vim-textobj-keyvalue'
" ak	<Plug>(textobj-key-a)
" ik	<Plug>(textobj-key-i)
" av	<Plug>(textobj-value-a)
" iv	<Plug>(textobj-value-i)

" Plug 'Julian/vim-textobj-variable-segment'
" iv and av for variable segments, snake_case, camelCase, etc

Plug 'rhysd/vim-textobj-anyblock'
" ib is a union of i(, i{, i[, i', i" and i<
" ab is a union of a(, a{, a[, a', a" and a<

" https://github.com/mlaursen/vim-react-snippets#cheatsheet
Plug 'mlaursen/vim-react-snippets', { 'branch': 'main' }

" review linenumber before jump
Plug 'nacro90/numb.nvim'

" Plug 'metakirby5/codi.vim'
Plug 'timtyrrell/codi.vim'
let g:codi#aliases = {
  \ 'javascriptreact': 'javascript',
  \ 'typescriptreact': 'typescript',
  \ }

" diff visual selections
Plug 'andrewradev/linediff.vim'
" :Linediff

Plug 'sindrets/diffview.nvim'
nmap <leader>dvh :DiffviewFileHistory<cr>
nmap <leader>dvo :DiffviewOpen<cr>
nmap <leader>dvc :DiffviewClose<cr>
nmap <leader>dvt :DiffviewToggleFiles<cr>
nmap <leader>dvr :DiffviewRefresh<cr>

" git
Plug 'tpope/vim-fugitive' |
           \ Plug 'junegunn/gv.vim' |
           \ Plug 'tpope/vim-rhubarb' | "GitHub extension for fugitive.vim

" https://github.com/tpope/vim-fugitive/issues/1446
" fix older husky versions
let g:fugitive_pty = 0

" Fugitive mapping
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gB :%Git blame<cr>
nnoremap <leader>gd :Gdiff<cr>

" list names of changes files in quickfix
nnoremap <silent><leader>gt <cmd>Git difftool --name-only<CR>
" list all locations of changed files in quickfix
nnoremap <silent><leader>gT <cmd>Git difftool<CR>

" git history log of current file
nnoremap <silent><Leader>gl <cmd>0Git log<CR>
" git history log of repo
nnoremap <silent><Leader>gL <cmd>Git log<CR>

nnoremap <leader>gc :Gclog<cr>
vnoremap <leader>gc :Gclog<cr>
nnoremap <leader>gC :Gclog -- %<cr>
" nmap <leader>gL :Gclog -100<cr>
" 'o' to see diff, 'O' to open in new tab
" coo to checkout and switch to that commit

" :Gedit is 'git checkout %' => reverts work tree file to index, be careful!
nnoremap <Leader>ge :Gedit<Space>
nnoremap <silent><Leader>ge :Gedit <bar> only<CR>
" :Gedit main:file.js to open file version in another branch
" :Gedit " go back to normal file from read-only view in Gstatus window

nnoremap <leader>gr :Gread<cr>:update<cr>
" :Gread main:file.js to replace file from one in another branch

" git grep 'foo bar' [branch/SHA]
" git log --grep='foobar' to search commit messages
" git log -Sfoobar (when 'foobar' was added/removed)
nnoremap <leader>gg :Gcgrep! -q<space>
nnoremap <Leader>g/ :Gcgrep! -Hnri --quiet<Space>
nnoremap <Leader>g? :Git! log --grep=
" nnoremap <Leader>gS :Git! log -S<Space>
nnoremap <Leader>g* :Gcgrep! -Hnri --quiet <C-r>=expand("<cword>")<CR><CR>

nnoremap <silent><leader>gi <cmd>Git commit<CR>
nnoremap <silent><Leader>gP <cmd>Git push<CR>
nnoremap <silent><Leader>gp <cmd>Git pull<CR>
nnoremap <silent><Leader>gf <cmd>Git fetch<CR>

" Open visual selection in browser
vnoremap <Leader>Gb :GBrowse<CR>
" Open current line in the browser
nnoremap <Leader>Gb :.GBrowse<CR>

" Copy visual selection url to clipboard
vnoremap <Leader>GB :GBrowse!<CR>
" Copy current line url to clipboard
nnoremap <Leader>GB :.GBrowse!<CR>

" open project
nnoremap <Leader>go <cmd>GBrowse main<cr>

" Add <cfile> to index and save
nnoremap <silent><Leader>gw <cmd>Gwrite<CR>
" gW useful in 3 way merge diffs: choose a buffer and use gW to use all that versions' changes, i.e., --ours/theirs
nnoremap <silent><Leader>gW <cmd>Gwrite!<CR>

augroup fugitive_ext
  autocmd!
  " Browse to the commit under my cursor
  autocmd FileType fugitiveblame nnoremap <buffer> <leader>Gb :execute ":GBrowse " . expand("<cword>")<cr>
  " autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
augroup END

function! s:ToggleGitStatus() abort
  for l:winnr in range(1, winnr('$'))
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr.'close'
    else
      Git
    endif
  endfor
endfunction
nnoremap <leader>gs :call <SID>ToggleGitStatus()<CR>
nnoremap <leader>gS :0Git<CR>
" P (on the file you want to run patch on)
" <C-N> or <C-P> to jump to the next/previous file
" - on a file, stages (or unstages) the entire file.
" = shows the git diff of the file your cursor is on.
" - on a hunk, stages (or unstages) the hunk.
" - in a visual selection, stages (or unstages) the selected lines in the hunk.
" cc                      Create a commit.
" ca                      Amend the last commit and edit the message.
" ce                      Amend the last commit without editing the message.
" cw                      Reword the last commit.
" cvc                     Create a commit with -v.
" cva                     Amend the last commit with -v
" cf                      Create a `fixup!` commit for the commit under the cursor.
" cF                      Create a `fixup!` commit for the commit under the cursor and immediately rebase it.
" cs                      Create a `squash!` commit for the commit under the cursor.
" cS                      Create a `squash!` commit for the commit under the cursor and immediately rebase it.
" cA                      Create a `squash!` commit for the commit under the cursor and edit the message.
" crc                     Revert the commit under the cursor.
" crn                     Revert the commit under the cursor in the index and work tree, but do not actually commit the changes.
" :GV to open commit browser, git log options to the command, e.g. :GV -S foobar.
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
" :Gwrite[!] write the current file to the index and exits vimdiff mode.
" HUNKS
" do - `diffget` (obtain)
" dp - `diffput`
" staging hunks: https://vi.stackexchange.com/questions/10368/git-fugitive-how-to-git-add-a-visually-selected-chunk-of-code/10369#10369

" put changed file names from previous commit into the quickfix list
command -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))

" command line mergetool
Plug 'christoomey/vim-conflicted'
" `git conflicted` or `git mergetool` to open
" `:GitNextConflict` go to next file
" `dgu` - diffget from the upstream version
" `dgl` - diffget from the local version
" [c and ]c to navigate conflicts in file

" disable showing '------' for empty line in difftool
set fillchars+=diff:╱

Plug 'rhysd/git-messenger.vim'
" <Leader>gm
" q 	Close the popup window
" o/O 	older commit/newer commit
" d/D 	Toggle diff hunks only related to current file in the commit/All Diffs

" more pleasant editing of commit message
Plug 'rhysd/committia.vim'
let g:committia_open_only_vim_starting = 1
let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell
    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif
    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" display diff while in interactive rebase
Plug 'hotwatermorning/auto-git-diff'

Plug 'iberianpig/tig-explorer.vim'
" open tig with Project root path
nnoremap <Leader>tig :TigOpenProjectRootDir<CR>
" open tig with current file
nnoremap <Leader>tif :TigOpenCurrentFile<CR>
" open tig grep with the word under the cursor
nnoremap <Leader>tic :<C-u>:TigGrep<Space><C-R><C-W><CR>
" open tig blame with current file
nnoremap <Leader>tib :TigBlame<CR>

" otherwise I lose what was open in the buffer...
let g:tig_explorer_use_builtin_term=0

let g:tig_explorer_keymap_edit_e  = 'e'
let g:tig_explorer_keymap_edit    = '<C-o>'
let g:tig_explorer_keymap_tabedit = '<C-t>'
let g:tig_explorer_keymap_split   = '<C-s>'
let g:tig_explorer_keymap_vsplit  = '<C-v>'

let g:tig_explorer_keymap_commit_edit    = '<ESC>o'
let g:tig_explorer_keymap_commit_tabedit = '<ESC>t'
let g:tig_explorer_keymap_commit_split   = '<ESC>s'
let g:tig_explorer_keymap_commit_vsplit  = '<ESC>v'
" bclose.vim required for neovim and tig-explorer
Plug 'rbgrouleff/bclose.vim'
let g:bclose_no_plugin_maps = 1

Plug 'kevinhwang91/nvim-hlslens'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>te <cmd>Telescope<cr>

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'pwntester/octo.nvim'
nnoremap <leader>opr <cmd>Octo pr list<cr>
nnoremap <leader>ors <cmd>Octo review start<cr>
nnoremap <leader>orr <cmd>Octo review resume<cr>
nnoremap <leader>orb <cmd>Octo review submit<cr>

Plug 'nvim-telescope/telescope-node-modules.nvim'
nnoremap <leader>fn <cmd>Telescope node_modules list<cr>

Plug 'dhruvmanila/telescope-bookmarks.nvim'

Plug 'xiyaowong/telescope-emoji.nvim'
" Plug 'nvim-telescope/telescope-symbols.nvim'

Plug 'TC72/telescope-tele-tabby.nvim'
Plug 'LinArcX/telescope-env.nvim'

" Plug 'tami5/sqlite.lua'
" Plug 'AckslD/nvim-neoclip.lua'

" Plug 'tami5/sql.nvim'
" Plug 'nvim-telescope/telescope-frecency.nvim'

Plug 'fannheyward/telescope-coc.nvim'

Plug 'norcalli/nvim-terminal.lua'
" https://github.com/akinsho/toggleterm.nvim

Plug 'mrjones2014/dash.nvim', { 'do': 'make install'}

Plug 'nvim-telescope/telescope-github.nvim'
Plug 'rlch/github-notifications.nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons, nvim-tree and others

" try https://github.com/nvim-neo-tree/neo-tree.nvim ?
Plug 'kyazdani42/nvim-tree.lua'
nnoremap <silent> <leader>ee :NvimTreeFindFile<CR>
nnoremap <silent> <leader>et :NvimTreeToggle<CR>
nnoremap <silent> <leader>er :NvimTreeRefresh<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, NvimTreeResize, NvimTreeCollapse
" NvimTreeCollapseKeepBuffers
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1

" https://levelup.gitconnected.com/git-worktrees-the-best-git-feature-youve-never-heard-of-9cd21df67baf
Plug 'ThePrimeagen/git-worktree.nvim'

" regex explain - :ExplainPattern {pattern} or :ExplainPattern {register}
Plug 'Houl/ExplainPattern'
Plug 'bennypowers/nvim-regexplainer'

Plug 'tpope/vim-scriptease'
" https://codeinthehole.com/tips/debugging-vim-by-example/#why-isn-t-syntax-highlighting-working-as-i-want
" zS to indentify the systen region name
" :verbose hi jsTemplateString
" :Messages load messages into quickfix

" visiblity
" TODO: try ? https://github.com/karb94/neoscroll.nvim
Plug 'psliwka/vim-smoothie'
let g:smoothie_base_speed = 30

Plug 'Konfekt/FastFold'
let g:fastfold_savehook = 1
" Plug 'Jorengarenar/vim-syntaxMarkerFold' ?
" Plug 'anuvyklack/pretty-fold.nvim'

" no recent updates, try this? https://github.com/edluffy/specs.nvim
Plug 'danilamihailov/beacon.nvim'
let g:beacon_ignore_filetypes = ['git', 'startify']
let g:beacon_show_jumps = 0
let g:beacon_ignore_buffers = ["Mundo"]
let g:beacon_focus_gained = 1

if !&diff
  let g:beacon_show_jumps = 0
  let g:beacon_ignore_buffers = [
      \ 'Mundo',
      \ '\w*git*\w',
      \ '\w*fugitive*\w',
      \ '\w*defx*\w',
      \ 'fzf',
      \]
  " cursor to be highlighted when you jump to searches with n/N regardless of distance, use this mappings
  " nmap <silent> n n:Beacon<cr>
  " nmap <silent> N N:Beacon<cr>
  " nmap <silent> * *:Beacon<cr>
  " nmap <silent> # #:Beacon<cr>
endif

" Plug 'google/vim-searchindex'

Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
let g:registers_window_border = "double"
let g:registers_show_empty_registers = 0
let g:registers_delay = 1000

Plug 'chentau/marks.nvim'

" displays colors for words/hex
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['backgroundfull']
" let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'less', 'vim', 'conf', 'tmux', 'gitconfig', 'xml', 'lua', 'stylus', 'sh']

" appearence and insight
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsOS = 'Darwin'
Plug 'bryanmylee/vim-colorscheme-icons'

" massive cmdline improvement
function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
Plug 'romgrk/fzy-lua-native', { 'do': 'make' }
Plug 'nixprime/cpsm', { 'do': 'PY3=ON ./install.sh' }

Plug 'itchyny/lightline.vim' |
          \ Plug 'konart/vim-lightline-coc'

Plug 'folke/tokyonight.nvim'
" Plug 'EdenEast/nightfox.nvim'

" center windows, all splits
Plug 'jmckiern/vim-venter'
let g:venter_width = &columns/6
nnoremap <leader>ve :VenterToggle<CR>

" center current buffer only
Plug 'folke/zen-mode.nvim'
nnoremap <leader>zm :ZenMode<CR>
" treesitter focus on current scope
Plug 'folke/twilight.nvim'
nnoremap <leader>zt :Twilight<CR>

Plug 'hoschi/yode-nvim'
map  <leader>yc :YodeCreateSeditorFloating<CR>
map  <leader>yr :YodeCreateSeditorReplace<CR>
nmap <leader>ybd :YodeBufferDelete<cr>
imap <leader>ybd <esc>:YodeBufferDelete<cr>
map  <leader>yd :BDelete glob=yode*<cr>

" these commands fall back to overwritten keys when cursor is in split window
" <c-w>w to move to float, next float, or back to main window
map  <C-W>r :YodeLayoutShiftWinDown<CR>
map  <C-W>R :YodeLayoutShiftWinUp<CR>
map  <C-W>J :YodeLayoutShiftWinBottom<CR>
map  <C-W>K :YodeLayoutShiftWinTop<CR>

Plug 'voldikss/vim-browser-search'
nmap <silent> <Leader>bs <Plug>SearchNormal
vmap <silent> <Leader>bs <Plug>SearchVisual
let g:browser_search_default_engine = 'duckduckgo'
let g:browser_search_engines = {
  \ 'duckduckgo': 'https://duckduckgo.com/?q=%s',
  \ 'github':'https://github.com/search?q=%s',
  \ 'google':'https://google.com/search?q=%s',
  \ 'stackoverflow':'https://stackoverflow.com/search?q=%s',
  \ }

Plug 'MunifTanjim/nui.nvim'
Plug 'vuki656/package-info.nvim'

" monorepo
Plug 'airblade/vim-rooter'
" add git worktree to excludes
let g:rooter_patterns = ['!.git/worktrees', '.git', 'Makefile']
" trigger by symlinks, also
let g:rooter_resolve_links = 1
" to stop echo on change **KEEP ON**, echoes filename to cmdline
let g:rooter_silent_chdir = 1

" life
Plug 'dstein64/vim-startuptime'
" gf to go deeper
" K for more info
" Plug 'tweekmonster/startuptime.vim'

" replace vimwiki?
" Plug 'dkarter/bullets.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev', 'for': 'markdown', 'on': 'VimwikiMakeDiaryNote' }
augroup load_vimwiki
  autocmd!
  autocmd! User Vimwiki echom 'Vimwiki is now loaded!'
augroup END

Plug 'mattn/calendar-vim'
let g:calendar_no_mappings=0
nmap <Leader>wdc <Plug>CalendarV
nmap <Leader>wdC <Plug>CalendarH

Plug 'alok/notational-fzf-vim'
Plug 'ferrine/md-img-paste.vim'

" horizontal lines for vimwiki
Plug 'lukas-reineke/headlines.nvim'

Plug 'LudoPinelli/comment-box.nvim'
nnoremap <Leader>bb :CBlbox<CR>
vnoremap <Leader>bb :CBlbox<CR>
nnoremap <Leader>bc :CBcbox<CR>
vnoremap <Leader>bc :CBcbox<CR>
nnoremap <Leader>bl :CBline<CR>

" scratch window
Plug 'mtth/scratch.vim'
" persist scratch file for project session
let g:scratch_persistence_file = '.scratch.vim'
" don't hide when leaving window
let g:scratch_autohide = 1
" don't autohide when leaving insert mode
let g:scratch_insert_autohide = 1
let g:scratch_filetype = 'scratch'
let g:scratch_height = 5
let g:scratch_top = 1
let g:scratch_horizontal = 1
let g:scratch_no_mappings = 1
nmap <leader>sp :ScratchPreview<CR>
" nmap <leader>se :Scratch<CR>
nmap <leader>si <plug>(scratch-insert-reuse)
nmap <leader>sc <plug>(scratch-insert-clear)
xmap <leader>sr <plug>(scratch-selection-reuse)
xmap <leader>sC <plug>(scratch-selection-clear)

" learning
Plug 'folke/which-key.nvim'

" Plug 'takac/vim-hardtime'
" let g:hardtime_default_on = 1
" let g:hardtime_timeout = 1000
" let g:hardtime_showmsg = 1
" let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
" let g:list_of_visual_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
" let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
" let g:list_of_disabled_keys = []
" let g:hardtime_ignore_quickfix = 1
" let g:hardtime_ignore_buffer_patterns = ['help', 'nofile', 'nowrite', 'man']
" let g:hardtime_allow_different_key = 1
" let g:hardtime_maxcount = 3

" bugfix
" fix CursorHold perf bug
Plug 'antoinemadec/FixCursorHold.nvim'

" typescript fork of 'ianding1/leetcode.vim'
" Plug 'briemens/leetcode.vim'
Plug 'mbledkowski/neuleetcode.vim'
let g:leetcode_solution_filetype='javascript'
let g:leetcode_username='timtyrrell'
let g:leetcode_browser='firefox'
let g:leetcode_problemset='algorithms'
let g:leetcode_hide_paid_only=0
let g:leetcode_hide_topics=0
let g:leetcode_hide_companies=0
nnoremap <leader>ll :LeetCodeList<cr>
nnoremap <leader>lt :LeetCodeTest<cr>
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>li :LeetCodeSignIn<cr>
nnoremap <leader>lr :LeetCodeReset<cr>

call plug#end()

" Unhighlight search results
map <Leader><space> :nohl<cr>
" nmap <silent> <BS>  :nohlsearch<CR>

" do not jump from item on * search
nnoremap * *``<Cmd>lua require('hlslens').start()<CR>
nnoremap * m`:keepjumps normal! *``<cr><Cmd>lua require('hlslens').start()<CR>
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>

call wilder#setup({'modes': [':', '/', '?']})

cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
cmap <expr> <c-j> wilder#in_context() ? wilder#next() : "\<c-j>"
cmap <expr> <c-k> wilder#in_context() ? wilder#previous() : "\<c-k>"

" '-I' to ignore respect .gitignore, '-H' show hidden files
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': {_, arg -> stridx(arg, '.') != -1 ?
      \         ['fd', '-tf', '-H', '-I', '-E', '.git', '-E', '.venv'] :
      \         ['fd', '-tf']},
      \       'dir_command': ['fd', '-td'],
      \       'filters': ['cpsm_filter'],
      \     }),
      \     wilder#substitute_pipeline({
      \       'pipeline': wilder#python_search_pipeline({
      \         'skip_cmdtype_check': 1,
      \         'pattern': wilder#python_fuzzy_pattern({
      \           'start_at_boundary': 0,
      \         }),
      \       }),
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 2,
      \       'fuzzy_filter': wilder#lua_fzy_filter(),
      \     }),
      \     [
      \       wilder#check({_, x -> empty(x)}),
      \       wilder#history(),
      \     ],
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern({
      \         'start_at_boundary': 0,
      \       }),
      \     }),
      \   ),
      \ ])

let s:highlighters = [ wilder#lua_fzy_highlighter() ]

let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'reverse': 1,
      \ 'border': 'rounded',
      \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \ 'highlights': { 'accent': 'Statement'},
      \ 'highlighter': s:highlighters,
      \ 'left': [
      \   ' ',
      \   wilder#popupmenu_devicons(),
      \   wilder#popupmenu_buffer_flags({
      \     'flags': ' a + ',
      \     'icons': {'+': '', 'a': '', 'h': ''},
      \   }),
      \ ],
      \ 'right': [
      \   ' ',
      \   wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

let s:wildmenu_renderer = wilder#wildmenu_renderer(
      \ wilder#wildmenu_lightline_theme({
      \   'highlighter': s:highlighters,
      \   'highlights': { 'accent': 'Statement'},
      \   'separator': ' · ',
      \ }))

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': s:popupmenu_renderer,
      \ '/': s:popupmenu_renderer,
      \ 'substitute': s:wildmenu_renderer,
      \ }))

" lazy way seems slower
" call wilder#enable_cmdline_enter()
" autocmd CmdlineEnter * ++once call s:wilder_init() | call s:wilder#main#start()
" augroup my_wilder_init
"   autocmd!
"   autocmd CmdlineEnter * ++once call s:wilder_init()
" augroup END

" mfussenegger/nvim-ts-hint-textobject
" example: `vm` to visually display hints to select
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>

" nvim/shada is dumb with marks, don't save for new session
" https://www.reddit.com/r/neovim/comments/q7bgwo/comment/hghwogp/?context=3
set shada=!,'0,f0,<50,s10,h

" don't open on blank dir (startify)
" augroup NvimTreeConfig
"   au!
"   au BufEnter * if isdirectory(expand('%')) | exec("cd " . expand('%')) | exec('NvimTreeOpen') | endif
" augroup END

lua << EOF

-- fold settings
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.fillchars = "fold: "
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

require('regexplainer').setup {}
require('harpoon').setup {}
require('yode-nvim').setup {}
require('tabout').setup {}
require('nvim-web-devicons').setup {}
require('which-key').setup {}
require('spellsitter').setup()
require('headlines').setup {
  vimwiki = {
    source_pattern_start = "^```",
    source_pattern_end = "^```$",
    dash_pattern = "^---+$",
    headline_pattern = "^#+",
    headline_highlights = { "Headline" },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    dash_string = "-",
    fat_headlines = true,
  },
}
require('terminal').setup {}
require('pqf').setup {}

require('package-info').setup({
  autostart = true,
  package_manager = 'npm'
})
-- Show package versions
vim.api.nvim_set_keymap("n", "<leader>ns", ":lua require('package-info').show()<CR>", { silent = true, noremap = true })
-- Hide package versions
vim.api.nvim_set_keymap("n", "<leader>nc", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- Update package on line
vim.api.nvim_set_keymap("n", "<leader>nu", ":lua require('package-info').update()<CR>", { silent = true, noremap = true })
-- Delete package on line
vim.api.nvim_set_keymap("n", "<leader>nd", ":lua require('package-info').delete()<CR>", { silent = true, noremap = true })
-- Install a new package
vim.api.nvim_set_keymap("n", "<leader>ni", ":lua require('package-info').install()<CR>", { silent = true, noremap = true })
-- Reinstall dependencies
vim.api.nvim_set_keymap("n", "<leader>nr", ":lua require('package-info').reinstall()<CR>", { silent = true, noremap = true })
-- Install a different package version
vim.api.nvim_set_keymap("n", "<leader>np", ":lua require('package-info').change_version()<CR>", { silent = true, noremap = true })

-- Open sub-folds at current code block level
local function open_sub_folds()
  local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
  local fold_closed = vim.fn.foldclosed(line_data[1])
  if fold_closed == -1 then -- not folded
    return  "zczO"
  else -- if fold - then open normall
    return "zO"
  end
end
vim.keymap.set( "n", "zO", open_sub_folds, { remap = false, expr = true } )

require('auto-session').setup {
  log_level = 'info',
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  auto_session_suppress_dirs = {'~/', '~/code'},
  pre_save_cmds = {"lua require'nvim-tree'.setup()", "tabdo NvimTreeClose", "BDelete! nameless", "BDelete! hidden", "BDelete glob=yode*"}
}

vim.cmd([[
    hi BqfPreviewBorder guifg=#50a14f ctermfg=71
    hi link BqfPreviewRange Search
]])

require('bqf').setup({
    auto_enable = true,
    auto_resize_height = true,
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'},
        should_preview_cb = function(bufnr)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
                -- skip file size greater than 100k
                ret = false
            elseif bufname:match('^fugitive://') then
                -- skip fugitive buffer
                ret = false
            end
            return ret
        end
    },
    -- make `drop` and `tab drop` preferred
    func_map = {
        open = '<cr>',
        openc = 'O', -- open item, close quickfix
        drop = 'o', -- open item, close quickfix
        split = '<C-s>',
        vsplit = '<C-v>',
        tabdrop = '<C-t>',
        tab = 't',
        tabb = 'T', -- open item in new tab, keep current focus
        tabc = '',
        ptogglemode = 'zp', -- toggle preview window between normal and max size
        sclear = 'z<Tab>', -- clear signs
        filter = 'zn', -- create new list for signed items
        filterr = 'zN', -- create new list for non-signed items
        fzffilter = 'zf', -- fzf mode
        prevthis = '<', -- go to previous quickfix list in quickfix window
        nexthist = '>', -- go to next quickfix list in quickfix window
    },
    filter = {
        fzf = {
            action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
})

require('nvim-tree').setup {
  disable_netrw       = false,
  hijack_netrw        = false,
  ignore_ft_on_setup  = {"startify"},
  hijack_cursor       = true,
  diagnostics = {
    enable = true,
  },
  update_to_buf_dir   = {
    enable = true,
    auto_open = false,
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  filters = {
    custom = {} -- list of string that will not be shown
  },
  view = {
    width = '20%',
    auto_resize = true,
    mappings = {
      list = {}
    }
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  }
}

-- require'nvim-tree.events'.on_nvim_tree_ready(function ()
--   vim.cmd("NvimTreeRefresh")
-- end)

require('rest-nvim').setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
  },
  -- Jump to request line on run
  jump_to_request = false,
})

require'lightspeed'.setup {
  -- jump_to_unique_chars = false,
  -- safe_labels = {} ,
  -- repeat_ft_with_target_char = false,
}

require('hop').setup()
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('x', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('x', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})

vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})

require'marks'.setup {
  bookmark_0 = {
    sign = "⚑",
    virt_text = "FIX THIS"
  },
}

-- mx              Set mark x
-- m,              Set the next available alphabetical (lowercase) mark
-- m;              Toggle the next available mark at the current line
-- dmx             Delete mark x
-- dm-             Delete all marks on the current line
-- dm<space>       Delete all marks in the current buffer
-- m]              Move to next mark
-- m[              Move to previous mark
-- m:              Preview mark. This will prompt you for a specific mark to
--                 preview; press <cr> to preview the next mark.

-- m[0-9]          Add a bookmark from bookmark group[0-9].
-- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
-- m}              Move to the next bookmark having the same type as the bookmark under
--                 the cursor. Works across buffers.
-- m{              Move to the previous bookmark having the same type as the bookmark under
--                 the cursor. Works across buffers.
-- dm=             Delete the bookmark under the cursor.
--
-- :MarksToggleSigns - Toggle signs in the buffer
-- :MarksListBuf - Fill the location list with all marks in the current buffer
-- :MarksQFListBuf
-- :MarksListGlobal - Fill the location list with all global marks in open buffers
-- :MarksQFListGlobal
-- :MarksListAll - Fill the location list with all marks in all open buffers
-- :MarksQFListAll

require("twilight").setup {}
require('zen-mode').setup {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    width = .5, -- width of the Zen window
    height = 1, -- height of the Zen window
  },
}

local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- https://github.com/nvim-telescope/telescope.nvim/blob/d0cf646f65746415294f570ec643ffd0101ca3ab/lua/telescope/mappings.lua
require('telescope').setup {
  defaults = {
    path_display = { truncate = 2 },
    wrap_results = true,
    layout_config = {
      horizontal = {
        prompt_position = "top"
      },
    },
    sorting_strategy = "ascending",
    mappings = {
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
        -- [""]    = actions.toggle_preview,
        ["<C-n"]  = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- [""]    = actions.toggle_preview,
        ["<C-n"]  = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        ['<c-d>'] = require('telescope.actions').delete_buffer,
      },
    },
  },
  pickers = {
    current_buffer_fuzzy_find = {
      skip_empty_lines = true,
    },
    grep_string = {
      sort_only_text = true,
      -- additional_args = function(opts)
      --   if opts.search_all == true then
      --       return {}
      --   end
      --   local args_for_ext = {
      --     ["ts"]  = "-tts",
      --     ["js"]  = "-tjs",
      --   }
      --   return { args_for_ext[vim.bo.filetype] }
      -- end,
    },
    live_grep = {
      only_sort_text = true,
      -- additional_args = function(opts)
      --   if opts.search_all == true then
      --       return {}
      --   end
      --   local args_for_ext = {
      --     ["ts"]  = "-tts",
      --     ["js"]  = "-tjs",
      --   }
      --   return { args_for_ext[vim.bo.filetype] }
      -- end,
    },
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    dash = {
      -- map filetype strings to the keywords you've configured for docsets in Dash
      -- setting to false will disable filtering by filetype for that filetype
      fileTypeKeywords = {
        startify = false,
        TelescopePrompt = false,
        terminal = false,
        -- a table of strings will search on multiple keywords
        javascript = { 'javascript', 'nodejs' },
        typescript = { 'typescript', 'javascript', 'nodejs' },
        typescriptreact = { 'typescript', 'javascript', 'react' },
        javascriptreact = { 'javascript', 'react' },
        -- you can also do a string, for example,
        -- bash = 'sh'
      },
    },
    bookmarks = {
      -- Available: 'brave', 'google_chrome', 'safari', 'firefox', 'firefox_dev'
      selected_browser = 'google_chrome',
    },
    tele_tabby = {
      use_highlighter = true,
    },
  }
}

-- local M = {}

-- function M.project_files()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require'telescope.builtin'.git_files, opts)
--   if not ok then require'telescope.builtin'.find_files(opts) end
-- end

-- function M.project_search()
--   require('telescope.builtin').find_files {
--     previewer = false,
--     shorten_path = true,
--     layout_strategy = "horizontal",
--     cwd = require('lspconfig.util').root_pattern(".git")(vim.fn.expand(":p")),
--   }
-- end

-- local M = {}

-- M.project_files = function()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require'telescope.builtin'.git_files, opts)
--   if not ok then require'telescope.builtin'.find_files(opts) end
-- end

-- return M

require('telescope').load_extension('node_modules')
-- :Telescope node_modules list
-- | key               | action               |
-- |-------------------|----------------------|
-- | `<CR>` (edit)     | `builtin.find_files` |
-- | `<C-x>` (split)   | `:chdir` to the dir  |
-- | `<C-v>` (vsplit)  | `:lchdir` to the dir |
-- | `<C-t>` (tabedit) | `:tchdir` to the dir |
require('telescope').load_extension('gh')
-- Telescope gh pull_request assignee=timtyrrell state=open
-- |---------|-------------------------------|
-- | `<cr>`  | checkout pull request         |
-- | `<c-t>` | open web                      |
-- | `<c-e>` | toggle to view detail or diff |
-- | `<c-r>` | merge request                 |
-- | `<c-a>` | approve pull request          |
-- Telescope gh run
-- |---------|----------------------------------------------|
-- | `<cr>`  | open workflow summary/run logs in new window |
-- | `<c-t>` | open web                                     |
-- | `<c-r>` | request run rerun                            |
-- Telescope gh gist
-- Telescope gh issues
require('telescope').load_extension('coc')
require("telescope").load_extension("git_worktree")
require('telescope').load_extension('fzf')
require('telescope').load_extension('bookmarks')
require("telescope").load_extension("emoji")
require('telescope').load_extension('ghn')
require('telescope').load_extension('env')

-- require('telescope').load_extension('neoclip')
-- require('neoclip').setup({
--   history = 1000,
--   enable_persistant_history = true,
--   preview = true,
--   keys = {
--     i = {
--       select = '<cr>',
--       paste = '<c-p>',
--       paste_behind = '<c-P>',
--     },
--     n = {
--       select = '<cr>',
--       paste = 'p',
--       paste_behind = 'P',
--     },
--   },
-- })

-- nvim-telescope/telescope-dap.nvim
-- require('telescope').load_extension('dap')
-- map('n', '<leader>ds', '<cmd>lua require'telescope'.extensions.dap.frames{}<CR>')
-- map('n', '<leader>dc', '<cmd>lua require'telescope'.extensions.dap.commands{}<CR>')
-- map('n', '<leader>db', '<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>')

require('octo').setup({
  submit_win = {
      approve_review = "<C-p>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
})

-- treesitter markdown parser with octo buffers
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"

require('numb').setup {
   show_numbers = true,
   show_cursorline = true,
   centered_peeking = true
}

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  -- ensure_installed = { "bash", "comment", "css", "graphql", "html", "javascript", "jsdoc", "json", "jsonc", "lua", "regex", "ruby", "tsx", "typescript" },
  highlight = {
    enable = true,
    disable = { },
  },
  indent = {
    enable = true
  },
  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     -- Automatically jump forward to textobj, similar to targets.vim
  --     lookahead = true,
  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ["oc"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --       ["of"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ob"] = "@block.outer",
  --       ["ib"] = "@block.inner",
  --       ["ol"] = "@loop.outer",
  --       ["il"] = "@loop.inner",
  --       ["os"] = "@statement.outer",
  --       ["is"] = "@statement.inner",
  --       ["oC"] = "@comment.outer",
  --       ["iC"] = "@comment.inner",
  --       ["om"] = "@call.outer",
  --       ["im"] = "@call.inner",
  --     },
  --   },
  -- swap = {
  --   enable = true,
  --   swap_next = {
  --     ["<leader>a"] = "@parameter.inner",
  --   },
  --   swap_previous = {
  --     ["<leader>A"] = "@parameter.inner",
  --   },
  -- },
  -- move = {
  --   enable = true,
  --   set_jumps = true, -- whether to set jumps in the jumplist
  --   goto_next_start = {
  --     ["]m"] = "@function.outer",
  --     ["]]"] = "@class.outer",
  --   },
  --   goto_next_end = {
  --     ["]M"] = "@function.outer",
  --     ["]["] = "@class.outer",
  --   },
  --   goto_previous_start = {
  --     ["[m"] = "@function.outer",
  --     ["[["] = "@class.outer",
  --   },
  --   goto_previous_end = {
  --     ["[M"] = "@function.outer",
  --     ["[]"] = "@class.outer",
  --   },
  -- },
-- },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  query_linter = {
    enable = false,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  autotag = {
    enable = true,
  },
}

require('hlslens').setup({
  nearest_only = true
})

EOF

augroup randomstuff
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
  " Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  " if highlighting on big files is bad, can do similiar:
  " autocmd FileType typescript syntax sync ccomment minlines=1500

  " set graphql filetype based on dir
  " autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
  " autocmd BufRead,BufNewFile */graphql/queries/*.js set syntax=graphql
  autocmd BufNewFile,BufRead .eslintrc,.prettierrc,.lintstagedrc set filetype=jsonc
  autocmd BufNewFile,BufRead *.build,.env* set filetype=sh
  autocmd BufNewFile,BufRead *.template set filetype=nginx
  " per reddit, Vim doesn't have an autocommand for graphql files. You will have to manually add this line to your config - not sure if needed
  autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql
augroup END

augroup LastCursorPos
  autocmd!
  autocmd BufReadPost * if @% !~# "\.git[\/\\]COMMIT_EDITMSG$" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " autocmd BufReadPost *
  "       \ if line("'\"") > 0 && line("'\"") <= line("$") |
  "       \   exe "normal! g`\"" |
  "       \ endif
augroup end

" how to automatically rename things based on filetype
" autocmd BufWritePre *.js exec '%s/class=/className=/eg'
" styles.something-blah -> styles[something-blah]
" :%s/styles[\S\+\]/
" /styles[\[a-zA-Z0-9].\+?(?=dir)/
" autocmd BufWritePre *.js exec '%s/class=/className=/eg'

" https://www.reddit.com/r/vim/comments/kmup3z/is_it_possibAle_to_make_hitting_one_tab_goes_to/ghhbaw9/?context=3
" inoremap <expr> <tab> getline('.') =~ '^\s*$' ? '<esc>cc' : '<tab>'

" https://github.com/fannheyward/coc-markdownlint/issues/203
" find a way to make :checkhealth not be checked by coc-markdownlint
" also look here :e $VIMRUNTIME/scripts.vim
" health#coc#check is the 2nd line
" https://github.com/neovim/neovim/commit/2bcae2024230eb4dd1013779ec1b69dc104c4021#
" au BufNewFile,BufReadPost *.ts
" 	\ if getline(1) =~ '<?xml' |
" 	\   setf xml |
" 	\ else |
" 	\   setf typescript |
" 	\ endif
"
" function! OnCheckHealth() abort
" 	\ if getline(1) =~ '<?xml' |
" 	\   setf xml |
" 	\ else |
" 	\   setf typescript |
" 	\ endif
" endfunction

" autocmd CheckHealth * call OnCheckHealth()

" quickfix
nmap <Leader>qq <Plug>window:quickfix:loop

" Run PlugUpgrade and PlugUpdate every day automatically when entering Vim.
function! OnVimEnter() abort
  if exists('g:plug_home')
    let l:filename = printf('%s/.vim_plug_update', g:plug_home)
    if filereadable(l:filename) == 0
      call writefile([], l:filename)
    endif

    " let l:this_day = strftime('%Y_%V') " weekly
    let l:this_day = strftime('%Y_%m_%d')
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_day) < 0
      " run update then run Diff when fully completed
      call execute('PlugUpgrade | PlugUpdate --sync | PlugDiff')
      " call execute('source $MYVIMRC')
      call writefile([l:this_day], l:filename, 'a')
    endif
  endif
endfunction

augroup vimenterauto
  autocmd!
  autocmd VimEnter * call OnVimEnter()
augroup END

" TODO use this to fix duplicate git org and repo name link
" Press gx to open the GitHub URL for a plugin or a commit with the default browser.
" function! s:plug_gx()
"   let line = getline('.')
"   let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
"   let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
"                       \ : getline(search('^- .*:$', 'bn'))[2:-2]
"   let uri  = get(get(g:plugs, name, {}), 'uri', '')
"   if uri !~ 'github.com'
"     return
"   endif
"   let repo = matchstr(uri, '[^:/]*/'.name)
"   let url  = empty(sha) ? 'https://github.com/'.repo
"                       \ : printf('https://github.com/%s/commit/%s', repo, sha)
"   call netrw#BrowseX(url, 0)
" endfunction

function! PlugGx()
  let l:line = getline('.')
  let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7,9}\ze ')

  if (&filetype ==# 'vim-plug')
    " inside vim plug splits such as :PlugStatus
    let l:name = empty(l:sha)
                  \ ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
                  \ : getline(search('^- .*:$', 'bn'))[2:-2]
  else
    " in .vimrc.bundles
    try
      let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
    catch
      let l:name = "browsersearch"
    endtry
  endif

  if (l:name ==# 'browsersearch')
    echo "NOPE"
  else
    let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
    if l:uri !~? 'github.com'
      return
    endif
    let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
    let l:url  = empty(l:sha)
                \ ? 'https://github.com/'.l:repo
                \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
    call netrw#BrowseX(l:url, 0)
  endif

endfunction

augroup PlugGx
  autocmd!
  autocmd BufRead,BufNewFile init.vim nnoremap <buffer> <silent> gx :call PlugGx()<cr>
  autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
augroup end

" JavaScript package.json
function! PackageJsonGx() abort
  let l:line = getline('.')
  let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')
  if len(l:package) > 0
    let l:package_name = l:package[1]
    let l:url = 'https://www.npmjs.com/package/' . l:package_name
    call netrw#BrowseX(l:url, 0)
  endif
endfunction

augroup PackageJsonGx
  autocmd!
  autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
augroup END

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
  " fzf plug help browser
  function! s:plug_help_sink(line)
    let dir = g:plugs[a:line].dir
   for pat in ['doc/*.txt', 'README.md']
     let match = get(split(globpath(dir, pat), "\n"), 0, '')
     if len(match)
       execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({ 'source': sort(keys(g:plugs)), 'sink': function('s:plug_help_sink')}))
  " PlugDiff commit preview browsing
  let g:plug_pwindow='vertical botright split'
  function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-d>" : "\<c-u>"
    wincmd p
  endif
endfunction

function! s:setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
endfunction

augroup PlugDiffExtra
  autocmd!
  autocmd FileType vim-plug call s:setup_extra_keys()
augroup END

" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! MyHighlights() abort
  if g:colors_name ==# 'tokyonight'
    hi default link CocHighlightText TabLineSel
    hi IncSearch guifg=#292e42 guibg=#bb9af7
    hi CocUnderline gui=undercurl term=undercurl
    hi default link CocErrorHighlight LspDiagnosticsUnderlineError
    hi default link CocWarningHighlight LspDiagnosticsUnderlineWarning
    hi default link CocInfoHighlight LspDiagnosticsUnderlineInformation
    hi default link CocHintHighlight LspDiagnosticsUnderlineHint
    hi default link CocErrorVirtualText LspDiagnosticsVirtualTextError
    hi default link CocWarningVirtualText LspDiagnosticsVirtualTextWarning
    hi default link CocInfoVirtualText LspDiagnosticsVirtualTextInformation
    hi default link CocHintVirtualText LspDiagnosticsVirtualTextHint
    hi default link CocCodeLens LspCodeLens
    hi NormalFloat guifg=#c0caf5 guibg=#292e42
    " chentau/marks.nvim
    hi MarkVirtTextHL cterm=bold ctermfg=15 ctermbg=9 gui=bold guifg=#ffffff guibg=#f00077
  end
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" https://github.com/trapd00r/vim-syntax-todo/blob/master/syntax/todo.vim
augroup todo
    autocmd!
    autocmd Syntax * call matchadd(
                \ 'Search',
                \ '\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK|LEARNINGS|TECH|IMPACT)>'
                \ )
augroup END

command! DiffHistory call s:view_git_history()

function! s:view_git_history() abort
  Git difftool --name-only ! !^@
  call s:diff_current_quickfix_entry()
  " Bind <CR> for current quickfix window to properly set up diff split layout after selecting an item
  " There's probably a better way to map this without changing the window
  copen
  nnoremap <buffer> <CR> <CR><BAR>:call <sid>diff_current_quickfix_entry()<CR>
  wincmd p
endfunction

function s:diff_current_quickfix_entry() abort
  " Cleanup windows
  for window in getwininfo()
    if window.winnr !=? winnr() && bufname(window.bufnr) =~? '^fugitive:'
      exe 'bdelete' window.bufnr
    endif
  endfor
  cc
  call s:add_mappings()
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    echom string(reverse(range(len(diff))))
    for i in reverse(range(len(diff)))
      exe (i ? 'leftabove' : 'rightbelow') 'vert diffsplit' fnameescape(diff[i].filename)
      call s:add_mappings()
    endfor
  endif
endfunction

function! s:add_mappings() abort
  nnoremap <buffer>]q :cnext <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  nnoremap <buffer>[q :cprevious <BAR> :call <sid>diff_current_quickfix_entry()<CR>
  " Reset quickfix height. Sometimes it messes up after selecting another item
  11copen
  wincmd p
endfunction

" https://github.com/tpope/vim-fugitive/issues/132#issuecomment-570844756
function DiffCurrentQuickfixEntry() abort
  cc
  let qf = getqflist({'context': 0, 'idx': 0})
  if get(qf, 'idx') && type(get(qf, 'context')) == type({}) && type(get(qf.context, 'items')) == type([])
    let diff = get(qf.context.items[qf.idx - 1], 'diff', [])
    for i in reverse(range(len(diff)))
      exe (i ? 'rightbelow' : 'leftabove') 'vert diffsplit' fnameescape(diff[i].filename)
      wincmd p
    endfor
  endif
endfunction

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
                \ | diffthis | wincmd p | diffthis

let base16colorspace=256
" might as well play it safe, kids
if has("termguicolors")
  set termguicolors
endif

let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_italic_variables = 0
let g:tokyonight_sidebars = [ "qf", "NvimTree", "terminal", "dapui_scopes", "dapui_breakpoints", "dapui_stacks", "dapui_watches", "dap-repl", "DiffviewFiles", "dbui" ]
colorscheme tokyonight

" customize
let g:fzf_colors = {
      \ 'fg': ['fg', 'Normal'],
      \ 'bg': ['bg', 'Normal'],
      \ 'hl': ['fg', 'Green'],
      \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+': ['fg', 'Green'],
      \ 'info': ['fg', 'Yellow'],
      \ 'prompt': ['fg', 'Red'],
      \ 'pointer': ['fg', 'Blue'],
      \ 'marker': ['fg', 'Blue'],
      \ 'spinner': ['fg', 'Yellow'],
      \ 'header': ['fg', 'Blue']
      \ }

" https://github.com/junegunn/fzf.vim/issues/392
let g:projectionist_ignore_term = 1

let g:projectionist_heuristics = {}
let g:projectionist_heuristics['package.json'] = {
  \   '*.js': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.js',
  \       '{dirname}/__tests__/{basename}.test.js',
  \       '{dirname}/__test__/{basename}_tests.js',
  \       '{dirname}/{basename}.module.scss',
  \       '{dirname}/{basename}.styl',
  \     ],
  \     'type': 'source',
  \   },
  \   '*.test.js': {
  \     'alternate': [
  \       '{dirname}/{basename}.js',
  \       '{dirname}/../{basename}.js',
  \     ],
  \     'type': 'test',
  \   },
  \   '*.ts': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.ts',
  \       '{dirname}/{basename}.test.tsx',
  \       '{dirname}/__test__/{basename}_tests.ts',
  \       '{dirname}/__tests__/{basename}.test.ts',
  \       '{dirname}/{basename}.styl',
  \     ],
  \     'type': 'source',
  \   },
  \   '*.test.ts': {
  \     'alternate': [
  \       '{dirname}/{basename}.ts',
  \       '{dirname}/{basename}.tsx',
  \       '{dirname}/../{basename}.ts',
  \       '{dirname}/../{basename}.tsx',
  \     ],
  \     'type': 'test',
  \   },
  \   '*.tsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.ts',
  \       '{dirname}/{basename}.test.tsx',
  \       '{dirname}/__test__/{basename}_tests.tsx',
  \       '{dirname}/__tests__/{basename}.test.tsx',
  \     ],
  \     'type': 'source',
  \   },
  \   '*.test.tsx': {
  \     'alternate': [
  \       '{dirname}/{basename}.ts',
  \       '{dirname}/{basename}.tsx',
  \       '{dirname}/../{basename}.ts',
  \       '{dirname}/../{basename}.tsx',
  \     ],
  \     'type': 'test',
  \   },
  \   '*.styl': {
  \     'alternate': [
  \       '{dirname}/{basename}.js',
  \       '{dirname}/{basename}.ts',
  \       '{dirname}/{basename}.tsx',
  \     ],
  \     'type': 'stylus',
  \   },
  \   'package.json' : { 'alternate': 'package-lock.json' },
  \   'package-lock.json' : { 'alternate': 'package.json' },
 \ }
" let g:projectionist_heuristics = {
"     \'src/*.js': {
"     \    'type': 'component',
"     \    'alternate': [
"     \        'src/{}.scss',
"     \        'src/{dirname}/{basename}.test.js'
"     \    ]
"     \},
"     \'src/*.module.scss': {
"     \    'type': 'styles'
"     \}
" \ }
" nnoremap <Leader>ec :Ecomponent<Space>
" nnoremap <Leader>es :Estylesheet<Space>
" nnoremap <leader>et :Etest<Space>
" nnoremap <Leader>a  :A<CR>
" autocmd BufNewFile,BufRead * call <SID>DetectFrontEndFramework()

" autocmd BufNewFile,BufRead * call <SID>DetectFrontEndFramework()
" function! s:DetectFrontEndFramework()
" let package_json = findfile('package.json', '.;')
" if len(package_json)
"     let dependencies = readfile(package_json)
"                 \ ->join()
"                 \ ->json_decode()
"                 \ ->get('dependencies', {})
"                 \ ->keys()
"     if dependencies->count('next')
"         set path=.,,components/**,lib/**,pages/**,public/**,ssl/**,styles/**
"     endif
"     if dependencies->count('nuxt')
"         set path=.,,assets/**,components/**,layouts/**,middleware/**,pages/**,plugins/**,static/**,store/**,test/**,content/**
"     endif
" endif
" endfunction

" lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'],
    \             [ 'paste', 'gitbranch', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'LightlineBranchformat',
    \   'filename': 'LightlineFilenameDisplay',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'lineinfo': 'LightlineLineInfo',
    \   'percent': 'LightlinePercent',
    \ },
    \ 'separator': { 'left': "\ue0b4", 'right': "\ue0b6" },
    \ 'subseparator': { 'left': "\ue0b5", 'right': "\ue0b7" },
    \ 'tab_component_function': {
    \   'tabnum': 'LightlineWebDevIcons',
    \   'filename': 'LightlineTabname',
    \ },
    \ }
let g:lightline#coc#indicator_warnings = ''
let g:lightline#coc#indicator_errors = ''
let g:lightline#coc#indicator_info = ''

function! LightlinePercent() abort
    if winwidth(0) < 60
        return ''
    endif
    let l:percent = line('.') * 100 / line('$') . '%'
    return printf('%-4s', l:percent)
endfunction

function! LightlineLineInfo()
  return &ft =~? 'NvimTree' ? '' : printf(' %d/%d:%-2d', line('.'), line('$'), col('.'))
endfunction

function! LightlineFilenameDisplay()
  if &ft == 'NvimTree'
    return ''
  else
    return winwidth(0) > 90 ? WebDevIconsGetFileTypeSymbol(LightlineFilename()) . " ". LightlineFilename() : pathshorten(fnamemodify(expand("%"), ":."))
  endif
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! LightlineTabname(n) abort
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let l:fname = expand('#' . l:bufnr . ':t')
  return l:fname == '__Mundo__' ? 'Mundo' :
    \ l:fname == '__Mundo_Preview__' ? 'Mundo Preview' :
    \ l:fname =~ 'FZF' ? '' :
    \ l:fname =~ 'NvimTree' ? 'NvimTree' :
    \ l:fname =~ '\[Plugins\]' ? 'Plugins' :
    \ ('' != l:fname ? l:fname : '')
endfunction

function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol(LightlineFilename()) : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineBranchformat()
  try
    if winwidth(0) > 100 && expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'NvimTree' && exists('*FugitiveHead')
      let mark = ' '
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    else
      return ''
    endif
  catch
    return ''
  endtry
endfunction

let g:lightline.colorscheme = 'tokyonight'

" register compoments:
call lightline#coc#register()

nnoremap <silent><leader>vr <cmd>call execute('source $MYVIMRC')<cr><cmd>lua require('notify')('vim config reloaded!')<cr>

lua << EOF
-- mfussenegger/nvim-dap
local dap = require('dap')
require('dap-python').setup('~/.local/share/virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'

-- dap.set_log_level('TRACE')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
    args = {os.getenv('HOME') .. '/code/vscode-node-debug2/out/src/nodeDebug.js'},
}

-- note: chrome has to be started with a remote debugging port: --remote-debugging-port=9222
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/code/vscode-chrome-debug/out/src/chromeDebug.js"}
}

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})

-- theHamsta/nvim-dap-virtual-text
require("nvim-dap-virtual-text").setup()
vim.g.dap_virtual_text = true

-- dap-ui
require('dapui').setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes", size = 0.40, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.05 },
      { id = "stacks", size = 0.40 },
      -- { id = "watches", size = 00.25 },
    },
    size = 50,
    position = "right", -- Can be "left" or "right"
  },
  tray = {
    elements = { "repl",
      { id = "watches", size = 0.25 },
    },
    size = 10,
    position = "bottom", -- Can be "bottom" or "top"
  },
  floating = {
    border = "rounded",
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- use nvim-dap events to open and close the windows automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- David-Kunz/jester
vim.api.nvim_set_keymap('n', '<leader>td', ':lua require"jester".debug({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require"jester".run({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require"jester".run_file({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>d_', ':lua require"jester".debug_last({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>df', ':lua require"jester".debug_file({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
EOF

" vim-test
let test#python#pytest#options = '-p no:warnings'
let test#strategy = 'vimux'
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tp :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nmap <silent> <leader>ts :TestSuite<CR>

" automatically run tests when a test file or its alternate application file is saved
" augroup test
"   autocmd!
"   autocmd BufWrite * if test#exists() |
"     \   TestFile |
"     \ endif
" augroup END

augroup move_these_to_ftplugin
  " :help ftplugin
  autocmd!
  " coc-jest
  autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <leader>tf :call CocActionAsync('runCommand', 'jest.fileTest', ['%'])<CR>
  autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <leader>tt :call CocActionAsync('runCommand', 'jest.singleTest')<CR>
  autocmd FileType typescriptreact,javascript,javascriptreact,typescript nnoremap <leader>ts :call CocActionAsync('runCommand', 'jest.projectTest')<CR>
  " autocmd FileType javascript,typescript, nnoremap <buffer> <C-]> :TernDef<CR>
  " autocmd BufWritePost *.jsx,*.js CocCommand eslint.executeAutofix
augroup END

" dap-ui
nnoremap <leader>dq  :lua require'dapui'.toggle()<CR>
nnoremap <leader>due :lua require'dapui'.eval()<cr>
vnoremap <leader>due :lua require'dapui'.eval()<cr>
nnoremap <leader>duf :lua require'dapui'.float_element()<cr>
nnoremap <leader>dus :lua require'dapui'.float_element("scopes")<cr>
nnoremap <leader>dur :lua require'dapui'.float_element("repl")<cr>

" nvim-dap-python
nnoremap <leader>dpm :lua require('dap-python').test_method()<CR>
nnoremap <leader>dpc :lua require('dap-python').test_class()<CR>
vnoremap <leader>dps <ESC>:lua require('dap-python').debug_selection()<CR>

" dap node
nnoremap <leader>da  :lua require'debugHelper'.attachToNode()<CR>
nnoremap <leader>dA  :lua require'debugHelper'.attachToRemote()<CR>
nnoremap <leader>dc  :lua require'debugHelper'.attachToChrome()<CR>

" nvim-dap
nnoremap <leader>dt  :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dn  :lua require'dap'.continue()<CR>
nnoremap <leader>d_  :lua require'dap'.disconnect();require"dap".close();require"dap".run_last()<CR>

nnoremap <leader>dbc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dbx :lua require'dap'.clear_breakpoints()<CR>
nnoremap <leader>dbm :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <leader>dso :lua require'dap'.step_out()<CR>
nnoremap <leader>dsi :lua require'dap'.step_into()<CR>
nnoremap <leader>dsv :lua require'dap'.step_over()<CR>
nnoremap <leader>dk  :lua require'dap'.up()<CR>
nnoremap <leader>dj  :lua require'dap'.down()<CR>
nnoremap <leader>drv :lua require'dap'.repl.open({}, 'vsplit')<CR>
nnoremap <leader>dro :lua require'dap'.repl.open()<CR>
nnoremap <leader>drl :lua require'dap'.repl.run_last()<CR>
nnoremap <leader>di  :lua require'dap.ui.widgets'.hover()<CR>
vnoremap <leader>di  :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>dI  :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>d?  :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <leader>de  :lua require'dap'.set_exception_breakpoints({"all"})<CR>

let g:vim_jsx_pretty_colorful_config = 1

let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
let g:git_messenger_extra_blame_args ='-w' " Ignore whitespace
let g:git_messenger_floating_win_opts = { 'border': 'single' }

" DEFAULT COC.NVIM START

set updatetime=100

" Give more space for displaying messages
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set shortmess+=S
set shortmess+=F
" shortmess=filnxtToOFsIc
" shortmess=aoOcSF

" wilder workaround based on https://github.com/neovim/neovim/issues/14304
function! SetShortmessF(on) abort
  if a:on
    set shortmess+=F
  else
    set shortmess-=F
  endif
  return ''
endfunction

nnoremap <expr> : SetShortmessF(1) . ':'

augroup WilderShortmessFix
  autocmd!
  autocmd CmdlineLeave * call SetShortmessF(0)
augroup END
" wilder workaround based on https://github.com/neovim/neovim/issues/14304

" leave space for git, diagnostics and marks
set signcolumn=auto:5

" use C-j, C-k to move in completion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" also allow <tab>/<s-tab> to move in completion list.
" <tab> /<s-tab> snippet mappings take precedence
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)

" navigate chunks of current buffer
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
" :CocCommand git.chunkStage
" :CocCommand git.chunkUnstage

" navigate conflicts of current buffer
nmap [k <Plug>(coc-git-prevconflict)
nmap ]k <Plug>(coc-git-nextconflict)

nmap <silent> <space>gs <Plug>(coc-git-chunkinfo)
omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)
nmap <silent> <space>uc :CocCommand git.chunkUndo<cr>
vmap <silent> <space>uc :CocCommand git.chunkUndo<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <space>gi <Plug>(coc-implementation)
nmap <silent> <space>gu <Plug>(coc-references-used)
nmap <silent> <space>go <Plug>(coc-refactor)

nmap <space>cf <Plug>(coc-fix-current)
nmap <space>cn <Plug>(coc-rename)
nmap <space>ce <Plug>(coc-codelens-action)
nmap <space>ca <Plug>(coc-codeaction)
nmap <space>cc <Plug>(coc-codeaction-cursor)
nmap <space>cl <Plug>(coc-codeaction-line)
" apply codeAction to the selected region. Ex: `<space>aap` for current paragraph
vmap <space>cs <Plug>(coc-codeaction-selected)
nmap <space>cs <Plug>(coc-codeaction-selected)

nmap <space>co  <cmd>CocOutline<cr>
nmap <space>cki <cmd>CHI<cr>
nmap <space>cko <cmd>CHO<cr>
nmap <space>cg  :<C-u>CocSearch -w <C-R><C-W><cr>
nmap <space>cr  :<C-u>CocRestart<CR>

" autocmd VimEnter,Tabnew *
"   \ if empty(&buftype) | call CocActionAsync('showOutline', 1) | endif

autocmd BufEnter * call CheckOutline()
function! CheckOutline() abort
  if &filetype ==# 'coctree' && winnr('$') == 1
    if tabpagenr('$') != 1
      close
    else
      bdelete
    endif
  endif
endfunction

" show outline for each tab automatically
" autocmd VimEnter,Tabnew *.ts,*.js,*.tsx,*.jsx
" 		\ if empty(&buftype) | call CocActionAsync('showOutline', 1) | endif

" nmap <space> <Plug>(coc-format)
" nmap <space> :<C-u>CocCommand eslint.executeAutofix<cr>
" nmap <space> :<C-u>CocCommand tsserver.organizeImports<cr>
" nmap <space> :<C-u>CocCommand tsserver.findAllFileReferences<cr>
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
command! -nargs=0 CHI :call CocActionAsync('runCommand', 'document.showIncomingCalls')
command! -nargs=0 CHO :call CocActionAsync('runCommand', 'document.showOutgoingCalls')

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" https://github.com/neoclide/coc.nvim/issues/1775
let g:coc_disable_transparent_cursor = 1

" max items to show in popup list
set pumheight=20

" tell coc how to navigate to next snippet placeholder
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Do default action for next item.
nnoremap <silent><nowait> <space>an :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>ap :<C-u>CocPrev<CR>

command -nargs=0 Swagger :CocCommand swagger.render

" switch diagnostic to float for full message displaty
" nmap <leader>cf :call coc#config('diagnostic.messageTarget', 'echo')<CR>
" nmap <leader>cf :call coc#config('diagnostic.virtualText', v:true)<CR>
" " make it toggle
" nmap <leader>ct :call coc#config('diagnostic.messageTarget', 'float')<CR>
" nmap <leader>ct :call coc#config('diagnostic.virtualText', v:false)<CR>

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'
let g:coc_fzf_preview_fullscreen=0
let g:coc_fzf_preview_toggle_key='\'

nnoremap <silent><nowait> <space>za :<C-u>CocFzfList actions<CR>
nnoremap <silent><nowait> <space>zd :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> <space>zD :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <space>zc :<C-u>CocFzfList commands<CR>
nnoremap <silent><nowait> <space>ze :<C-u>CocFzfList extensions<CR>
nnoremap <silent><nowait> <space>zl :<C-u>CocFzfList location<CR>
nnoremap <silent><nowait> <space>zL :<C-u>CocFzfList<CR>
nnoremap <silent><nowait> <space>zo :<C-u>CocFzfList outline<CR>
nnoremap <silent><nowait> <space>zs :<C-u>CocFzfList symbols<CR>
nnoremap <silent><nowait> <space>zS :<C-u>CocFzfList symbols <C-R><C-W><CR>
nnoremap <silent><nowait> <space>zn :<C-u>CocFzfList snippets<CR>
nnoremap <silent><nowait> <space>zv :<C-u>CocFzfList services<CR>
nnoremap <silent><nowait> <space>zr :<C-u>CocFzfListResume<CR>
nnoremap <silent><nowait> <space>zy :<C-u>CocFzfList yank<CR>

nnoremap <silent><nowait> <Leader>zf :call <SID>coc_qf_diagnostic()<CR>
function! s:coc_qf_diagnostic() abort
  if !get(g:, 'coc_service_initialized', 0)
    return
  endif
  let diagnostic_list = CocAction('diagnosticList')
  let items = []
  let loc_ranges = []
  for d in diagnostic_list
    let text = printf('[%s%s] %s', (empty(d.source) ? 'coc.nvim' : d.source),
          \ (d.code ? ' ' . d.code : ''), split(d.message, '\n')[0])
    let item = {'filename': d.file, 'lnum': d.lnum, 'col': d.col, 'text': text, 'type':
          \ d.severity[0]}
    call add(loc_ranges, d.location.range)
    call add(items, item)
  endfor
  call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  botright copen
endfunction

function! s:coc_qf_jump2loc(locs) abort
  let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
  call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  let winid = getloclist(0, {'winid': 0}).winid
  if winid == 0
    rightbelow lwindow
  else
    call win_gotoid(winid)
  endif
endfunction


augroup CocGroup
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix
  " automatically open quickfix for coc-references, etc. conflicts with CocFzfList
  " autocmd User CocLocationsChange ++nested call s:coc_qf_jump2loc(g:coc_jump_locations)

  " disable autocomplete for vimwiki, ctrl+space to trigger in insert mode
  " autocmd FileType vimwiki let b:coc_suggest_disable = 1
  " have snippets complete, only? mess with this: https://github.com/neoclide/coc.nvim/blob/804a007033bd9506edb9c62b4e7d2b36203ba479/doc/coc.txt#L908

  " close preview when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

  " make sure to kill coc pid when closing nvim (not sure if needed)
  autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
      \	| call system('kill -9 '.g:coc_process_pid) | endif
  " run this also?
  " :CocCommand workspace.clearWatchman

  " autocmd VimLeavePre * :call coc#rpc#kill()
  " autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif

  " autocmd FileType python let b:coc_root_patterns = ['app.py']
augroup end

" https://github.com/yarnpkg/berry/pull/2598 or use zip file
" yarn 2 pnp goto definition support
function! OpenZippedFile(f)
  " get number of new (empty) buffer
  let l:b = bufnr('%')
  " construct full path
  let l:f = substitute(a:f, '.zip/', '.zip::', '')
  let l:f = substitute(l:f, '/zip:', 'zipfile:', '')

  " swap back to original buffer
  b #
  " delete new one
  exe 'bd! ' . l:b
  " open buffer with correct path
  sil exe 'e ' . l:f
  " read in zip data
  call zip#Read(l:f, 1)
endfunction

augroup yarngroup
  autocmd!
  autocmd BufReadCmd /zip:*.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))
augroup END

" fzf.vim
" nnoremap <C-w>- :new<cr>
" nnoremap <C-w><bar> :vnew<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" open fzf in a floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }

" https://jdhao.github.io/2020/02/16/ripgrep_cheat_sheet/
" https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#common-options

" 'wild	exact-match (quoted)	Items that include wild
" ^music	prefix-exact-match	Items that start with music
" .mp3$	suffix-exact-match	Items that end with .mp3
" !fire	inverse-exact-match	Items that do not include fire
" !^music	inverse-prefix-exact-match	Items that do not start with music
" !.mp3$	inverse-suffix-exact-match	Items that do not end with .mp3

" nnoremap <leader>ff <cmd>lua require('telescope.builtin').git_files()<cr>
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <Leader>ff <cmd>Files<CR>

" to set search folder
nnoremap <silent> <Leader>fF :Files<space>
" nmap <c-a-p> :cd ~/projects<cr>:Files<cr> " airblade/vim-rooter sets the current path and this switches to a new project

nnoremap <silent> <Leader>fT <cmd>lua require('telescope').extensions.tele_tabby.list()<CR>

nnoremap <silent> <Leader>fp :call fzf#vim#files('', { 'source': g:FzfFilesSource(), 'options': '--tiebreak=index'})<CR>

nnoremap <silent> <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <silent> <Leader>fb :Buffers<CR>
" let g:fzf_buffers_jump = 1

" Lines in the current buffer
nnoremap <silent><leader>fB <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
" nnoremap <silent> <Leader>fB :BLines<CR>

" live grep exact word match
" nnoremap <silent> <leader>fl <cmd>lua require('telescope.builtin').live_grep()<cr>
" live grep fuzzy match
" nnoremap <silent> <leader>fL <cmd>lua require('telescope.builtin')
"       \ .grep_string({
"       \   only_sort_text = true,
"       \   search = ''
"       \ })<cr>
nnoremap <silent> <Leader>fl <cmd>RgLines<CR>

" Lines in loaded buffers
nnoremap <silent> <leader>fz <cmd>lua require('telescope.builtin')
      \.live_grep({
      \   prompt_title = 'find string in open buffers...',
      \   grep_open_files = true
      \ })<cr>
nnoremap <silent> <Leader>fL :Lines<CR>
nnoremap <silent> <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>
" nnoremap <silent> <Leader>fh :HistoryCmds<CR>

nnoremap <silent> <leader>fH <cmd>lua require('telescope.builtin').oldfiles()<cr>
" nnoremap <silent> <Leader>fH :History<CR>
nnoremap <silent> <leader>fS <cmd>lua require('telescope.builtin').search_history()<cr>
" nnoremap <silent> <Leader>fS :HistorySearch<CR>
nnoremap <silent> <Leader>fg <cmd>lua require('telescope.builtin').git_status()<cr>
" nnoremap <silent> <Leader>fg :GFiles?<CR>
nnoremap <silent> <leader>fc <cmd>lua require('telescope.builtin').git_commits()<cr>
" nnoremap <silent> <Leader>fc :Commits<CR>
nnoremap <silent> <leader>fC <cmd>lua require('telescope.builtin').git_bcommits()<cr>
" nnoremap <silent> <Leader>fC :BCommits<CR>
nnoremap <silent> <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>
" nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <leader>fM <cmd>lua require('telescope.builtin').keymaps()<cr>
" nnoremap <silent> <Leader>fM :Maps<CR>

nnoremap <silent> <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>

nnoremap <silent> <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>

nnoremap <silent> <leader>bd :BD<CR>

" start file search in current dir
" nnoremap <silent> <leader>fd <cmd>lua require('telescope.builtin')
"       \ .find_files({
"       \   cwd = require'telescope.utils'.buffer_dir()
"       \ })<cr>
nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>

" Rg current word under cursor
" nnoremap <silent> <leader>rw <cmd>lua require('telescope.builtin')
"       \ .grep_string({
"       \   only_sort_text = true,
"       \   word_match = '-w',
"       \ })<cr>
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>

" Rg with any params (filetypes)
nnoremap <silent> <leader>rf :RG **/*.

" Rg with dir autocomplete
nnoremap <silent> <leader>rd :RGdir<Space>

" Only search NON-test files defined in .ripgreprc
nnoremap <silent> <leader>rt :RG --type-not test -g '!{cypress,test,*mocks*,__test__}'<CR>

" Only search test files defined in .ripgreprc
nnoremap <silent> <leader>rT :RG --type test<CR>

" Search by file path/names AND file contents
nnoremap <silent> <Leader>ra :Rg<CR>

" Search lines in _all_ buffers with smart-case (this only does the current buffer???)
" command! -bang -nargs=* BLines
"     \ call fzf#vim#grep(
"     \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
"     \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))

" do not search filename, just file contents of all file Lines in root dir with smartcase
command! -bang -nargs=* RgLines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..'] }), <bang>0)
  " \   'rg --column --line-number --no-heading --color=always --colors 'path:fg:190,220,255' --colors 'line:fg:128,128,128' --smart-case  -- '.shellescape(<q-args>), 1,
  " \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..', '--color', 'hl:123,hl+:222'] }), <bang>0)

" override default preview settings in zshrc to hide previews
" examples in the source: https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim#L48
command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
" command! -bang -nargs=* FilesPreview call fzf#vim#files(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

" Ag PATTERN DIR
command! -bang -nargs=+ -complete=dir AgDir call fzf#vim#ag_raw(<q-args>, <bang>0)

" whole word search
command! -bang -nargs=* AgWord call fzf#vim#ag(<q-args>, '--word-regexp', <bang>0)

" filter search by a passed in query (exact match)
function! RipgrepFzf(filepaths, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --with-filename -e ''%s'' ' . a:filepaths . ' || true'
  let initial_command = printf(command_fmt, '')
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Change to git project directory
nnoremap <silent> <Leader>fI :FZFCd ~/code<CR>
nnoremap <silent> <Leader>fi :FZFCd!<CR>
command! -bang -bar -nargs=? -complete=dir FZFCd
	\ call fzf#run(fzf#wrap(
	\ {'source': 'find '..( empty("<args>") ? ( <bang>0 ? "~" : "." ) : "<args>" ) ..
	\ ' -type d -maxdepth 1', 'sink': 'cd'}))

" redefine :Rg to all arg passing
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \ "rg --column --line-number --no-heading --color=always --smart-case " .
"   \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" filter by anything
" :RG **/*.ts
" :RG -tweb (INCLUDE 'web' type from .ripgreprc)
" :RG -Ttest (EXCLUDE 'test' type from .ripgreprc)
" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" autocomplete dirs
command! -nargs=* -bang -complete=dir RGdir call RipgrepFzf(<q-args>, <bang>0)

"FZF Buffer Delete
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--no-preview --multi --reverse --bind ctrl-a:select-all+accept'
  \ }))
command! -bang Args call fzf#run(fzf#wrap('args',
    \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and 'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" " Switch from any fzf mode to :Files on the fly and transfer the search query.
" " Inspiration: https://github.com/junegunn/fzf.vim/issues/289#issuecomment-447369414
" function! s:FzfFallback()
"   " If possible, extract the search query from the previous fzf mode.
"   " :Files queries are ignored here because they use a different, harder to
"   " match prompt format.
"   let line = getline('.')
"   let query = substitute(line, '\v^(Hist|Buf|GitFiles|Locate)\> ?', '', '')
"   echo query
"   let query = query != line ? query : ''
"   " let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
"   close
"   sleep 100m
"   call fzf#vim#files(GetProjectRoot(''), {'options': ['-q', query]})
" endfunction
" function! s:FzfFileType()
"   tnoremap <buffer> <silent> <c-f> <c-\><c-n>:call <sid>FzfFallback()<cr>
" endfunction
" autocmd FileType fzf call s:FzfFileType()
" Switch from any fzf mode to :Files on the fly and transfer the search query.
function! s:FzfFallback()
    if &filetype != 'FZF'
        return
    endif
    " Extract from first space to cursor position of previous fzf buffer prompt
    let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
    echo query
    close
    sleep 1m
    call fzf#vim#files('.', {'options': ['-q', query]})
endfunction
tnoremap <c-space> <c-\><c-n>c:call <sid>FzfFallback()<cr>

" FZF JUMPS/CHANGES
function GoTo(jumpline)
  let values = split(a:jumpline, ":")
  echo "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal! zvzz"
endfunction

function GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function! Jumps()
  " Get jumps with filename added
  let jumps = map(reverse(copy(getjumplist()[0])),
    \ { key, val -> extend(val, {'name': expand('#'.(val.bufnr)) }) })

  let jumptext = map(copy(jumps), { index, val ->
      \ (val.name).':'.(val.lnum).':'.(val.col+1).': '.GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': jumptext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction
command! Jumps call Jumps()

function! Changes()
  let changes  = reverse(copy(getchangelist()[0]))

  let offset = &lines / 2 - 3
  let changetext = map(copy(changes), { index, val ->
      \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
        \ 'source': changetext,
        \ 'column': 1,
        \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
        \ 'sink': function('GoTo')})))
endfunction
command! Changes call Changes()

nnoremap <silent> <leader>fj :Jumps<CR>
" mnemonic 'moDified'
nnoremap <silent> <leader>fD :Changes<CR>
" FZF JUMPS/CHANGES

" Fzf display mappings
nmap <tab><tab> <plug>(fzf-maps-n)
xmap <tab><tab> <plug>(fzf-maps-x)
omap <tab><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-p> <plug>(fzf-complete-path)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)
" switch finder so ignore settings are used
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" scope path to current dir
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
"     \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
"     \ fzf#wrap({'dir': expand('%:p:h')}))
function! s:remove_file_extension(path)
  return substitute(join(a:path), '\.[tj]sx\=$', "", "")
endfunction
function! AbsolutePathNoExtension()
  return fzf#vim#complete#path(
        \ "fd -t f",
        \ fzf#wrap({ 'reducer': function('s:remove_file_extension')})
        \ )
endfunction
inoremap <expr> <c-x><c-f> AbsolutePathNoExtension()

function! s:generate_relative_js(path)
  let target = getcwd() . '/' . (join(a:path))
  let base = expand('%:p:h')
  let prefix = ""
  while stridx(target, base) != 0
    let base = substitute(system('dirname ' . base), '\n\+$', '', '')
    let prefix = '../' . prefix
  endwhile
  if prefix == ''
    let prefix = './'
  endif
  let relative = prefix . substitute(target, base . '/', '', '')
  let withJsTrunc = substitute(relative, '\.[tj]sx\=$', "", "")
  return withJsTrunc
endfunction

function! JsFzfImport()
  return fzf#vim#complete#path(
        \ "fd",
        \ fzf#wrap({ 'reducer': function('s:generate_relative_js')})
        \ )
endfunction
" inoremap <expr> <c-x><c-j> JsFzfImport()
" sort a list of files by the proximity to a given file
function! g:FzfFilesSource()
  let l:base = fnamemodify(expand('%'), ':h:.:S')
  let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'
  if base == '.'
    return 'rg --files'
  else
    return printf('rg --files | %s %s', l:proximity_sort_path, expand('%'))
  endif
endfunction

" :e a new file and include a directory that doesn't exist, create it
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" Search and replace in file/line (selection or word)
" or use: Visual select > dgn > n(skip) or .(repeat)
vnoremap <leader>rs "9y:%s/<c-r>9//g<left><left>
" nnoremap <leader>rs viw"9y:%s/<c-r>9//g<left><left>
nnoremap <leader>rs :%s/\<<C-r>=expand("<cword>")<CR>\>/
vnoremap <leader>rl "9y:s/<c-r>9//g<left><left>
nnoremap <leader>rl viw"9y:s/<c-r>9//g<left><left>

nmap cg* *Ncgn
nnoremap g. /\V<C-r>"<CR>cgn<C-a><Esc>

" Find and Replace in *all* files
function! FindAndReplace( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute printf('args `rg --files-with-matches ''%s'' .`', a:1)
  execute printf('argdo %%substitute/%s/%s/g | update', a:1, a:2)
endfunction
command! -nargs=+ FindAndReplaceAll call FindAndReplace(<f-args>)

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" add motions for words_like_this, etc
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" change word movement?
" let someobject = response.user.posts[2].description.length
" ^   ^            ^        ^    ^     ^  ^           ^
" nnoremap w /\W\zs\w<CR>
" nnoremap W ?\W\zs\w<CR>

" get highlight info
" :call GetSyntax() to find highlight group
function! GetSyntaxID()
    return synID(line('.'), col('.'), 1)
endfunction

function! GetSyntaxParentID()
    return synIDtrans(GetSyntaxID())
endfunction

function! GetSyntax()
    echo synIDattr(GetSyntaxID(), 'name')
    exec "hi ".synIDattr(GetSyntaxParentID(), 'name')
endfunction

" Output the current syntax group
nnoremap <leader>bg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" vimwiki & friends
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vimwiki_hl_headers = 1 " highlight headers with different colors
let g:vimwiki_hl_cb_checked = 2 " highlight completed tasks and line
let g:vim_markdown_fenced_languages = ['viml=vim', 'bash=sh', 'javascript=js']
" let g:vimwiki_url_maxsave = 0 " display full url path

" fix `gx` command https://github.com/plasticboy/vim-markdown/issues/372#issuecomment-394237720
nnoremap <Plug> <Plug>Markdown_OpenUrlUnderCursor

" trying to make markdown snippets work
" let g:vimwiki_table_mappings=0
" autocmd FileType vimwiki UltiSnipsAddFiletypes vimwiki
let g:vimwiki_global_ext = 1 " don't hijack all .md files
let g:vimwiki_listsyms = ' ○◐●✓'

" NV-fzf floating window
function! FloatingFZF()
  let width = float2nr(&columns * 0.9)
  let height = float2nr(&lines * 0.6)
  let opts = { 'relative': 'editor',
             \ 'row': (&lines - height) / 2,
             \ 'col': (&columns - width) / 2,
             \ 'width': width,
             \ 'height': height,
             \}

  let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
endfunction
let g:nv_window_command = 'call FloatingFZF()'

" list of all files and sub-directory path'd files sorted by date modified
" function! g:init_funcs#fzf_nv()
function! SortWiki()
  let l:fzf_opts = {}
  let l:fzf_opts.sink = 'e'
  let l:fzf_opts.dir = '~/Documents/notes'
  let l:fzf_opts.source = 'ls -td $(fd .)'
  let l:fzf_opts.options = '--delimiter ":" --preview="bat ~/Documents/notes/{1}" --preview-window=right:80'
  call fzf#run(fzf#wrap(l:fzf_opts))
endfunction

let g:vimwiki_list = [{
  \ 'path': '~/Documents/notes/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'auto_toc': 1,
  \ }]
" gln to toggle forward
" glp to toggle back
let g:coc_filetype_map = { 'vimwiki': 'markdown' } " register with coc-markdownlint

let g:nv_search_paths = ['~/Documents/notes']
let g:nv_create_note_key = 'ctrl-x'

" default 'alok/notational-fzf-vim' search
nmap <Leader>wv :NV!<CR>
" better line search with ripgrep
nmap <Leader>wl :SearchNotes<CR>
" filename search
nmap <Leader>wf  :Files ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/<CR>
" need to call this way when using vim-plug ondemand
nmap <Leader>wdn :VimwikiMakeDiaryNote<CR>
" nmap <Leader>wdn <Plug>VimwikiMakeDiaryNote
nmap <Leader>wdy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>wdt <Plug>VimwikiMakeTomorrowDiaryNote

command! -bang -nargs=* SearchNotes
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': '~/Documents/notes'}), <bang>0)

command! -bang -nargs=* EditNote call fzf#vim#files('~/Documents/notes', <bang>0)

command! -bang -nargs=0 NewNote
  \ call vimwiki#base#edit_file(":e", strftime('~/Documents/notes/%F-%T.md'), "")

command! Diary VimwikiDiaryIndex

function InsertDate()
    :.!echo "= $(date) ="
    normal 2o
    :start
endfunction

augroup vimwikigroup
  autocmd!
  " do not set syntax to 'vimwiki'
  autocmd BufEnter *.md setl syntax=markdown
  " make syntax highlighting work
  autocmd BufEnter *.md :syntax enable
  " automatically update links on read diary
  autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks

  autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType markdown nmap <buffer> <silent> gf <Plug>VimwikiFollowLink<CR>

  " way to check if text is in file, if not insert: https://www.reddit.com/r/vim/comments/mpww63/adding_text_when_opening_a_new_buffer/
  " delete new line at end of file: https://vi.stackexchange.com/questions/29091/exclude-trailing-newline-when-reading-in-skeleton-file
  " https://vimtricks.com/p/automated-file-templates/ or read in from file
  " au BufNewFile ~/Documents/notes/diary/*.md
  " or break it out: https://levelup.gitconnected.com/reducing-boilerplate-with-vim-templates-83831f8ced12
  " autocmd BufNewFile ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/diary/*.md
  " autocmd BufNewFile */diary/*.md call InsertDate()
  " autocmd BufNewFile */diary/*.md
  "   \ call append(0,[
  "   \ "# " . split(expand('%:r'),'/')[-1], "",
  "   \ "***POMODORO***",
  "   \ "***OPEN FOCUS BAR***",
  "   \ "***Visible TODOs***", "",
  "   \ "## Daily checklist", "",
  "   \ "- [ ] Geekbot", "",
  "   \ "## Todo",  "",
  "   \ "## Unplanned",  "",
  "   \ "## Push",  "",
  "   \ "## Near Future",  "",
  "   \ "## Notes"])
augroup end
