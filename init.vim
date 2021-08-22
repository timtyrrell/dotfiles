set shell=/usr/local/bin/zsh

set title "displays current file as vim title
set visualbell "kills the bell
set t_vb= "kills the bell

" install? https://github.com/Konfekt/FastFold
" install? https://github.com/Jorengarenar/vim-syntaxMarkerFold
" folds
" set foldcolumn=2
" Space to toggle folds.
" nnoremap <space><space> za
" vnoremap <space><space> za
" commands
" zf - create fold
" zd - delete fold under cursor
" zR - open all folds
" zM - close all folds
"
" treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" disable folding
set nofoldenable

"command line completion
set wildmenu
set wildmode=longest:full,full
" not as nice looking but selects first option
" set wildmode=longest:list,full
set wildoptions=pum
" set wildoptions+=pum
" Enables pseudo-transparency for the popup-menu, 0-100
set pumblend=20
set wildcharm=<Tab>
" set completeopt+=noselect,noinsert,menuone,preview
set completeopt=menuone,noinsert,noselect,preview

" ignore case, example: :e TEST.js
set wildignorecase

set wildignore+=tags,package-lock.json

" give low priority to files matching the defined patterns.
set suffixes+=.lock,.scss,.sass,.min.js,.less,.json

let mapleader = ','

" save a shift in normal mode
" nnoremap ; :

" switch back and forth with two most recent files in buffer
" nnoremap <Leader><Leader> <C-^>

" go back to last old buffer
" nnoremap <bs> <c-^>
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
" Numbered tab: ngt
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tl :tablast<CR>
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
" nnoremap <leader>0 :tablast<CR> ?

" add < and > to matched pairs
set matchpairs+=<:>

" Clear cmd line message after 5 seconds
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
  autocmd!
  autocmd CmdlineLeave :  call timer_start(5000, funcref('s:empty_message'))
augroup END
" augroup cmdline
"   autocmd!
"   autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
" augroup END
" or use key to trigger like
" noremap <C-L> :nohls<CR><C-L>


augroup checktimegroup
  autocmd!
  augroup FocusGained * :checktime " make it work with neovim
augroup END

set splitright
set splitbelow
set autoread " do not prompt and reload file system changes
set hidden " allows you to abandon a buffer without saving
set smartindent " Keep indentation from previous line
set breakindent
set breakindentopt=shift:2
set showbreak=↳
set expandtab " Use softtabstop spaces instead of tab characters
set softtabstop=2 " Indent by 2 spaces when pressing <TAB>
set shiftwidth=2 " Indent by 2 spaces when using >>, <<, == etc.
set showtabline=2 " always display vim tab bar
set number " show line numbers
set relativenumber

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
" Also / then C-r C-w inserts the word under the cursor
" C-r C-l inserts the entire line
" /res then C-l will add the next character, can keep hitting
" https://www.reddit.com/r/vim/comments/jkxuv8/is_easymotion_the_fastest_way_to_navigate_to_an/gaoiwjd/?context=3

" add insert mode shortcuts like terminal
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" allow tab/s-tab to filter with incsearch in-progress
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? '<c-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<c-t>' : '<S-Tab>'

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

set ignorecase
set infercase " enhances ignorecase
set smartcase
set inccommand=nosplit "highlight :s in realtime
set diffopt+=vertical
" allows block selections to operate across lines regardless of the underlying text
set virtualedit=block

" make all visual select blockwise
" noremap v <c-v>
" noremap <c-v> v

" do not jump from item on * search
" nnoremap * *``
" nnoremap * m`:keepjumps normal! *``<cr>

set complete-=t " disable searching tags
nnoremap <silent><leader>vr :call execute('source $MYVIMRC')<cr>:echo 'vim config reloaded!'<cr>

" Toggle spell checking on and off with `,s`
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
" nnoremap z= :call FzfSpell()<CR>
nmap <silent> <leader>sz :call FzfSpell()<CR>
" try https://github.com/lewis6991/spellsitter.nvim ?

" Unhighlight search results
map <Leader><space> :nohl<cr>

" n always search forward and N always backward.
" noremap <expr> <SID>(search-forward) 'Nn'[v:searchforward]
" noremap <expr> <SID>(search-backward) 'nN'[v:searchforward]
" nmap n <SID>(search-forward)zzzv
" xmap n <SID>(search-forward)zzzv
" nmap N <SID>(search-backward)zzzv
" xmap N <SID>(search-backward)zzzv

" Bring search results to midscreen
" nnoremap n nzzzv
" nnoremap N Nzzzv

" leave lines visible above/below cursor when moving around
set scrolloff=5

" keep windows same size when opening/closing splits
set equalalways

" only highlight cursorline in current active buffer, when not in insert mode
augroup ALL_MY_WEIRD_AUTO_COMMANDS
  autocmd!
  " resize panes the host window is resized
  autocmd VimResume,VimResized, CocExplorerOpenPost, CocExplorerQuitPost * wincmd =
  autocmd VimResized,VimResume * execute "normal! \<C-w>="
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline
  " source $MYVIMRC when saving $MYVIMRC
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  " autocmd BufWritePost * if &diff | diffupdate | endif " update diff after save
  " autocmd BufWritePre *.md CocCommand markdownlint.fixAll
  " autocmd BufWritePost *.md CocCommand markdownlint.fixAll | echo 'hi'
  " autocmd BufWritePost *.jsx,*.js CocCommand eslint.executeAutofix
augroup END

"sessions
" Don't save hidden and unloaded buffers in sessions
set sessionoptions-=buffers
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options
" don't restore help windows
set sessionoptions-=help

" always paste from 0 register to avoid pasting deleted text
" I don't love this yet...
" nnoremap <expr> p (v:register ==# '"' ? '"0' : '') . 'p'
" nnoremap <expr> P (v:register ==# '"' ? '"0' : '') . 'P'
" xnoremap <expr> p (v:register ==# '"' ? '"0' : '') . 'p'
" xnoremap <expr> P (v:register ==# '"' ? '"0' : '') . 'P'
" Default VIM commands for pasting registers in insert move
" <C-R>a pastes the contents of the `a` register
" <C-R>" pastes the contents of the unnamed register (last delete/yank/etc)

" Indent/dedent what you just pasted
nnoremap <leader>< V`]<
nnoremap <leader>> V`]>

" reselect pasted text. gv, reselects the last visual selection
nnoremap gp `[v`]

" Don't lose selection when shifting sidewards
"*** seems to remove the ability to '.' ***
" xnoremap < <gv
" xnoremap > >gv

" split windows
nnoremap <C-w>- :new<cr>
nnoremap <C-w><bar> :vnew<cr>

" open file under cursor in vertical split
map <C-w>f <C-w>vgf

" open file under cursor anywhere on line
" https://www.reddit.com/r/vim/comments/mcxha4/remapping_gf_to_open_a_file_from_anywhere_on_the/
nnoremap gf ^f/gf

" change directory to folder of current file
nnoremap <leader>cd :cd %:p:h<cr>

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
nnoremap <C-w>o :call ToggleMaxWins()<cr>

" hide the command history buffer. Use fzf :History instead
nnoremap q: <nop>

" disable mouse
set mouse=

" keep foreground commands in sync
map fg <c-z>
" or the reverse, add this to shell profile
" stty susp undef
" bind '"\C-z":"fg\n"'

" create file...WIP
" map <leader>gf :e <cfile><cr>
" map <silent> <leader>cf :!touch <c-r><c-p><cr><cr>
" map <silent> <leader>cf :call writefile([], expand('<cfile>'), 't')<cr>
" nnoremap cgf :e <c-w><c-f><cr>

