syntax on "enable syntax highlighting
filetype plugin indent on
set shell=/usr/local/bin/zsh

set title "displays current file as vim title
set visualbell "kills the bell
set t_vb= "kills the bell

" folds
set foldcolumn=2
" Space to toggle folds.
nnoremap <space><space> za
vnoremap <space><space> za
" commands
" zf - create fold
" zd - delete folder under cursor
" zR - open all folds
" zM - close all folds

"command line completion
set wildmenu
set wildmode=longest:full,full
set wildoptions+=pum
set wildcharm=<Tab>
" nnoremap <Leader><Tab> :buffer<Space><Tab>
" give low priority to files matching the defined patterns.
" set suffixes+=.sass,.scss,.pug

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
"     autocmd!
"     autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
" augroup END

set splitright
set splitbelow
set autoread " do not prompt and reload file system changes
au FocusGained * :checktime " make it work with neovim
set hidden " allows you to abandon a buffer without saving
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
" leave tabs?
" https://github.com/ap/vim-buftabline#why-this-and-not-vim-tabs
" https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
set smartindent " Keep indentation from previous line
set breakindent
set breakindentopt=shift:2
set showbreak=↳
set expandtab " Use softtabstop spaces instead of tab characters
set softtabstop=2 " Indent by 2 spaces when pressing <TAB>
set shiftwidth=2 " Indent by 2 spaces when using >>, <<, == etc.
set showtabline=2 " always display vim tab bar
" set number " show line numbers

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

" allow tab/s-tab to filter with incsearch in-progress
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<Tab>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

" juggling with jumps
nnoremap ' `

set ignorecase
set infercase " enhances ignorecase
set smartcase
set inccommand=nosplit "highlight :s in realtime
" set completeopt+=noselect,noinsert,menuone,preview
set completeopt=menuone,noinsert,noselect,preview
set diffopt+=vertical
" allows block selections to operate across lines regardless of the underlying text
set virtualedit=block