" format json
nnoremap <silent> <Leader>jj :%!python -m json.tool<CR>

" format html
nnoremap <silent> <Leader>ti :%!tidy -config ~/.config/tidy_config.txt %<CR>

" remove smart quotes
" %!iconv -f utf-8 -t ascii//translit

" save with Enter *except* in quickfix buffers
" https://vi.stackexchange.com/questions/3127/how-to-map-enter-to-custom-command-except-in-quick-fix
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? '\<CR>' : ':write!<CR>'
" don't write unless changed
" nnoremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? '\<CR>' : ':update<CR>'
" autocmd BufWinEnter * if &filetype ==? 'coc-explorer' | setlocal winhighlight=Normal:NormalJS | endif

" train myself to use better commands
" ZZ - Write current file, if modified, and quit. (:x = :wq = ZZ)
" ZQ - Quit without checking for changes (same as ':q!')
map QQ :qa!<CR>
cabbrev q! use ZQ
cabbrev wq use x or ZZ
cabbrev wq! use x!
cabbrev wqa use xa
cabbrev wqa! use xa!

" speedup :StartTime - :h g:python3_host_prog
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_python_provider = 0
" skip perl check
let g:loaded_perl_provider = 0

call plug#begin('~/.config/nvim/plugged')
" if branch changes from master to main `git remote set-head origin -a` in `~/config/nvim/plugged/[plugin]`

" core code analysis and manipulation
Plug 'neoclide/coc.nvim', {'branch': 'release'} |
           \ Plug 'antoinemadec/coc-fzf' |
           \ Plug 'wellle/tmux-complete.vim' " coc completion from open tmux panes
let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-cssmodules',
          \ 'coc-dash-complete',
          \ 'coc-docker',
          \ 'coc-emoji',
          \ 'coc-eslint',
          \ 'coc-just-complete',
          \ 'coc-explorer',
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

" code formatting config
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

augroup editconfigcmd
  autocmd!
  autocmd FileType gitcommit let b:EditorConfig_disable = 1
augroup END

" buffer management
Plug 'AndrewRadev/undoquit.vim'
"<c-w>u reopen windo
"<c-w>U reopen tab with all windows
Plug 'Asheq/close-buffers.vim'
" :Bdelete other    -	bdelete all buffers except the buffer in the current window
" :Bdelete hidden   -	bdelete buffers not visible in a window
" :Bdelete all      -	bdelete all buffers
" :Bdelete this     -	bdelete buffer in the current window
" :Bdelete nameless -	bdelete buffers without a name: [No Name]
map <leader>Bdo :Bdelete other<CR>
map <leader>Bdh :Bdelete hidden<CR>
map <leader>Bda :Bdelete all<CR>
map <leader>Bdt :Bdelete this<CR>
map <leader>Bdn :Bdelete nameless<CR>

" undo tree visualizer
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

augroup mundoauto
  autocmd!
  autocmd User vim-mundo echom 'vim-mundo is now loaded!'
augroup END

Plug 'tpope/vim-obsession' " session management

" debugging
Plug 'mfussenegger/nvim-dap'
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
" Plug 'haringsrob/nvim_context_vt' " Add virtual text to show current context
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'mfussenegger/nvim-ts-hint-textobject'

Plug 'andrewradev/sideways.vim'
nnoremap <A-h> :SidewaysLeft<cr>
nnoremap <A-l> :SidewaysRight<cr>
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
let g:indent_blankline_char = '▏'
let g:indent_blankline_filetype_exclude = [
     \ 'startify', 'coc-explorer'
     \]
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_space_char_blankline = ' '
let g:indent_blankline_space_char = '⋅'
" let g:indent_blankline_context_patterns = ['class', 'function', 'method',
" 				\ 'if_statement', 'else_clause', 'jsx_element', 'jsx_self_closing_element',
" 				\ 'try_statement', 'catch_clause']
" https://github.com/lukas-reineke/indent-blankline.nvim/issues/61#issuecomment-869872432
let g:indent_blankline_context_patterns = [ 'declaration', 'expression', 'pattern', 'primary_expression', 'statement', 'switch_body', 'jsx_element', 'jsx_self_closing_element', 'import_statement']

augroup tmuxgroups
  autocmd!
  autocmd FileType tmux nnoremap <silent><buffer> K :call tmux#man()<CR>
  " automatically source tmux config when saved
  autocmd bufwritepost .tmux.conf execute ':!tmux source-file %'
augroup END
Plug 'tmux-plugins/vim-tmux'
" https://github.com/nvim-treesitter/nvim-treesitter/issues/1019#issuecomment-812976740
let g:polyglot_disabled = [
        \ 'bash', 'comment', 'css', 'graphql',
        \ 'html', 'javascript', 'jsdoc', 'json',
        \ 'jsonc', 'jsx', 'lua', 'python', 'regex', 'rspec', 'ruby',
        \ 'sh', 'svg', 'tmux', 'tsx', 'typescript', 'typescriptreact', 'yaml']
Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['ftdetect']
" let g:polyglot_disabled = ['sensible']
" let g:polyglot_disabled = ['autoindent']
let g:markdown_fenced_languages = ['ruby', 'vim']

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

" markdown preview in nvim popup
Plug 'npxbr/glow.nvim', {'do': ':GlowInstall', 'for': 'markdown'}
nmap <leader>mv :Glow<CR>
" q to quit, :Glow for current filepath

Plug 'godlygeek/tabular', { 'on': 'Tabularize'}
" Tabularize /,
augroup tabularloaded
  autocmd!
  autocmd User tabular echom 'Tabular is now loaded!'
augroup END

Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle'}
augroup tablemodeload
  autocmd!
  autocmd User vim-table-mode echom 'vim-table-mode is now loaded!'
augroup END
let g:table_mode_map_prefix = '<Leader>tm'
" <Leader>tm
" This is a prefix defined by the option |table-mode-map-prefix| used before all other table mode commands.
" <Leader>tmm
" Toggle table mode for the current buffer. You can change this using the |toggle-mode-options-toggle-map| option.
" |
" Trigger table creation in table mode. You can change this using the |toggle-mode-options-separator| option.
" <Leader>tmt
" Triggers |table-mode-commands-tableize| on the visually selected content.
" mappings? need ,tm
" <Leader>T
" Triggers |table-mode-commands-tableize| on the visually selected asking for user to input the delimiter.
" <Leader>tr
" Realigns table columns
" <Leader>tdd
" Delete the entire table row you are on or multiple rows using a [count]
" <Leader>tdc
" Delete entire table column you are within. You can preceed it with a [count] to delete multiple columns to the right
" <Leader>tiC
" Insert a table column before the column you are within. You can preceed it with a [count] to insert multiple columns
" <Leader>tic
" Insert a table column after the column you are within. You can preceed it with a [count] to insert multiple columns
" <Leader>ts      Sort a column under the cursor
" ||              Expands to a header border
" *table-mode-mappings-motions*
" [|              Move to previous cell
" ]|              Move to next cell
" {|              Move to the cell above
" }|              Move to the cell below

" https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/
Plug 'tpope/vim-abolish'
" MixedCase (crm)
" camelCase (crc)
" snake_case (crs)
" UPPER_CASE (cru)
" dash-case (cr-)
" Title Case (crt)

Plug 'mileszs/ack.vim'

" enhanced matchit
Plug 'andymass/vim-matchup'

" tab to exit enclosing character
Plug 'abecodes/tabout.nvim'

" sneak replacement
Plug 'ggandor/lightspeed.nvim'
" s{char}{char} motion
" dz{char}{char} - delete until

Plug 'phaazon/hop.nvim'

Plug 'christoomey/vim-sort-motion'
" make all sorts case insensitive and remove duplicates.
let g:sort_motion_flags = 'ui'
" gs2j => Sort down two lines (current + 2 below)
" gsip => Sort the current paragraph
" gsi{ => sort inner parenthesis

Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'kevinhwang91/nvim-bqf'
" https://github.com/kevinhwang91/nvim-bqf#function-table
" zf - fzf in quickfix
" zp - toggle full screen preview
" zn or zN - create new quickfix list
" < - previous quickfix list
" > - next quickfix list

Plug 'christoomey/vim-tmux-navigator'
" simplify split navigation
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" don't need for neovim?
" Plug 'tmux-plugins/vim-tmux-focus-events'

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
"gcc comment out, gcap for paragraph

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

Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-apathy'
"gf support
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
"vitSt - add inner tag
"vatSt - add surrounding tag

augroup jsconsolecmds
  autocmd!
  "wrap in console.log - yswc or yssc TODO: broken also??
  autocmd FileType javascript let b:surround_{char2nr('c')} = 'console.log(\r)'
  autocmd FileType javascript let b:surround_{char2nr('e')} = '${\r}'
  " move word under cursor up or down a line wrapped in a console.log
  autocmd FileType javascript nnoremap <buffer> <leader>clO "zyiwOconsole.log(z)<Esc>
  autocmd FileType javascript nnoremap <buffer> <leader>clo "zyiwoconsole.log(z)<Esc>
augroup END

Plug 'tpope/vim-unimpaired'
" prev conflict/patch: [n , next conflict/patch: ]n , paste toggle: yop
" [<Space> and ]<Space> add newlines before and after the cursor line
" [e and ]e exchange the current line with the one above or below it.

Plug 'terryma/vim-expand-region'
vmap + <Plug>(expand_region_expand)
vmap - <Plug>(expand_region_shrink)

Plug 'wincent/scalpel'
" replace all instances of the word currently under the cursor throughout a file. <Leader>e mnemonic: edit)

Plug 'tommcdo/vim-exchange'
" cxw - set word, . to swap
" cxx - set line, . to swap
" cxiw, etc
" cxc - clear

Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-line'
" adds 'al' and 'il' motions for a line
" 'il' ignores leading and trailing spaces. 'al' ignoes EOL
" a lot more: https://github.com/kana/vim-textobj-user/wiki
" try https://github.com/wellle/targets.vim ?

" https://github.com/mlaursen/vim-react-snippets#cheatsheet
Plug 'mlaursen/vim-react-snippets', { 'branch': 'main' }

" review linenumber before jump
Plug 'nacro90/numb.nvim'

Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
nmap <leader>snr <Plug>SnipRun
" nmap <leader>sn <Plug>SnipRunOperator
vmap sn <Plug>SnipRun
nmap <leader>snc <Plug>SnipClose

" diff visual selections
Plug 'andrewradev/linediff.vim'
" :Linediff

" git
Plug 'tpope/vim-fugitive' |
           \ Plug 'junegunn/gv.vim' |
           \ Plug 'tpope/vim-rhubarb' | "GitHub extension for fugitive.vim

" Fugitive mapping
nmap <leader>gb :Git blame<cr>
nmap <leader>gB :%Git blame<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gl :Gclog<cr>
nmap <leader>gL :Gclog -- %<cr>
" nmap <leader>gL :Gclog -100<cr>
nmap <leader>gs :Git<cr>
" P (on the file you want to run patch on)
nmap <leader>ge :Gedit<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gr :Gread<cr>:update<cr>
nmap <leader>gg :Ggrep

" Add the entire file to the staging area
nnoremap <Leader>gaf :Gw<CR>

" Open visual selection in browser
vnoremap <Leader>Gb :GBrowse<CR>

" Open current line in the browser
nnoremap <Leader>Gb :.GBrowse<CR>

" Copy visual selection url to clipboard
vnoremap <Leader>GB :GBrowse!<CR>

" Copy current line url to clipboard
nnoremap <Leader>GB :.GBrowse!<CR>
" :0Glog " see history of current file
" :Gedit " go back to normal file from read-only view in Gstatus window
" <C-N> or <C-P> to jump to the next/previous file (as mentioned above)
" - on a file, stages (or unstages) the entire file.
" = shows the git diff of the file your cursor is on.
" - on a hunk, stages (or unstages) the hunk.
" - in a visual selection, stages (or unstages) the selected lines in the hunk.
" cvc - commits the staged changes in verbose mode. I like the last chance it gives me to verify the right changes have been staged, and it helps inform the commit message.
" :GV to open commit browser
"     You can pass git log options to the command, e.g. :GV -S foobar.
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
" :Gwrite[!] write the current file to the index and exits vimdiff mode.
" HUNKS
" do - `diffget` (obtain)
" dp - `diffput`

" command line mergetool
Plug 'christoomey/vim-conflicted'
" `git conflicted` or `git mergetool` to open
" `:GitNextConflict` go to next file
" `dgu` - diffget from the upstream version
" `dgl` - diffget from the local version
" [c and ]c to navigate conflicts in file

" disable showing '------' for empty line in difftool
" I want to set it as a blank space but space-jam deletes the space....
" set fillchars=diff:\

Plug 'rhysd/git-messenger.vim'
" git blame: <Leader>gm
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