" do not jump from item on * search
nnoremap * *``
nnoremap * m`:keepjumps normal! *``<cr>

" why do I have both of these?
let mapleader = ","
" remap leader to ,
:nmap , \

" faster keyword complete with <c-n>/<c-p>
set complete-=t " disable searching tags

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>
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
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'options': '--preview-window hidden', 'down': 20})
endfunction
nnoremap z= :call FzfSpell()<CR>

" Unhighlight search results
map <Leader><space> :nohl<cr>

 " highlight cursorline
set cursorline
" only highlight cursorline in current active buffer, when not in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" source $MYVIMRC when saving $MYVIMRC
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"sessions
" Don't save hidden and unloaded buffers in sessions
set sessionoptions-=buffers
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options
" don't restore help windows
set sessionoptions-=help

" resize panes the host window is resized
autocmd VimResized * wincmd =

" always paste from 0 register to avoid pasting deleted text
" xnoremap <silent> p p:let @"=@0<CR>
vnoremap <silent> p p:let @"=@0 <CR>
vnoremap <silent> P P:let @"=@0 <CR>
" do above unless specified?
" nnoremap <expr> p (v:register ==# '"' ? '"0' : '') . 'p'
" nnoremap <expr> P (v:register ==# '"' ? '"0' : '') . 'P'
" xnoremap <expr> p (v:register ==# '"' ? '"0' : '') . 'p'
" xnoremap <expr> P (v:register ==# '"' ? '"0' : '') . 'P'

" Indent/dedent what you just pasted
nnoremap <leader>< V`]<
nnoremap <leader>> V`]>

" Don't lose selection when shifting sidewards
" seems to remove the ability to '.'
xnoremap < <gv
xnoremap > >gv

" split windows
nnoremap <C-w>- :spl<cr>
nnoremap <C-w><bar> :vsp<cr>

" easily resize panes
" noremap <C-w>+ :resize +10<CR>
" noremap <C-w>- :resize -10<CR>
" noremap <C-w>< :vertical:resize -10<CR>
" noremap <C-w>> :vertical:resize +10<CR>

" tmux mappings for  reference
" bind -r H resize-pane -L 10
" bind -r J resize-pane -D 10
" bind -r K resize-pane -U 10
" bind -r L resize-pane -R 10
" C-a - split
" C-a | vsplit

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
nnoremap <C-w>o :call ToggleMaxWins()<cr>

" vim tab navigation
nnoremap th :tabfirst<CR>
nnoremap tj :tabprev<CR>
nnoremap tk :tabnext<CR>
nnoremap tl :tablast<CR>
nnoremap tc :tabclose<CR>
nnoremap tn :tabnew<CR>

" hide the command history buffer. Use fzf :History instead
nnoremap q: <nop>

" disable mouse
set mouse=

" keep foreground commands in sync
map fg <c-z>

" create file, in progress
" map <leader>gf :e <cfile><cr>
" map <silent> <leader>cf :!touch <c-r><c-p><cr><cr>
" map <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>
" nnoremap cgf :e <c-w><c-f><cr>

" format json
nnoremap <silent> <Leader>jj :%!python -m json.tool<CR>

" format html
nnoremap <silent> <Leader>th :%!tidy -config ~/.config/tidy_config.txt %<CR>

" remove smart quotes
" %!iconv -f utf-8 -t ascii//translit

" save with Enter *except* in quickfix buffers
" https://vi.stackexchange.com/questions/3127/how-to-map-enter-to-custom-command-except-in-quick-fix
" nnoremap <expr> <CR> &buftype ==# 'quickfix' ? '\<CR>' : ':write!<CR>'
" don't write unless changed
nnoremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? '\<CR>' : ':update<CR>'

call plug#begin('~/.config/nvim/plugged')
" if branch changes from master to main `git remote set-head origin -a` in
" `~/config/nvim/plugged/[plugin]`

" core code analysis and manipulation
Plug 'neoclide/coc.nvim', {'branch': 'release'} |
           \ Plug 'antoinemadec/coc-fzf' |
           \ Plug 'wellle/tmux-complete.vim' " coc completion from open tmux panes
let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-cssmodules',
          \ 'coc-emoji',
          \ 'coc-eslint',
          \ 'coc-git',
          \ 'coc-html',
          \ 'coc-import-cost',
          \ 'coc-jest',
          \ 'coc-jira-complete',
          \ 'coc-json',
          \ 'coc-markdownlint',
          \ 'coc-marketplace',
          \ 'coc-pairs',
          \ 'coc-prettier',
          \ 'coc-react-refactor',
          \ 'coc-snippets',
          \ 'coc-solargraph',
          \ 'coc-spell-checker',
          \ 'coc-styled-components',
          \ 'coc-stylelintplus',
          \ 'coc-svg',
          \ 'coc-tslint-plugin',
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
Plug 'jmckiern/vim-venter' " focus mode keeping status bars, etc :VenterToggle
Plug 'duff/vim-bufonly' "BuFOnfy to unload all buffers but the current one
Plug 'artnez/vim-wipeout' " :Wipeout - close all non-open buffers
Plug 'simnalamburt/vim-mundo' " undo tree visualizer
Plug 'tpope/vim-obsession' " session management

" syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" R: Refreshes the playground view when focused or reloads the query when the query editor is focused.
" o: Toggles the query editor when the playground is focused.
" a: Toggles visibility of anonymous nodes.
" i: Toggles visibility of highlight groups.
" I: Toggles visibility of the language the node belongs to.
" t: Toggles visibility of injected languages.
" f: Focuses the language tree under the cursor in the playground. The query editor will now be using the focused language.
" F: Unfocuses the currently focused language.
" <cr>: Go to current node in code buffer
" Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'
" Plug 'yuezk/vim-js'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'maxmellon/vim-jsx-pretty'
" let g:vim_jsx_pretty_colorful_config = 1
" let g:vim_jsx_pretty_highlight_close_tag = 1
" let g:vim_jsx_pretty_template_tags = ['html', 'jsx', 'js']
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'sheerun/vim-polyglot'
" let g:polyglot_disabled = ['typescript', 'javascript', 'jsx']
Plug 'styled-components/vim-styled-components', { 'branch': 'develop' }
Plug 'kkoomen/vim-doge'
"generate jsdoc: <leader>d
Plug 'Yggdroot/indentLine'
"show indentation lines
Plug 'alvan/vim-closetag'
"close html/jsx tags
Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.
Plug 'rondale-sc/vim-spacejam' "removes trailing whitespace on save
let g:spacejam_filetypes = 'ruby,javascript,vim,perl,sass,scss,css,haml,python,vimwiki,markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'godlygeek/tabular'

" movement/editing
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
"s{char}{char} motion - ; to go to next match
"dz{char}{char} - delete until
"ysz{char}{char}] - surround in ]
Plug 'christoomey/vim-sort-motion'
" gsi{
Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'christoomey/vim-tmux-navigator'
" simplify split navigation
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-system-copy'
" cp for copying and cv for pasting
" cpiw => copy word into system clipboard
" cpi' => copy inside single quotes to system clipboard
" cvi' => paste inside single quotes from system clipboard
" cP is mapped to copy the current line directly.
" cV is mapped to paste the content of system clipboard to the next line.
Plug 'tpope/vim-bundler'
"bundle bopen
Plug 'tpope/vim-commentary' "gcc comment out, gcap for paragraph
Plug 'tpope/vim-eunuch'
"Vim sugar for the UNIX shell commands
Plug 'tpope/vim-jdaddy'
"json motions
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-apathy'
"gf support
Plug 'tpope/vim-rails'
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

"wrap in console.log - yswc or yssc
autocmd FileType javascript let b:surround_{char2nr("c")} = "console.log(\r)"
autocmd FileType javascript let b:surround_{char2nr("e")} = "${\r}"
" move word under cursor up or down a line wrapped in a console.log
autocmd FileType javascript nnoremap <buffer> <leader>clO "zyiwOconsole.log(z)<Esc>
autocmd FileType javascript nnoremap <buffer> <leader>clo "zyiwoconsole.log(z)<Esc>

Plug 'tpope/vim-unimpaired'
"prev conflict/patch: [n , next conflict/patch: ]n , paste toggle: yop
Plug 'terryma/vim-expand-region'
vmap + <Plug>(expand_region_expand)
vmap - <Plug>(expand_region_shrink)
Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['javascript', 'html', 'xml', 'jsx', 'eruby', 'ejs', 'javascriptreact', 'typescriptreact']
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
Plug 'stefandtw/quickfix-reflector.vim'

" git
Plug 'tpope/vim-fugitive' |
           \ Plug 'junegunn/gv.vim' |
           \ Plug 'tpope/vim-rhubarb' | "GitHub extension for fugitive.vim

" Fugitive mapping
nmap <leader>gb :Gblame<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gc :Gcommit<cr>
" nmap <leader>gw :Gbrowse<cr> " add visual select command, also
" xnoremap <leader>gw :<c-u>call MarkCodeBlock()<CR>
xnoremap <leader>gw :<C-u>Gbrowse!
nmap <leader>gg :Ggrep

" 0Glog " see history of current file
" Gedit " go back to normal file from read-only view in Gstatus window
" <C-N> or <C-P> to jump to the next/previous file (as mentioned above)
" - on a file, stages (or unstages) the entire file.
" = shows the git diff of the file your cursor is on.
" - on a hunk, stages (or unstages) the hunk.
" - in a visual selection, stages (or unstages) the selected lines in the hunk.
" cvc - commits the staged changes in verbose mode. I like the last chance it gives me to verify the right changes have been staged, and it helps inform the commit message.
"
" :GV to open commit browser
"     You can pass git log options to the command, e.g. :GV -S foobar.
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
" :Gwrite[!] write the current file to the index and exits vimdiff mode.
Plug 'christoomey/vim-conflicted'
" `git conflicted` or `git mergetool` to open
" `:GitNextConflict` go to next file
" `dgu` - diffget from the upstream version
" `dgl` - diffget from the local version
" [c and ]c to navigate conflicts in file
Plug 'rhysd/git-messenger.vim' "git blame: <Leader>gm
" q 	Close the popup window
" o/O 	older commit/newer commit
" d/D 	Toggle diff hunks only related to current file in the commit/All Diffs
Plug 'rhysd/committia.vim' " more pleasant editing of commit message
Plug 'sodapopcan/vim-twiggy'
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'

Plug 'APZelos/blamer.nvim'
let g:blamer_enabled = 0
let g:blamer_delay = 5000
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = '|-> '
let g:blamer_template = '<author>, <committer-time> • <summary>'
let g:blamer_date_format = '%Y-%d-%m'
let g:blamer_relative_time = 1

" testing/debugging
Plug 'vim-test/vim-test'
Plug 'puremourning/vimspector'

" learning
Plug 'takac/vim-hardtime'

" visiblity
Plug 'psliwka/vim-smoothie'
Plug 'danilamihailov/beacon.nvim'
Plug 'google/vim-searchindex'
Plug 'junegunn/vim-peekaboo'
Plug 'kshenoy/vim-signature' " marks
" displays colors for words/hex
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['backgroundfull']

" appearence and insight
Plug 'preservim/nerdtree' |
          \ Plug 'Xuyuanp/nerdtree-git-plugin' |
          \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight' |
          \ Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsOS = 'Darwin'

Plug 'itchyny/lightline.vim' |
          \ Plug 'konart/vim-lightline-coc' |
          \ Plug 'timtyrrell/apprentice-lightline-experimental'
Plug 'mhinz/vim-startify'
Plug 'romainl/Apprentice'
" here for treesitter color testing
" Plug 'sainnhe/forest-night'
" Plug 'sainnhe/edge'
" Plug 'sainnhe/gruvbox-material'
" Plug 'Iron-E/nvim-highlite'
" Plug 'mhartington/oceanic-next'
Plug 'keith/investigate.vim'
let g:investigate_use_dash=1
" gK to open word in Dash
Plug 'meain/vim-package-info', { 'do': 'npm install' }
Plug 'dstein64/nvim-scrollview'
let g:scrollview_excluded_filetypes = ['nerdtree']
let g:scrollview_current_only = 1
let g:scrollview_winblend = 80

" life
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'mattn/calendar-vim'
" <Leader>cal " Brings up the calendar in a vertical split.
Plug 'alok/notational-fzf-vim'
Plug 'ferrine/md-img-paste.vim'

" trial
Plug 'kevinhwang91/rnvimr'
" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1
" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1
" Disable a border for floating window
let g:rnvimr_draw_border = 0
" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1
" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1
" Draw border with both
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine
nnoremap <silent> <leader>rt :RnvimrToggle<CR>
" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
" Add views for Ranger to adapt the size of floating window
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]
" Customize the initial layout
let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.7 * &columns)),
            \ 'height': float2nr(round(0.7 * &lines)),
            \ 'col': float2nr(round(0.15 * &columns)),
            \ 'row': float2nr(round(0.15 * &lines)),
            \ 'style': 'minimal'
            \ }
" Customize multiple preset layouts
" '{}' represents the initial layout
let g:rnvimr_presets = [
            \ {'width': 0.600, 'height': 0.600},
            \ {},
            \ {'width': 0.800, 'height': 0.800},
            \ {'width': 0.950, 'height': 0.950},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
            \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
            \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
            \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
            \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
            \ ]

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "ruby", "json", "graphql", "css", "html", "javascript", "typescript"
  },
  highlight = {
    enable = false,
    disable = { },
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
}
EOF

" set graphql filetype based on dir
autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
au BufNewFile,BufRead .eslintrc,.prettierrc,.lintstagedrc set filetype=jsonc
au BufNewFile,BufRead *.bak set filetype=javascript
au BufNewFile,BufRead *.build,.env* set filetype=sh
" how to automatically rename things based on filetype
autocmd BufWritePre *.js exec "%s/class=/className=/eg"
" styles.something-blah -> styles[something-blah]
" :%s/styles[\S\+\]/
" /styles[\[a-zA-Z0-9].\+?(?=dir)/
" autocmd BufWritePre *.js exec "%s/class=/className=/eg"

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
" let g:peekaboo_window='vertical botright 50new'
let g:peekaboo_delay='1000' " delay 1000ms
let g:peekaboo_window="call CreateCenteredFloatingWindow()"
" let g:peekaboo_prefix="<F12>"
" let g:peekaboo_ins_prefix="<F12>"

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

autocmd VimEnter * call OnVimEnter()

" Press gx to open the GitHub URL for a plugin or a commit with the default browser.
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

augroup PlugGx
 autocmd!
 autocmd FileType vim-plug nnoremap <buffer> <silent> o :call <sid>plug_gx()<cr>
augroup end

" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! MyHighlights() abort
  " match codelens to Comment color so it stands out less
  highlight CocCodeLens guifg=#585858
  " Overwrite the highlight groups `CocHighlightText`, `CocHighlightRead` and `CocHighlightWrite` for customizing the colors.
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

let base16colorspace=256
set background=dark
set termguicolors
colorscheme apprentice

" hide line showing switch in insert/normal mode
set noshowmode
set noruler

let g:projectionist_heuristics = {
    \"package.json": {
    \  "*.js": {
    \    "alternate": "{dirname}/__tests__/{basename}.test.js",
    \    "type": "source"
    \  },
    \  "package.json" : { "alternate": "package-lock.json" },
    \  "package-lock.json" : { "alternate": "package.json" },
    \},
    \"src/*.js": {
    \    "type": "component",
    \    "alternate": [
    \        "src/{}.scss",
    \        "src/{dirname}/__tests__/{basename}.test.js"
    \    ]
    \},
    \"src/**/__tests__/*.test.js": {
    \    "type": "test",
    \    "alternate": "src/{}.js"
    \},
    \"src/*.module.scss": {
    \    "type": "styles"
    \}
\ }

" let g:projectionist_heuristics = {
" \  'package.json': {
" \    'src/components/*.js': {
" \      'type': 'component',
" \      'alternate': 'src/__tests__/components/{}.test.js'
" \    },
" \    'src/__tests__/components/*.test.js': {
" \      'type': 'test',
" \      'alternate': 'src/components/{}.js'
" \    },
" \  }
" \}
" nnoremap <Leader>ec :Ecomponent<Space>
" nnoremap <Leader>es :Estylesheet<Space>
" nnoremap <leader>et :Etest<Space>
" nnoremap <Leader>a  :A<CR>

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
    \   'lineinfo': '%3l  %-2c',
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
  return winwidth(0) > 40 ? WebDevIconsGetFileTypeSymbol() . ' '. LightlineFilename() : expand('%:t')
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
    \ l:fname =~ 'NERD_tree' ? '' :
    \ l:fname =~ 'FZF' ? '' :
    \ l:fname =~ '\[coc-explorer\]-' ? 'Explorer' :
    \ l:fname =~ '\[Plugins\]' ? 'Plugins' :
    \ ('' != l:fname ? l:fname : '')
endfunction

function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineBranchformat()
  try
    if expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
      let mark = ' '
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
" return winwidth(0) > 70 ? FugitiveHead() : ''
endfunction

let g:lightline.colorscheme = 'apprentice'

" register compoments:
call lightline#coc#register()

let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = ['debugger-for-chrome', 'force-enable-node']
nmap <leader>vc <Plug>VimspectorContinue
nmap <leader>vs <Plug>VimspectorStop
" <Plug>VimspectorRestart
" <Plug>VimspectorPause
" <Plug>VimspectorToggleBreakpoint
" <Plug>VimspectorToggleConditionalBreakpoint
" <Plug>VimspectorAddFunctionBreakpoint
" <Plug>VimspectorStepOver
" <Plug>VimspectorStepInto
" <Plug>VimspectorStepOut
" <Plug>VimspectorRunToCursor

let g:closetag_filetypes = 'html,xhtml,jsx,javascript'
let g:closetag_emptyTags_caseSensitive = 1

let g:vim_jsx_pretty_colorful_config = 1

let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
let g:git_messenger_extra_blame_args ='-w' " Ignore whitespace

" vim-doge
let g:javascript_plugin_jsdoc = 1

" DEFAULT COC.NVIM START

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" leave space for git, diagnostics and marks
set signcolumn=auto:3

" use C-j, C-k to move in
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup CocGroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Applying codeAction to the selected region. Ex: `<leader>aap` for current paragraph
" I have no idea why <leader> will not work here.....
vmap ,a <Plug>(coc-codeaction-selected)
nmap ,a <Plug>(coc-codeaction-selected)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <leader>cl <Plug>(coc-codelens-action)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" DEFAULT COC.NVIM END

" restart when coc gets wonky
nnoremap <silent> <leader>cr :<C-u>CocRestart<CR>

" COC.SNIPPET START

set pumheight=20 " max items to show in popup list
" close preview when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" make sure to kill coc pid when closing nvim (not sure if needed)
autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
		\	| call system('kill -9 '.g:coc_process_pid) | endif

let g:coc_snippet_next = '<tab>'
" let g:coc_node_path = '/usr/local/bin/node' " use node v14?
" COC.SNIPPET END

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'

nnoremap <silent><nowait> <space>a :<C-u>CocFzfList actions<CR>
" nnoremap <silent><nowait> <space><space> :<C-u>CocFzfList<CR>
" nnoremap <silent><nowait> <space>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <space>b :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> <space>c :<C-u>CocFzfList commands<CR>
nnoremap <silent><nowait> <space>e :<C-u>CocFzfList extensions<CR>
nnoremap <silent><nowait> <space>l :<C-u>CocFzfList location<CR>
nnoremap <silent><nowait> <space>o :<C-u>CocFzfList outline<CR>
nnoremap <silent><nowait> <space>s :<C-u>CocFzfList symbols<CR>
nnoremap <silent><nowait> <space>S :<C-u>CocFzfList services<CR>
nnoremap <silent><nowait> <space>p :<C-u>CocFzfListResume<CR>
nnoremap <silent><nowait> <space>y :<C-u>CocFzfList yank<CR>

" Start multiple cursors session
" nmap <silent> <C-c> <Plug>(coc-cursors-position)
" nmap <silent> <C-d> <Plug>(coc-cursors-word)
" xmap <silent> <C-d> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" nmap <leader>x  <Plug>(coc-cursors-operator)

" nmap <expr> <silent> <C-d> <SID>select_current_word()
" function! s:select_current_word()
"   if !get(g:, 'coc_cursors_activated', 0)
"     return "\<Plug>(coc-cursors-word)"
"   endif
"   return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfun

" NERDTree configuration
let g:NERDTreeIgnore=['\~$', 'tmp', '.git$', '.bundle', '.DS_Store', '.swp', '.git-blame-ignore-revs', '.vim']
let g:NERDTreeShowHidden=1
" let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeMinimalUI = 1
" delete buffer of file deleted with NerdTree
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusline = ''
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeMinimalMenu=1

" map <silent> <Leader>nt :NERDTreeToggle<CR>:wincmd =<CR>
nnoremap <silent> <Leader><Tab> :NERDTreeToggle<CR>:wincmd =<CR>
map <Leader>nf :NERDTreeFind<CR>
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" tiagofumo/vim-nerdtree-syntax-highlight
let g:NERDTreeLimitedSyntax = 1 " decrease font lag
" for more options: https://github.com/tiagofumo/vim-nerdtree-syntax-highlight#mitigating-lag-issues

" NERDtreeGit
let g:NERDTreeGitStatusUseNerdFonts = 1

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
map <Leader>ff :Files<CR>
map <silent> <Leader>fp :call fzf#vim#files('', { 'source': g:FzfFilesSource(), 'options': '--tiebreak=index'})<CR>
map <Leader>fb :Buffers<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
map <Leader>fe :Rg<CR>
map <Leader>fl :Lines<CR>
map <Leader>fc :BLines<CR>
map <Leader>fh :HistoryCmds<CR>
map <Leader>fH :History<CR>
map <Leader>fS :HistorySearch<CR>
map <Leader>fg :GFiles?<CR>
map <Leader>fC :BCommits<CR>
" start search from current dir
nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>
" Rg current word
nnoremap <silent> <Leader>rg :Lines <C-R><C-W><CR>

command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))

" do not search filename, just file contents
command! -bang -nargs=* Lines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..', '--color', 'hl:123,hl+:222'] }), <bang>0)

command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')

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
noremap <Leader>h :e <C-R>=expand("%:p:h") . "/" <CR>

" open markdown preview when entering file
let g:mkdp_auto_start = 0 ":MarkdownPreview

"""""""" coc-jest
" Run jest for current project
command! -nargs=0 Jest :call  CocActionAsync('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocActionAsync('runCommand', 'jest.fileTest', ['%'])
" Init jest in current cwd, require global jest command exists
command! JestInit :call CocActionAsync('runCommand', 'jest.init')

" Run jest for current file
nnoremap <leader>tf :JestCurrent <CR>
" Run jest for current test
nnoremap <leader>tt :call CocAction('runCommand', 'jest.singleTest')<CR>
"""""""" coc-jest

"""""""" vim-test
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
"""""""" vim-test

" startify

" disable tab name for startify, enable for all the rest
augroup StartifyTypes
  autocmd!
  autocmd FileType * set showtabline=2
  autocmd FileType startify setlocal showtabline=0
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

" remap o to open
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)

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
let g:beacon_ignore_buffers = ["NERD.*", "Mundo"]

" vim-hardtime
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 1
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_maxcount = 2

" christoomey/vim-sort-motion
" make all sorts case insensitive and remove duplicates
let g:sort_motion_flags = "ui"

" yggdroot/indentline
let g:indentLine_faster = 1
" let g:indentLine_setConceal = 1
let g:indentLine_fileTypeExclude = ['startify']
let g:indentLine_char_list = ['┊']

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

" vimwiki & friends

let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vimwiki_hl_headers = 1 " highlight headers with different colors
let g:vimwiki_hl_cb_checked = 2 " highlight completed tasks and line

" trying to make markdown snippets work
" let g:vimwiki_table_mappings=0
" autocmd FileType vimwiki UltiSnipsAddFiletypes vimwiki
au BufEnter *.md setl syntax=markdown " do not set syntax to 'vimwiki'
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

nmap <Leader>wv :NV!<CR>
nmap <Leader>wl :SearchNotes<CR>
nmap <Leader>wdn <Plug>VimwikiMakeDiaryNote
nmap <Leader>wdy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>wdt <Plug>VimwikiMakeTomorrowDiaryNote
" nmap <Leader>wp :Files ~/Documents/notes/<CR>

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

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType markdown nmap <buffer> <silent> gf <Plug>VimwikiFollowLink<CR>
" autocmd Filetype purescript nmap <buffer> <silent> K :Ptype<CR>
" nnoremap o o<Esc> nnoremap O O<Esc>
" nnoremap <buffer> o o<esc>
" nnoremap <buffer> O O<esc>

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
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end

" try these out?
" nnoremap <leader>wf :FilesWithPreview ~/Dropbox/vimwiki/md<cr>
" nnoremap <leader>wF :call VimWikiLines()<cr>
" nnoremap <leader>wF :call fzf#vim#grep('rg --column --line-number --no-heading --color=always . ~/Documents/notes \| tr -d "\017"', 1, 0)<cr>

" command! -bang -nargs=? -complete=dir FilesWithPreview
"       \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" command! -nargs=+ WriteWikiNote call s:writeWikiNote(<q-args>)
" func! s:writeWikiNote(filename)
"   let l:writePath = '~/Documents/notes/' . a:filename . '.md'
"   exec ':save ' . expand(l:writePath)
" endfunc
" func! VimWikiLines()
"   " load all vimwiki notes
"   for l:filename in split(expand('~/Documents/notes/*'), '\n')
"     exec 'badd '.l:filename
"   endfor
"   Lines
" endfunc

au BufNewFile ~/Documents/notes/*.md
      \ call append(0,[
      \ "# " . split(expand('%:r'),'/')[-1], "",
      \ "## Daily checklist", "",
      \ "## Todo",  "",
      \ "## Notes", "" ])