Plug 'kevinhwang91/nvim-hlslens'
" do not jump from item on * search
nnoremap * *``<Cmd>lua require('hlslens').start()<CR>
nnoremap * m`:keepjumps normal! *``<cr><Cmd>lua require('hlslens').start()<CR>
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>te :Telescope<cr>
" install if I ever start using telescope
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'pwntester/octo.nvim'
nnoremap <leader>opr <cmd>Octo pr list<cr>
nnoremap <leader>ors <cmd>Octo review start<cr>
nnoremap <leader>orr <cmd>Octo review resume<cr>
nnoremap <leader>orb <cmd>Octo review submit<cr>

Plug 'kyazdani42/nvim-web-devicons'
" https://levelup.gitconnected.com/git-worktrees-the-best-git-feature-youve-never-heard-of-9cd21df67baf
Plug 'ThePrimeagen/git-worktree.nvim'

" Plug 'nvim-telescope/telescope-project.nvim'
" https://github.com/AckslD/nvim-neoclip.lua

" Plug 'tami5/sql.nvim'
" Plug 'nvim-telescope/telescope-frecency.nvim'

Plug 'chrisbra/unicode.vim'
let g:Unicode_ShowPreviewWindow = 1
let g:Unicode_CompleteName = 1
" :Digraphs        - Search for specific digraph char
" :UnicodeSearch   - Search for specific unicode char
" :UnicodeSearch!  - Search for specific unicode char (and add at current cursor position)
" :UnicodeName     - Identify character under cursor (like ga command)
" :UnicodeTable    - Print Unicode Table in new window
" :DownloadUnicode - Download (or update) Unicode data
" :UnicodeCache    - Create cache file

" testing/debugging
" Plug 'vim-test/vim-test'

" regex explain - :ExplainPattern {pattern} or :ExplainPattern {register}
Plug 'Houl/ExplainPattern'

" Plug 'puremourning/vimspector'

Plug 'tpope/vim-scriptease'
" https://codeinthehole.com/tips/debugging-vim-by-example/#why-isn-t-syntax-highlighting-working-as-i-want
" zS to indentify the systen region name
" :verbose hi jsTemplateString
" :Messages load messages into quickfix

" visiblity
Plug 'psliwka/vim-smoothie'

Plug 'danilamihailov/beacon.nvim'
let g:beacon_ignore_filetypes = ['git']
if !&diff
  let g:beacon_show_jumps = 0
  let g:beacon_ignore_buffers = [
      \ "Mundo",
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

Plug 'junegunn/vim-peekaboo'
" spacebar toggle full screen

" mark column display
Plug 'kshenoy/vim-signature'

" displays colors for words/hex
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'less']

" appearence and insight
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsOS = 'Darwin'

" massive cmdline improvement
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim' |
          \ Plug 'konart/vim-lightline-coc' " |
          " \ Plug 'timtyrrell/apprentice-lightline-experimental'
Plug 'mhinz/vim-startify'
Plug 'folke/tokyonight.nvim'
" Plug 'EdenEast/nightfox.nvim'

Plug 'folke/todo-comments.nvim'

" center window, mode keeping status bars, etc :VenterToggle
Plug 'jmckiern/vim-venter'
let g:venter_width = &columns/6
nnoremap <leader>ve :VenterToggle<CR>

" center current buffer, in neovim z-index
Plug 'folke/zen-mode.nvim'
nnoremap <leader>zm :ZenMode<CR>
" Plug 'folke/twilight.nvim'

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

Plug 'keith/investigate.vim'
" gK to open word in Dash
let g:investigate_use_dash=1
let g:investigate_dash_for_typescriptreact="javascript"

Plug 'meain/vim-package-info', { 'do': 'npm install' }
" another one to try: https://github.com/vuki656/package-info.nvim

" monorepo
Plug 'airblade/vim-rooter'
" add git worktree to excludes
let g:rooter_patterns = ['!.git/worktrees', '.git', 'Makefile']
" trigger by symlinks, also
let g:rooter_resolve_links = 1
" to stop echo on change
" let g:rooter_silent_chdir = 1

" life
" Plug 'dstein64/vim-startuptime'
" gf to go deeper
" K for more info
Plug 'tweekmonster/startuptime.vim'

" Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'vimwiki/vimwiki', { 'branch': 'dev', 'for': 'markdown', 'on': 'VimwikiMakeDiaryNote' }
augroup load_vimwiki
  autocmd!
  autocmd! User Vimwiki echom 'Vimwiki is now loaded!'
augroup END

" Load on nothing " the dir path is not right
" Plug 'vimwiki/vimwiki', { 'branch': 'dev', 'on': []}
" augroup load_vimwiki
"   echo $HOME . '/dotfiles'
"   autocmd!
"   " autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
"   autocmd BufNewFile,BufRead *.md * echo 'hi'
"   autocmd BufNewFile,BufRead *.md * call plug#load('vimwiki')
"   autocmd BufNewFile,BufRead $HOME . '/dotfiles'  * call plug#load('vimwiki')
"   autocmd BufNewFile,BufRead /Users/timothy.tyrrell/code/timtyrrell/dotfiles  * call plug#load('vimwiki')
"                      \| autocmd! load_vimwiki
" augroup END

Plug 'mattn/calendar-vim'
let g:calendar_no_mappings=0
" Brings up the calendar in a vertical split.
nmap <Leader>cl <Plug>CalendarV
nmap <Leader>cL <Plug>CalendarH

Plug 'alok/notational-fzf-vim'
Plug 'ferrine/md-img-paste.vim'

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

Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:hardtime_showmsg = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = ['help', 'nofile']
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 0
let g:hardtime_maxcount = 2

" bugfix
" fix CursorHold perf bug
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

call wilder#enable_cmdline_enter()
" only / and ? are enabled by default
call wilder#set_option('modes', ['/', '?', ':'])

cmap <expr> <Tab> wilder#in_context() ? wilder#next() : '\<Tab>'
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : '\<S-Tab>'
cmap <expr> <c-j> wilder#in_context() ? wilder#next() : '\<c-j>'
cmap <expr> <c-k> wilder#in_context() ? wilder#previous() : '\<c-k>'

" use wilder#wildmenu_lightline_theme() if using Lightline
" 'highlights' : can be overriden, see :h wilder#wildmenu_renderer()
call wilder#set_option('renderer', wilder#wildmenu_renderer(
      \ wilder#wildmenu_lightline_theme({
      \   'highlights': {},
      \   'highlighter': wilder#basic_highlighter(),
      \   'separator': ' · ',
      \ })))

" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ '/': wilder#wildmenu_renderer({
      \   'highlighter': s:highlighters,
      \ }),
      \ }))

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   wilder#popupmenu_devicons(),
      \ ],
      \ }))

" example: `vm` to visually display hints to select
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> m :lua require('tsht').nodes()<CR>

lua << EOF
require'lightspeed'.setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = false,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 5,
  full_inclusive_prefix_key = '<c-x>',
  -- For instant-repeat, pressing the trigger key again (f/F/t/T)
  -- always works, but here you can specify additional keys too.
  instant_repeat_fwd_key = ';',
  instant_repeat_bwd_key = ':',
  -- By default, the values of these will be decided at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}

require'hop'.setup()
vim.api.nvim_set_keymap('n', '<leader>hw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>hl', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>hp', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader>hw', "<cmd>lua require'hop'.hint_words()<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader>hp', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

require("todo-comments").setup {}

-- example: `vd` to visually surround logical unit '.' to select more
-- vim.api.nvim_set_keymap('v', 'd', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('o', 'd', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})

require("zen-mode").setup {
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    width = .5, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = false },
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = true,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
require("telescope").load_extension("git_worktree")

-- nvim-telescope/telescope-dap.nvim
-- require('telescope').load_extension('dap')
-- map('n', '<leader>ds', ':Telescope dap frames<CR>')
-- map('n', '<leader>dc', ':Telescope dap commands<CR>')
-- map('n', '<leader>db', ':Telescope dap list_breakpoints<CR>')

local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- https://github.com/nvim-telescope/telescope.nvim/blob/d0cf646f65746415294f570ec643ffd0101ca3ab/lua/telescope/mappings.lua
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        prompt_position = "top"
      },
    },
    sorting_strategy = "ascending",
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  }
}

require"octo".setup({
  submit_win = {
      approve_review = "<C-p>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
})
require"nvim-web-devicons".setup()

require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

require('numb').setup {
   show_numbers = true, -- Enable 'number' for the window while peeking
   show_cursorline = true -- Enable 'cursorline' for the window while peeking
}

require'sniprun'.setup({
  display = {
    "VirtualTextOk",              -- "display ok results as virtual text (multiline is shortened)
    "VirtualTextErr",          -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    --"Terminal"                 -- "display results in a vertical split
  },
})

require("tabout").setup()

require'nvim-treesitter.configs'.setup {
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
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  context_commentstring = {
    enable = true,
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      }
    }
  },
  textsubjects = {
      enable = true,
      keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
      }
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
    },
  },
  playground = {
    enable = false,
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
-- lua
require('hlslens').setup({
  nearest_only = true
})
EOF


augroup randomstuff
  autocmd!
  " Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  " if highlighting on big files is bad, can do similiar:
  " autocmd FileType typescript syntax sync ccomment minlines=1500

  " open bug https://github.com/nvim-treesitter/nvim-treesitter/issues/1249
  " au! BufRead,BufNewFile *.json set filetype=jsonc

  " set graphql filetype based on dir
  autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
  autocmd BufRead,BufNewFile */graphql/queries/*.js set syntax=graphql
  autocmd BufNewFile,BufRead .eslintrc,.prettierrc,.lintstagedrc set filetype=jsonc
  autocmd BufNewFile,BufRead *.bak set filetype=javascript
  autocmd BufNewFile,BufRead *.build,.env* set filetype=sh
  " per reddit, Vim doesn't have an autocommand for graphql files. You will have to manually add this line to your config - not sure if needed
  autocmd BufRead,BufNewFile *.graphql,*.graphqls,*.gql setfiletype graphql

  " Return to last edit position when opening files (You want this!)
  " autocmd BufReadPost *
  "       \ if line("'\"") > 0 && line("'\"") <= line("$") |
  "       \   exe "normal! g`\"" |
  "       \ endif
augroup END

augroup LastCursorPos
  autocmd!
  autocmd BufReadPost * if @% !~# "\.git[\/\\]COMMIT_EDITMSG$" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
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

" vim-mundo
nmap <Leader>mt :MundoToggle<CR>
let g:mundo_right=1

" vim-smoothie
let g:smoothie_base_speed = 20

" vim-peekaboo
let g:peekaboo_delay='1000' " delay 1000ms
let g:peekaboo_window="call CreateCenteredFloatingWindow()"

function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.7)
    let height = float2nr(&lines * 0.7)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

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

function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
   :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

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
    let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
  endif

  let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
  if l:uri !~? 'github.com'
    return
  endif
  let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
  let l:url  = empty(l:sha)
              \ ? 'https://github.com/'.l:repo
              \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
  call netrw#BrowseX(l:url, 0)
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
    " hi default link IncSearch Sneak
    " hi default link HlSearchNear Sneak
    " hi default link HlSearchLens WildMenu
    " hi default link HlSearchLensNear Sneak
    " hi default link HlSearchFloat Sneak
    " hi CocHighlightText cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    "git.addedSign.hlGroup": "GitGutterAdd",
    "git.changedSign.hlGroup": "GitGutterChange",
    "git.removedSign.hlGroup": "GitGutterDelete",
    "git.topRemovedSign.hlGroup": "GitGutterDelete",
    "git.changeRemovedSign.hlGroup": "GitGutterChangeDelete",
	  " hi default link CocGitAddedSign
    " hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guifg=#262626 guibg=#87af87 gui=reverse
    " hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guifg=#262626 guibg=#af5f5f gui=reverse
    " hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guifg=#262626 guibg=#8787af gui=reverse
  end
  if g:colors_name ==# 'apprentice'
    " match codelens to Comment color so it stands out less
    " hi CocCodeLens guifg=#585858
    " hi MatchParen ctermbg=234 ctermfg=229 cterm=NONE guibg=#1c1c1c guifg=#ffffaf gui=NONE
    " hi MatchParen cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626

    " coc-git column highlights
    " hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guifg=#262626 guibg=#87af87 gui=reverse
    " hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guifg=#262626 guibg=#af5f5f gui=reverse
    " hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guifg=#262626 guibg=#8787af gui=reverse
    " hi LineNr ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    " hi SignColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    " hi FoldColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    " hi Folded ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE

    " 'kshenoy/vim-signature'
    " hi SignatureMarkText guibg=#262626

    " 'kevinhwang91/nvim-hlslens'
    " hi CurrentSearchItem guibg=#ff8700 guifg=#262626
    " hi CurrentSearchItem cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    " hi default link HlSearchNear CurrentSearchItem
    " hi default link HlSearchLens HlLens
    " hi default link HlSearchLensNear HlLens
    " hi default link HlSearchFloat HlLens

    " random color change
    " hi IncSearch ctermbg=131 ctermfg=235 cterm=NONE guibg=#af5f5f guifg=#262626 gui=NONE
    " hi IncSearch cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    " hi IncSearch guibg=#ff8700 guifg=#262626

    " Overwrite the highlight groups `CocHighlightText`, `CocHighlightRead` and `CocHighlightWrite` for customizing the colors.
    " hi CocHighlightText cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    " hi CocHighlightText ctermbg=229 ctermfg=235 cterm=NONE guibg=#ffffaf guifg=#262626 gui=NONE
    " hi CocHighlightText ctermbg=NONE ctermfg=208 cterm=undercurl guibg=NONE guifg=#ff8700 guisp=#ff8700
    " highlight CocHighlightText term=underline cterm=underline gui=underline
    " highlight CursorLine gui=underline cterm=underline ctermfg=None guifg=None
  end
  " if &filetype ==# 'coc-explorer'
    " autocmd WinEnter * call Handle_Win_Enter()
    " setlocal winhighlight=Normal:Potato
  " endif
  " overwrite floating coc-explorer group
  " highlight link CocExplorerNormalFloat Normal
endfunction

" hi NormalJS ctermbg=green guibg=green guifg=#87afd7 guibg=#87afd7
" hi NormalJS cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#87afd7
" set winhighlight=Normal:MyNormal,NormalNC:MyNormalNC
" autocmd BufEnter,BufWinEnter,WinEnter * setlocal winhighlight=Normal:NormalJS,NormalNC:NormalJS
" autocmd BufEnter * setlocal winhighlight=Normal:NormalJS,NormalNC:NormalJS

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
  " autocmd BufWinEnter * if &filetype ==? 'coc-explorer' | setlocal winhighlight=Normal:NormalJS | endif
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

let base16colorspace=256
" might as well play it safe, kids
if has("termguicolors")
  set termguicolors
endif
" colorscheme apprentice
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "coc-explorer", "terminal"]
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

" hide line showing switch in insert/normal mode
set noshowmode
set noruler

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
  \     'make': 'yarn',
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
    \   'left': [ [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'],
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
    \ },
    \ 'component': {
    \   'lineinfo': '%3l  %-2c%<',
    \ },
    \ 'separator': { 'left': "\ue0b4", 'right': "\ue0b6" },
    \ 'subseparator': { 'left': "\ue0b5", 'right': "\ue0b7" },
    \ 'tab_component_function': {
    \   'tabnum': 'LightlineWebDevIcons',
    \   'filename': 'LightlineTabname',
    \ },
    \ }
let g:lightline#coc#indicator_warnings = ''
let g:lightline#coc#indicator_errors = ''
let g:lightline#coc#indicator_info = ''

" Use autocmd to force lightline update.
" autocmd User CocDiagnosticChange call lightline#update()

function! LightlineFilenameDisplay()
  if &ft == 'coc-explorer'
    return ''
  else
  " " if starts with term, no filename
  " elseif bufname("term")
  " else
    return winwidth(0) > 90 ? WebDevIconsGetFileTypeSymbol(LightlineFilename()) . ' '. LightlineFilename() : pathshorten(fnamemodify(expand('%'), ":."))
  endif
endfunction

  " if path[:len(root)-1] ==# root
  "   return &filetype !~# g:tcd_blacklist && winwidth(0) > 70 ? Devicon().' '.path[len(root)+1:] : ''
  " endif
  " return &filetype !~# g:tcd_blacklist && winwidth(0) > 70 ? Devicon().' '.expand('%') : &filetype

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
    \ l:fname =~ '^\[coc-explorer\]' ? 'Explorer' :
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
    if winwidth(0) > 100 && expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'coc-explorer' && exists('*FugitiveHead')
    " if winwidth(0) > 80 && expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'coc-explorer' && exists('*FugitiveHead')
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

" let g:lightline.colorscheme = 'apprentice'
let g:lightline.colorscheme = 'tokyonight'

" register compoments:
call lightline#coc#register()

lua << EOF
-- mfussenegger/nvim-dap
local dap = require('dap')
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
vim.g.dap_virtual_text = true

-- dap-ui
require("dapui").setup()

-- David-Kunz/jester
vim.api.nvim_set_keymap('n', '<leader>td', ':lua require"jester".debug({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require"jester".run({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>t_', ':lua require"jester".run_last({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require"jester".run_file({ cmd = "./node_modules/.bin/jest -t '$result' -- $file" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>d_', ':lua require"jester".debug_last({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>df', ':lua require"jester".debug_file({ path_to_jest = "node_modules/.bin/jest" })<cr>', {})
EOF

" coc-jest
" Run jest for current file
nnoremap <leader>tf :call CocActionAsync('runCommand', 'jest.fileTest', ['%'])<CR>
" Run jest for current test
nnoremap <leader>tt :call CocActionAsync('runCommand', 'jest.singleTest')<CR>
" Run jest for current project
nnoremap <leader>tp :call CocActionAsync('runCommand', 'jest.projectTest')<CR>

" dap-ui
nnoremap <leader>dq :lua require'dapui'.toggle()<CR>
nnoremap <leader>due :lua require'dapui'.eval()<cr>
vnoremap <leader>due :lua require'dapui'.eval()<cr>
nnoremap <leader>duf :lua require'dapui'.float_element()<cr>
nnoremap <leader>dus :lua require'dapui'.float_element("scopes")<cr>
nnoremap <leader>dur :lua require'dapui'.float_element("repl")<cr>

" nvim-dap
nnoremap <leader>dt :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>d_ :lua require'dap'.disconnect();require"dap".close();require"dap".run_last()<CR>

nnoremap <leader>da :lua require'debugHelper'.attachToNode()<CR>
nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
nnoremap <leader>dc :lua require'debugHelper'.attachToChrome()<CR>

nnoremap <leader>dbc :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <leader>dbm :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <leader>dso :lua require'dap'.step_out()<CR>
nnoremap <leader>dsi :lua require'dap'.step_into()<CR>
nnoremap <leader>dsv :lua require'dap'.step_over()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>drv :lua require'dap'.repl.open({}, 'vsplit')<CR>
nnoremap <leader>dro :lua require'dap'.repl.open()<CR>
nnoremap <leader>drl :lua require'dap'.repl.run_last()<CR>
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>dI :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>

" vim-test
" nnoremap <silent> <Leader>tt :TestNearest<CR>
" nnoremap <silent> <Leader>tf :TestFile<CR>
" nnoremap <silent> <Leader>ts :TestSuite<CR>
" nnoremap <silent> <Leader>tl :TestLast<CR>
" nnoremap <silent> <Leader>tv :TestVisit<CR>
" let test#strategy = 'neovim'
" let test#javascript#jest#options = '--no-watchman'
" tmap <C-o> <C-\><C-n> " easier switch to normal mode to scroll

" npx jest 2>&1 | grep 'FAIL' | sort -t: -u -k1,1 " only display failed
" https://github.com/vim-test/vim-test/issues/331
" autocmd FileType typescript compiler jest
" let test#strategy = 'dispatch'
" let g:dispatch_compilers = { 'jest': 'jest-cli' }
" let test#javascript#jest#options = '--no-watchman --reporters jest-vim-reporter'
" let test#javascript#jest#options = '--no-watchman --reporters $HOME/code/timtyrrell/jest-quickfix-reporter/index.js'

" jank/vim-test and mfussenegger/nvim-dap
" nnoremap <leader>dd :TestNearest -strategy=jest<CR>
" function! JestStrategy(cmd)
"   let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
"   let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
"   call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" . fileName . "]])")
" endfunction
" let g:test#custom_strategies = {'jest': function('JestStrategy')}

" puremourning/vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
" let g:vimspector_install_gadgets = ['debugger-for-chrome', 'force-enable-node']
" let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')

" fun! GotoWindow(id)
"   :call win_gotoid(a:id)
" endfun
" let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')
" let g:vimspector_sidebar_width = 120
" let g:vimspector_bottombar_height = 0
" let g:vimspector_sign_priority = {
"    \    'vimspectorBP':         998,
"    \    'vimspectorBPCond':     997,
"    \    'vimspectorBPDisabled': 996,
"    \    'vimspectorPC':         999,
"    \ }

" let g:vimspector_sign_priority = {
"   \    'vimspectorBP':         3,
"   \    'vimspectorBPCond':     2,
"   \    'vimspectorBPDisabled': 1,
"   \    'vimspectorPC':         999,
"   \ }

" func! AddToWatch()
"   let word = expand("<cexpr>")
"   call vimspector#AddWatch(word)
" endfunction
" nnoremap <leader>da :call vimspector#Launch()<CR>
" nnoremap <leader>dd :TestNearest -strategy=jest<CR>
" nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
" nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
" nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
" nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
" nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
" nnoremap <leader>d? :call AddToWatch()<CR>
" nnoremap <leader>dx :call vimspector#Reset()<CR>
" nnoremap <leader>dX :call vimspector#ClearBreakpoints()<CR>
" nnoremap <S-k> <Plug>VimspectorStepOut
" nnoremap <S-l> <Plug>VimspectorStepInto
" nnoremap <S-j> <Plug>VimspectorStepOver
" nnoremap <leader>d_ <Plug>VimspectorRestart
" nnoremap <leader>dn :call vimspector#Continue()<CR>
" nnoremap <leader>drc <Plug>VimspectorRunToCursor
" nnoremap <leader>dh <Plug>VimspectorToggleBreakpoint
" nnoremap <leader>de <Plug>VimspectorToggleConditionalBreakpoint

" nmap <silent> tn :TestNearest<CR>
" nmap <silent> tf :TestFile<CR>
" nmap <silent> ts :TestSuite<CR>
" nmap <silent> tl :TestLast<CR>
" function! JestStrategy(cmd)
"   let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
"   call vimspector#LaunchWithSettings( #{ configuration: 'jest', TestName: testName } )
" endfunction

" let g:test#custom_strategies = {'jest': function('JestStrategy')}

let g:vim_jsx_pretty_colorful_config = 1

let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
let g:git_messenger_extra_blame_args ='-w' " Ignore whitespace

" DEFAULT COC.NVIM START

set updatetime=100

" Give more space for displaying messages
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set shortmess+=S
" shortmess=filnxtToOFsIc

set noconfirm " Don't use dialog boxes to confirm choices

" leave space for git, diagnostics and marks
set signcolumn=auto:5
" set signcolumn=yes:9
" set signcolumn=auto:4-9
" set signcolumn=yes:8

" use C-j, C-k to move in comletion list
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)

" Navigate through git changes on file (overrides default sentence movement, not sure if good)
" nmap ) <Plug>(coc-git-nextchunk)
" nmap ( <Plug>(coc-git-prevchunk)
nmap <leader>uc :CocCommand git.chunkUndo<cr>
vmap <leader>uc :CocCommand git.chunkUndo<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gu <Plug>(coc-references-used)
" find all file references
nmap <leader>afr :<C-u>CocCommand tsserver.findAllFileReferences<cr>

nmap <leader>co :CocOutline<cr>

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

augroup CocGroup
  autocmd!
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " disable autocomplete for vimwiki, ctrl+space to trigger in insert mode
  autocmd FileType vimwiki let b:coc_suggest_disable = 1
  " have snippets complete, only? mess with this: https://github.com/neoclide/coc.nvim/blob/804a007033bd9506edb9c62b4e7d2b36203ba479/doc/coc.txt#L908

  " close preview when completion is done
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

  " make sure to kill coc pid when closing nvim (not sure if needed)
  autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
      \	| call system('kill -9 '.g:coc_process_pid) | endif
  " run this also?
  " :CocCommand workspace.clearWatchman

  " autocmd VimLeavePre * :call coc#rpc#kill()
  "     autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif

  autocmd FileType python let b:coc_root_patterns = ['manage.py']
augroup end

" Applying codeAction to the selected region. Ex: `<leader>aap` for current paragraph
" I have no idea why <leader> will not work here.....
vmap ,a <Plug>(coc-codeaction-selected)
nmap ,a <Plug>(coc-codeaction-selected)

" Coc search
nnoremap <leader>ce :CocSearch <C-R><C-W><CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" refactor split
nmap <silent> go <Plug>(coc-refactor)

" apply codeAction to the current buffer.
nmap <leader>ab <Plug>(coc-codeaction)
" apply codeaction under the cursor
nmap <leader>ac <Plug>(coc-codeaction-cursor)
" execute codelens action on current line
nmap <leader>al <Plug>(coc-codelens-action)

" Apply AutoFix to problem on the current line.
nmap <leader>afl <Plug>(coc-fix-current)

" Display actions on the current line
nmap <leader>cal :CocAction<cr>

" fix eslint (all)
nmap <leader>afa :<C-u>CocCommand eslint.executeAutofix<cr>
" format file
nmap <leader>afo <Plug>(coc-format)
" auto fix imports
nmap <leader>oi :<C-u>CocCommand tsserver.organizeImports<cr>

" add prettier command
:command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocActionAsync('fold', <f-args>)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : '\<C-f>'
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : '\<C-b>'
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? '\<c-r>=coc#float#scroll(1)\<cr>' : '\<Right>'
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? '\<c-r>=coc#float#scroll(0)\<cr>' : '\<Left>'
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : '\<C-f>'
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : '\<C-b>'
" restart when coc gets wonky
nnoremap <silent> <leader>cr :<C-u>CocRestart<CR>
nnoremap <silent> <leader>cs :<C-u>CocStart<CR>

" COC.SNIPPET START

" https://github.com/neoclide/coc.nvim/issues/1775
let g:coc_disable_transparent_cursor = 1

" max items to show in popup list
set pumheight=20

" tell coc how to navigate to next snippet placeholder
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" let g:coc_node_path = '/usr/local/bin/node' " use node v14?
" COC.SNIPPET END

" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" coc-swagger
command -nargs=0 Swagger :CocCommand swagger.render

" switch diagnostic to float for full message displaty
" nmap <leader>? :call coc#config('diagnostic.messageTarget', 'echo')<CR>
" nmap <leader>? :call coc#config('diagnostic.virtualText', v:true)<CR>
" make it toggle
" nmap <leader>? :call coc#config('diagnostic.messageTarget', 'float')<CR>
" nmap <leader>? :call coc#config('diagnostic.virtualText', v:false)<CR>

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'
let g:coc_fzf_preview_fullscreen=0
let g:coc_fzf_preview_toggle_key='\'

nnoremap <silent><nowait> <leader>za :<C-u>CocFzfList actions<CR>
nnoremap <silent><nowait> <leader>zb :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> <leader>zB :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <leader>zc :<C-u>CocFzfList commands<CR>
nnoremap <silent><nowait> <leader>ze :<C-u>CocFzfList extensions<CR>
nnoremap <silent><nowait> <leader>zl :<C-u>CocFzfList location<CR>
nnoremap <silent><nowait> <leader>zL :<C-u>CocFzfList<CR>
nnoremap <silent><nowait> <leader>zo :<C-u>CocFzfList outline<CR>
nnoremap <silent><nowait> <leader>zs :<C-u>CocFzfList symbols<CR>
nnoremap <silent><nowait> <leader>zS :<C-u>CocFzfList snippets<CR>
nnoremap <silent><nowait> <leader>zv :<C-u>CocFzfList services<CR>
nnoremap <silent><nowait> <leader>zr :<C-u>CocFzfListResume<CR>
nnoremap <silent><nowait> <leader>zy :<C-u>CocFzfList yank<CR>
" nnoremap <silent><nowait> <leader>zy :<C-u>CocList -A --normal yank<CR>

" coc-explorer
nnoremap <silent> <tab><tab>  :CocCommand explorer --position floating<CR>
nnoremap <silent> <Leader><Leader> :CocCommand explorer --toggle<CR>

" display fullpath in status line, used for long filenames
function! s:ShowFilename()
    let s:node_info = CocAction('runCommand', 'explorer.getNodeInfo', 0)
    redraw | echohl Debug | echom exists('s:node_info.fullpath') ?
    \ 'Filename: ' . s:node_info.fullpath : '' | echohl None
endfunction

augroup cocexplorercmds
  autocmd!
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
  autocmd CursorMoved \[coc-explorer\]* :call <SID>ShowFilename()
augroup END


" Start multiple cursors session
" nmap <silent> <C-c> <Plug>(coc-cursors-position)
" nmap <silent> <C-d> <Plug>(coc-cursors-word)
" xmap <silent> <C-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" nmap <leader>x  <Plug>(coc-cursors-operator)

" nmap <expr> <silent> <C-d> <SID>select_current_word()
" function! s:select_current_word()
"   if !get(g:, 'coc_cursors_activated', 0)
"     return '\<Plug>(coc-cursors-word)'
"   endif
"   return '*\<Plug>(coc-cursors-word):nohlsearch\<CR>'
" endfun

" define line highlight color
" highlight LineHighlight ctermbg=darkgray guibg=darkgray
" highlight the current line
" nnoremap ll :call matchadd('LineHighlight', '\%'.line('.').'l')<cr>
" " clear all the highlighted lines
" nnoremap lc :call clearmatches()<cr>

" ack.vim
let g:ackprg = 'rg --vimgrep'
" Don't jump to first match
cnoreabbrev Ack Ack!

" use ripgrep for grep
set grepprg=rg\ --vimgrep\ --no-heading
set grepformat=%f:%l:%c:%m
" https://jdhao.github.io/2020/02/16/ripgrep_cheat_sheet/

" grep word under cursor
nnoremap <leader><bs> :Ack! <C-R><C-W><CR>

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
nnoremap <silent> <Leader>ff :Files<CR>
" to set search folder
nnoremap <Leader>fF :Files<space>
" nmap <c-a-p> :cd ~/projects<cr>:Files<cr> " airblade/vim-rooter sets the current path and this switches to a new project

nnoremap <silent> <Leader>fp :call fzf#vim#files('', { 'source': g:FzfFilesSource(), 'options': '--tiebreak=index'})<CR>

nnoremap <Leader>fb :Buffers<CR>
let g:fzf_buffers_jump = 1

" Lines in the current buffer
nnoremap <Leader>fB :BLines<CR>

nnoremap <silent> <Leader>fl :RgLines<CR>
" Lines in loaded buffers
nnoremap <silent> <Leader>fL :Lines<CR>
nnoremap <silent> <Leader>fh :HistoryCmds<CR>
" old and open files
nnoremap <silent> <Leader>fH :History<CR>
nnoremap <silent> <Leader>fS :HistorySearch<CR>
nnoremap <silent> <Leader>fg :GFiles?<CR>
nnoremap <silent> <Leader>fc :Commits<CR>
nnoremap <silent> <Leader>fC :BCommits<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fM :Maps<CR>
nnoremap <silent> <leader>bd :BD<CR>

" start search from current dir
nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>

" Rg current word under cursor
nnoremap <silent> <Leader>rw :RgLines <C-R><C-W><CR>
" Rg with any params (filetypes)
nnoremap <leader>rf :RG **/*.
" Rg with dir autocomplete
nnoremap <leader>rd :RGdir<Space>
" Search by file path/names AND file contents
nnoremap <Leader>ra :Rg<CR>

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
  \   'rg --column --line-number --no-heading --color=always --colors 'path:fg:190,220,255' --colors 'line:fg:128,128,128' --smart-case  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..', '--color', 'hl:123,hl+:222'] }), <bang>0)

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

" filter by anything
" :RG **/*.ts
" :RG -tweb (INCLUDE 'web' type from .ripgreprc)
" :RG -Ttest (EXCLUDE 'test' type from .ripgreprc)
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" autocomplete dirs
command! -nargs=* -bang -complete=dir RGdir call RipgrepFzf(<q-args>, <bang>0)

" function! FzfIcons()
"   let l:fzf_files_options = '--preview "bat --color always --style numbers {2..} | head -'.&lines.'"'
"    function! s:edit_devicon_prepended_file(item)
" "    let l:file_path = a:item[4:-1]
" "    execute 'silent e' l:file_path
"   endfunction
"   call fzf#run({
"         \ 'source': $FZF_DEFAULT_COMMAND . ' | devicon-lookup --color',
"         \ 'sink':   function('s:edit_devicon_prepended_file'),
"         \ 'options': '-m ' . l:fzf_files_options,
"         \ 'window': { 'width': 0.9, 'height': 0.6 }
"         \ })
" endfunction
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['rabl'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['erb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['svg'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['elm'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Gemfile'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.rspec'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['Rakefile'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['application.rb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['environment.rb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['routes.rb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['spring.rb'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.keep'] = '
" let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = '

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

" or here? https://github.com/junegunn/fzf.vim/pull/941
" function! GetProjectRoot(flags)
"   let path = finddir('.git', expand('%:p:h').';')
"   let path = fnamemodify(substitute(path, '.git', '', ''), ':p:h')
"   " e = escape: /foo bar -> /foo\ bar
"   let path = a:flags =~# 'e' ? fnameescape(path) : path
"   return path
" endfun
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

" Fzf display mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

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

" Find and Replace in all files
function! FindAndReplace( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute printf('args `rg --files-with-matches ''%s'' .`', a:1)
  execute printf('argdo %%substitute/%s/%s/g | update', a:1, a:2)
endfunction
command! -nargs=+ FindAndReplaceAll call FindAndReplace(<f-args>)

" open :e based on current file path
" noremap <Leader>h :e <C-R>=expand('%:p:h') . '/' <CR>

" " ----------------------
" "  Tilde switches -/_
" " ----------------------
" function! TildeSwitch()
"   let cursor_char = getline('.')[col('.')-1]
"   if cursor_char == '_'
"     normal! r-l
"   elseif cursor_char == '-'
"     normal! r_l
"   else
"     " If _ and - are not found, use the regular tilde.
"     normal! ~
"   endif
" endfunction
" nnoremap <silent> ~ :silent call TildeSwitch()<cr>


" startify

" disable tab name for startify, enable for all the rest
augroup StartifyTypes
  autocmd!
  autocmd FileType * set showtabline=2
  autocmd FileType startify setlocal showtabline=0
  " remap o to open
  autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
augroup END

function ConcatDevIcon(path)
  return WebDevIconsGetFileTypeSymbol(a:path) ." ". a:path
endfunction

" returns all modified files of the current git repo
function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': ConcatDevIcon(v:val), 'path': v:val}")
endfunction

" same as above, but show untracked files, honoring .gitignore
function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': ConcatDevIcon(v:val), 'path': v:val}")
endfunction

" when opening file from screen, keep vcs root as dir
let g:startify_change_to_vcs_root = 1
let g:webdevicons_enable_startify = 1
let g:startify_enable_special = 0 " don't show <empty buffer> and <quit>.
let g:startify_session_autoload = 1
let g:startify_lists = [
        \ { 'type': function('s:gitModified'),  'header': ['   git ✹modified✹']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git ✭untracked✭']},
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:ascii = [
        \ "           *     ,MMM8&&&.            *     ",
        \ "                MMMM88&&&&&    .            ",
        \ "               MMMM88&&&&&&&                ",
        \ "   *           MMM88&&&&&&&&                ",
        \ "               MMM88&&&&&&&&                ",
        \ "               'MMM88&&&&&&'                ",
        \ "                 'MMM8&&&'      *           ",
        \ "        |\\___/|                            ",
        \ "        )     (             .              '",
        \ "       =\\     /=                           ",
        \ "         )===(       *                      ",
        \ "        /     \\                            ",
        \ "        |     |                             ",
        \ "       /       \\                           ",
        \ "       \\       /                           ",
        \ "_/\\_/\\_/\\__ __/_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_/\\_",
        \ "|  |  |  |( (  |  |  |  |  |  |  |  |  |  | ",
        \ "|  |  |  | ) ) |  |  |  |  |  |  |  |  |  | ",
        \ "|  |  |  |(_(  |  |  |  |  |  |  |  |  |  | ",
        \ "|  |  |  |  |  |  |  |  |  |  |  |  |  |  | ",
        \ "|  |  |  |  |  |  |  |  |  |  |  |  |  |  | ",
        \ ]
let g:startify_custom_header = startify#center(g:ascii)

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

" beacon
let g:beacon_show_jumps = 0
let g:beacon_ignore_buffers = ["coc-explorer", "Mundo"]

" christoomey/vim-sort-motion
" make all sorts case insensitive and remove duplicates
let g:sort_motion_flags = "ui"

" add motions for words_like_this, etc
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

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
" let g:markdown_fenced_languages = ['javascript']

" trying to make markdown snippets work
" let g:vimwiki_table_mappings=0
" autocmd FileType vimwiki UltiSnipsAddFiletypes vimwiki
let g:vimwiki_global_ext = 1 " don't hijack all .md files
let g:vimwiki_listsyms = ' ○◐●✓'

" show all uncompleted todos with FZF and preview
command! -bang -nargs=* WikiTodos
         \ call fzf#vim#grep(
         \ join(['rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape('^- \[[ ]\] .+'), '~/Documents/notes']), 1,
         \ fzf#vim#with_preview(), <bang>0)

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

" find incomplete items and add to quickfix
function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

command! -bang -nargs=* SearchNotes
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': '~/Documents/notes'}), <bang>0)

command! -bang -nargs=* EditNote call fzf#vim#files('~/Documents/notes', <bang>0)

command! -bang -nargs=0 NewNote
  \ call vimwiki#base#edit_file(":e", strftime('~/Documents/notes/%F-%T.md'), "")

" map <cr> to A <cr> ?
" augroup VimwikiKeyMap
"     autocmd!
"     autocmd FileType vimwiki inoremap <silent><buffer> <CR>
"                 \ <C-]><Esc>:VimwikiReturn 3 5<CR>
" augroup end
"
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
  autocmd!
  " do not set syntax to 'vimwiki'
  autocmd BufEnter *.md setl syntax=markdown
  " automatically update links on read diary
  autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks

  autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
  autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType markdown nmap <buffer> <silent> gf <Plug>VimwikiFollowLink<CR>

  " way to check if text is in file, if not insert: https://www.reddit.com/r/vim/comments/mpww63/adding_text_when_opening_a_new_buffer/
  " delete new line at end of file: https://vi.stackexchange.com/questions/29091/exclude-trailing-newline-when-reading-in-skeleton-file
  " https://vimtricks.com/p/automated-file-templates/ or read in from file
  " au BufNewFile ~/Documents/notes/diary/*.md
  autocmd BufNewFile ~/Library/Mobile Documents/com~apple~CloudDocs/Documents/notes/diary/*.md
    \ call append(0,[
    \ "# " . split(expand('%:r'),'/')[-1], "",
    \ "***POMODORO***",
    \ "***OPEN FOCUS BAR***",
    \ "***Visible TODOs***", "",
    \ "## Daily checklist", "",
    \ "- [ ] Geekbot", "",
    \ "## Todo",  "",
    \ "## Unplanned",  "",
    \ "## Push",  "",
    \ "## Near Future",  "",
    \ "## Notes"])
augroup end
