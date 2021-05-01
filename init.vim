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
" zd - delete fold under cursor
" zR - open all folds
" zM - close all folds
"
" treesitter
" set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"command line completion
set wildmenu
set wildmode=longest:full,full
" not as nice looking but selects first option
" set wildmode=longest:list,full
set wildoptions=pum
" set wildoptions+=pum
" Enables pseudo-transparency for the popup-menu, 0-100
set pumblend=15
set wildcharm=<Tab>
" set completeopt+=noselect,noinsert,menuone,preview
set completeopt=menuone,noinsert,noselect,preview

" give low priority to files matching the defined patterns.
" set suffixes+=.sass,.scss,.pug
" TODO test
" give low priority to files matching the defined patterns.
set suffixes+=yarn.lock,package-lock.json,.scss,.sass,.pug,.min.js

" why do I have both of these?
let mapleader = ","
" remap leader to ,
:nmap , \

" nnoremap <Leader><Tab> :buffer<Space><Tab>
" nnoremap <silent> <c-n> :bnext<CR>
" nnoremap <silent> <c-p> :bprev<CR>
" nnoremap <silent> <c-x> :bdelete<CR>

" vim tab navigation
" Next tab: gt
" Prior tab: gT
" Numbered tab: nnngt
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
"     autocmd!
"     autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
" augroup END

set splitright
set splitbelow
set autoread " do not prompt and reload file system changes
au FocusGained * :checktime " make it work with neovim
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

" allow tab/s-tab to filter with incsearch in-progress
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>" : "<Tab>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

" Make <C-p>/<C-n> act like <Up>/<Down> in cmdline mode, so they can be used to navigate history with partially completed commands
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" juggling with jumps
nnoremap ' `

set ignorecase
set infercase " enhances ignorecase
set smartcase
set inccommand=nosplit "highlight :s in realtime
set diffopt+=vertical
" allows block selections to operate across lines regardless of the underlying text
set virtualedit=block

" do not jump from item on * search
" nnoremap * *``
" nnoremap * m`:keepjumps normal! *``<cr>

" faster keyword complete with <c-n>/<c-p>
set complete-=t " disable searching tags
nnoremap <silent><leader>v :call execute('source $MYVIMRC')<cr>:echo "vim config reloaded!"<cr>

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
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'options': '--preview-window hidden', 'down': 20})
endfunction
nnoremap z= :call FzfSpell()<CR>

" Unhighlight search results
map <Leader><space> :nohl<cr>

 " highlight cursorline
set cursorline
set equalalways
" only highlight cursorline in current active buffer, when not in insert mode
augroup ALL_MY_WEIRD_AUTO_COMMANDS
  au!
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

" Don't lose selection when shifting sidewards
"*** seems to remove the ability to '.' ***
" xnoremap < <gv
" xnoremap > >gv

" move lines up and down in visual mode
"xnoremap <c-k> :move '<-2<CR>gv=gv
"xnoremap <c-j> :move '>+1<CR>gv=gv

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
" map <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>
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
" cabbrev q! use ZQ
" cabbrev wq use x or ZZ
" cabbrev wq! use x!
" cabbrev wqa use xa
" cabbrev wqa! use xa!

call plug#begin('~/.config/nvim/plugged')
" if branch changes from master to main `git remote set-head origin -a` in
" `~/config/nvim/plugged/[plugin]`

" =============== RECOVERY
"Plug 'antoinemadec/FixCursorHold.nvim'

"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"Plug 'ThePrimeagen/git-worktree.nvim'
"Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}

"Plug 'nacro90/numb.nvim'
"require('numb').setup()

"Plug 'kevinhwang91/nvim-bqf'
"Plug 'mfussenegger/nvim-dap'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'theHamsta/nvim-dap-virtual-text'
"Plug 'kevinhwang91/nvim-hlslens'
"Plug 'JoosepAlviste/nvim-ts-context-commentstring'

"Plug 'pwntester/octo.nvim'
"Plug 'nvim-lua/popup.nvim'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'

"-- To use Telescope interface for octo pickers
"lua require('telescope').load_extension('octo')


"Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
"nmap <leader>ff <Plug>SnipRun
"nmap <leader>f <Plug>SnipRunOperator
"vmap f <Plug>SnipRun
"require'sniprun'.setup({
"  selected_interpreters = {},     --" use those instead of the default for the current filetype
"  repl_enable = {},               --" enable REPL-like behavior for the given interpreters
"  repl_disable = {},              --" disable REPL-like behavior for the given interpreters

"  inline_messages = 0             --" inline_message (0/1) is a one-line way to display messages
"                                  --" to workaround sniprun not being able to display anything

"  -- " you can combo different display modes as desired
"  display = {
"    'Classic',                    -- "display results in the command-line  area
"    'VirtualTextOk',              -- "display ok results as virtual text (multiline is shortened)
"    -- 'VirtualTextErr',          -- "display error results as virtual text
"    -- 'TempFloatingWindow',      -- "display results in a floating window
"    -- 'LongTempFloatingWindow',  -- "same as above, but only long results. To use with VirtualText__
"    -- 'Terminal'                 -- "display results in a vertical split
"    },

"})
"EOF

"Plug 'nvim-telescope/telescope-dap.nvim'

"Plug 'tpope/vim-abolish'

"Plug 'mlaursen/vim-react-snippets', { 'branch': 'main' }

"Plug 'airblade/vim-rooter'



"Plug '/tokyonight.nvim'
"Plug '/vim-table-mode'
"check dup plugins in file

" core code analysis and manipulation
Plug 'neoclide/coc.nvim', {'branch': 'release'} |
           \ Plug 'antoinemadec/coc-fzf' |
           \ Plug 'wellle/tmux-complete.vim' " coc completion from open tmux panes
let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-cssmodules',
          \ 'coc-emoji',
          \ 'coc-eslint',
          \ 'coc-explorer',
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
Plug 'mfussenegger/nvim-dap'

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
let g:polyglot_disabled = [
        \ "bash", "comment", "css", "graphql",
        \ "html", "javascript", "jsdoc", "json",
        \ "jsonc", "lua", "regex", "ruby", "tmux", "tsx", "typescript"]
            " \ 'c', 'html', 'javascript',
            " \ 'markdown.plugin', 'ruby', 'typescript', 'tmux'
            " \]
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'theHamsta/nvim-dap-virtual-text'
" Plug 'haringsrob/nvim_context_vt' " Add virtual text to show current context
Plug 'lukas-reineke/indent-blankline.nvim', {'branch': 'lua'}
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
let g:indent_blankline_buftype_exclude = []
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_show_current_context = v:false

autocmd FileType tmux nnoremap <silent><buffer> K :call tmux#man()<CR>
Plug 'tmux-plugins/vim-tmux'
Plug 'sheerun/vim-polyglot', { 'tag': 'v4.16.0' }
" let g:polyglot_disabled = ['typescript', 'javascript', 'jsx']
Plug 'styled-components/vim-styled-components', { 'branch': 'develop' }
Plug 'kkoomen/vim-doge'
"generate jsdoc: <leader>d " CURRENTLY DISABLED
Plug 'alvan/vim-closetag'
"close html/jsx tags
Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.
Plug 'rondale-sc/vim-spacejam' "removes trailing whitespace on save
let g:spacejam_filetypes = 'ruby,javascript,vim,perl,sass,scss,css,haml,python,vimwiki,markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}
" markdown preview in nvim popup
" nmap <leader>p :Glow<CR>
" q to quit, :Glow for current filepath
Plug 'godlygeek/tabular'
" Tabularize /,
"
Plug 'dhruvasagar/vim-table-mode'
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

" movement/editing
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1 " s/S to do to next. ;, still works, also
" replace fFtT with 1 character sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"s{char}{char} motion - ; to go to next match
"dz{char}{char} - delete until
"ysz{char}{char}] - surround in ]
Plug 'christoomey/vim-sort-motion'
" gsi{
Plug 'drmingdrmer/vim-toggle-quickfix'
Plug 'kevinhwang91/nvim-bqf'
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

" https://github.com/mlaursen/vim-react-snippets#cheatsheet
Plug 'mlaursen/vim-react-snippets', { 'branch': 'main' }
Plug 'nacro90/numb.nvim'

Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
nmap <leader>snr <Plug>SnipRun
" nmap <leader>sn <Plug>SnipRunOperator
vmap sn <Plug>SnipRun
nmap <leader>snc <Plug>SnipClose

" git
Plug 'tpope/vim-fugitive' |
           \ Plug 'junegunn/gv.vim' |
           \ Plug 'tpope/vim-rhubarb' | "GitHub extension for fugitive.vim

" :GV to open commit browser
"     You can pass git log options to the command, e.g. :GV -S foobar -- plugins.
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
" :GV or :GV? can be used in visual mode to track the changes in the selected lines.
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
nnoremap <Leader>gaf :Gw<CR> " git add file
" Open visual selection in the browser
vnoremap <Leader>Gb :GBrowse<CR>
" Open current line in the browser
nnoremap <Leader>GB :.GBrowse<CR>
" 0Glog " see history of current file
" Gedit " go back to normal file from read-only view in Gstatus window
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
Plug 'christoomey/vim-conflicted'
" `git conflicted` or `git mergetool` to open
" `:GitNextConflict` go to next file
" `dgu` - diffget from the upstream version
" `dgl` - diffget from the local version
" [c and ]c to navigate conflicts in file

" disable showing '------' for empty line in difftool
" I want to set it as a blank space but space-jam deletes the space....
" set fillchars=diff:\

Plug 'rhysd/git-messenger.vim' "git blame: <Leader>gm
" q 	Close the popup window
" o/O 	older commit/newer commit
" d/D 	Toggle diff hunks only related to current file in the commit/All Diffs
Plug 'rhysd/committia.vim' " more pleasant editing of commit message
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

Plug 'APZelos/blamer.nvim'
let g:blamer_enabled = 0
let g:blamer_delay = 5000
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = '|-> '
let g:blamer_template = '<author>, <committer-time> • <summary>'
let g:blamer_date_format = '%Y-%d-%m'
let g:blamer_relative_time = 1

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
" https://github.com/pwntester/octo.nvim
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'pwntester/octo.nvim'
" https://levelup.gitconnected.com/git-worktrees-the-best-git-feature-youve-never-heard-of-9cd21df67baf
Plug 'ThePrimeagen/git-worktree.nvim'

Plug 'chrisbra/unicode.vim'
let g:Unicode_ShowPreviewWindow = 1
let g:Unicode_CompleteName = 1

" testing/debugging
Plug 'vim-test/vim-test'
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

Plug 'google/vim-searchindex'
Plug 'junegunn/vim-peekaboo'
" spacebar toggle full screen
Plug 'kshenoy/vim-signature' " marks
" displays colors for words/hex
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
let g:Hexokinase_highlighters = ['backgroundfull']
" opens Mac color picker
Plug 'KabbAmine/vCoolor.vim'
nnoremap <leader>cp :VCoolor<CR>

" appearence and insight
Plug 'ryanoasis/vim-devicons'
let g:WebDevIconsOS = 'Darwin'

Plug 'itchyny/lightline.vim' |
          \ Plug 'konart/vim-lightline-coc' |
          \ Plug 'timtyrrell/apprentice-lightline-experimental'
Plug 'mhinz/vim-startify'
Plug 'romainl/Apprentice'
Plug 'folke/tokyonight.nvim'
" here for treesitter color testing
" Plug 'christianchiarulli/nvcode-color-schemes.vim'
" let g:nvcode_termcolors=256
" Plug 'sainnhe/forest-night'
" Plug 'sainnhe/edge'
" Plug 'sainnhe/gruvbox-material'
" Plug 'Iron-E/nvim-highlite'
" Plug 'mhartington/oceanic-next'
Plug 'keith/investigate.vim'
let g:investigate_use_dash=1
" gK to open word in Dash
Plug 'meain/vim-package-info', { 'do': 'npm install' }
" monorepo
Plug 'airblade/vim-rooter'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
nnoremap <leader>go :Goyo<CR>
" let g:goyo_width (default: 80)
" let g:goyo_height (default: 85%)
" let g:goyo_linenr (default: 0)

" life
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'mattn/calendar-vim'
" <Leader>cal " Brings up the calendar in a vertical split.
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

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" learning
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0
let g:hardtime_showmsg = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "w", "b", "W", "B"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
let g:hardtime_ignore_quickfix = 1
" let g:hardtime_ignore_buffer_patterns = []
let g:hardtime_maxcount = 2

" bugfix
" fix CursorHold perf bug
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

" *************** firenvim
" function! s:IsFirenvimActive(event) abort
"   if !exists('*nvim_get_chan_info')
"     return 0
"   endif
"   let l:ui = nvim_get_chan_info(a:event.chan)
"   return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
"       \ l:ui.client.name =~? 'Firenvim'
" endfunction

" function! SetLinesForBrowser(timer)
"     set lines=28 columns=110 laststatus=0
" endfunction

" function! OnUIEnter(event) abort
"   if s:IsFirenvimActive(a:event)
"     au TextChanged * ++nested call Delay_My_Write()
"     au TextChangedI * ++nested call Delay_My_Write()
"     " set lines=40
"     set guifont=Fira_Code:h20
"     call timer_start(1000, function("SetLinesForBrowser"))
"   endif
" endfunction

" autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
" let g:dont_write = v:false

" function! My_Write(timer) abort
"   let g:dont_write = v:false
"   write
" endfunction

" function! Delay_My_Write() abort
"   if g:dont_write
"     return
"   end
"   let g:dont_write = v:true
"   call timer_start(10000, 'My_Write')
" endfunction

" let l:bufname=expand('%:t')
" if l:bufname =~? 'github.com'
"   set ft=markdown
" elseif l:bufname =~? 'reddit.com'
"   set ft=markdown
" elseif l:bufname =~? 'stackexchange.com' || l:bufname =~? 'stackoverflow.com'
"   set ft=markdown
" elseif l:bufname =~? 'slack.com' || l:bufname =~? 'gitter.com'
"   set ft=markdown
" endif
" *************** firenvim

lua << EOF
require('telescope').load_extension('octo')
require("telescope").load_extension("git_worktree")
require('telescope').load_extension('dap')
local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- https://github.com/nvim-telescope/telescope.nvim/blob/d0cf646f65746415294f570ec643ffd0101ca3ab/lua/telescope/mappings.lua
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  }
}

require('numb').setup{
   show_numbers = true, -- Enable 'number' for the window while peeking
   show_cursorline = true -- Enable 'cursorline' for the window while peeking
}

require'sniprun'.setup({
  display = {
    "VirtualTextOk",              -- "display ok results as virtual text (multiline is shortened)
    "VirtualTextErr",          -- "display error results as virtual text
    -- "TempFloatingWindow",      -- "display results in a floating window
    "LongTempFloatingWindow",  -- "same as above, but only long results. To use with VirtualText__
    "Terminal"                 -- "display results in a vertical split
  },
})
-- require('hlslens').setup({
--     override_lens = function(render, plist, nearest, idx, r_idx)
--         local sfw = vim.v.searchforward == 1
--         local indicator, text, chunks
--         local abs_r_idx = math.abs(r_idx)
--         if abs_r_idx > 1 then
--             indicator = ('%d%s'):format(abs_r_idx, sfw ~= (r_idx > 1) and '
-- ' or '
--         elseif abs_r_idx == 1 then
--             indicator = sfw ~= (r_idx == 1) and '
-- ' or '
--         else
--             indicator = ''
--         end
--         local lnum, col = unpack(plist[idx])
--         if nearest then
--             local cnt = #plist
--             if indicator ~= '' then
--                 text = ('[%s %d/%d]'):format(indicator, idx, cnt)
--             else
--                 text = ('[%d/%d]'):format(idx, cnt)
--             end
--             chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensNear'}}
--         else
--             text = ('[%s %d]'):format(indicator, idx)
--             chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
--         end
--         render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
--     end
-- })
-- require('gitsigns').setup()

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
-- vim.g.tokyonight_style = "storm" -- storm, night, day
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_italic_variables = true
-- vim.g.tokyonight_dark_sidebar = true
-- vim.g.tokyonight_sidebars = { "coc-explorer" }
EOF

" Make it so that if files are changed externally (ex: changing git branches) update the vim buffers automatically
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" if highlighting on big files is bad, can do similiar:
" autocmd FileType typescript syntax sync ccomment minlines=1500

" set graphql filetype based on dir
" open bug https://github.com/nvim-treesitter/nvim-treesitter/issues/1249
au! BufRead,BufNewFile *.json set filetype=jsonc

autocmd BufRead,BufNewFile */schema/*.js set syntax=graphql
autocmd BufRead,BufNewFile */graphql/queries/*.js set syntax=graphql
au BufNewFile,BufRead .eslintrc,.prettierrc,.lintstagedrc set filetype=jsonc
au BufNewFile,BufRead *.bak set filetype=javascript
au BufNewFile,BufRead *.build,.env* set filetype=sh

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

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

autocmd VimEnter * call OnVimEnter()

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

function! VimAwesomeComplete() abort
  let prefix = matchstr(strpart(getline('.'), 0, col('.') - 1), '[.a-zA-Z0-9_/-]*$')
  echohl WarningMsg
  echo 'Downloading plugin list from VimAwesome'
  echohl None
ruby << EOF
  require 'json'
  require 'open-uri'

  query = VIM::evaluate('prefix').gsub('/', '%20')
  items = 1.upto(max_pages = 3).map do |page|
    Thread.new do
      url  = "http://vimawesome.com/api/plugins?page=#{page}&query=#{query}"
      data = URI.open(url).read
      json = JSON.parse(data, symbolize_names: true)
      json[:plugins].map do |info|
        pair = info.values_at :github_owner, :github_repo_name
        next if pair.any? { |e| e.nil? || e.empty? }
        {word: pair.join('/'),
         menu: info[:category].to_s,
         info: info.values_at(:short_desc, :author).compact.join($/)}
      end.compact
    end
  end.each(&:join).map(&:value).inject(:+)
  VIM::command("let cands = #{JSON.dump items}")
EOF
  if !empty(cands)
    inoremap <buffer> <c-v> <c-n>
    augroup _VimAwesomeComplete
      autocmd!
      autocmd CursorMovedI,InsertLeave * iunmap <buffer> <c-v>
            \| autocmd! _VimAwesomeComplete
    augroup END

    call complete(col('.') - strchars(prefix), cands)
  endif
  return ''
endfunction

augroup VimAwesomeComplete
  autocmd!
  autocmd FileType vim inoremap <c-x><c-v> <c-r>=VimAwesomeComplete()<cr>
augroup END

" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! MyHighlights() abort
  if g:colors_name ==# 'apprentice'
    " match codelens to Comment color so it stands out less
    hi CocCodeLens guifg=#585858
    " hi MatchParen ctermbg=234 ctermfg=229 cterm=NONE guibg=#1c1c1c guifg=#ffffaf gui=NONE
    hi MatchParen cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guifg=#262626 guibg=#87af87 gui=reverse
    hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guifg=#262626 guibg=#af5f5f gui=reverse
    hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guifg=#262626 guibg=#8787af gui=reverse
    hi LineNr ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    hi SignColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    hi FoldColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE
    hi Folded ctermbg=234 ctermfg=242 cterm=NONE guibg=#262626 guifg=#6c6c6c gui=NONE

    " 'kshenoy/vim-signature'
    hi SignatureMarkText guibg=#262626

    " 'kevinhwang91/nvim-hlslens'
    hi HlLens guifg=#585858
    hi HlHighlight guifg=#ff8700
    hi default link HlSearchNear IncSearch
    hi default link HlSearchLens HlLens
    hi default link HlSearchLensNear IncSearch
    hi default link HlSearchFloat IncSearch

    " Overwrite the highlight groups `CocHighlightText`, `CocHighlightRead` and `CocHighlightWrite` for customizing the colors.
    hi CocHighlightText cterm=reverse ctermfg=110 ctermbg=235 gui=reverse guifg=#87afd7 guibg=#262626
    " highlight CocHighlightText term=underline cterm=underline gui=underline
    " highlight CursorLine gui=underline cterm=underline ctermfg=None guifg=None
  end
  " if &filetype ==# 'coc-explorer'
    " autocmd WinEnter * call Handle_Win_Enter()
    " setlocal winhighlight=Normal:Potato
  " endif
  " overwrite floating coc-explorer group
  " highlight link CocExplorerNormalFloat Normal
  " treesitter
  " highlight TSConstructor guifg=#9CDCFE
  " highlight TSVariable guifg=#9CDCFE
  " highlight TSVariableBuiltin guifg=#9CDCFE
  " highlight Special guifg=#9CDCFE
  " TSNone         xxx ctermfg=250 guifg=foreground
  " TSPunctDelimiter xxx links to Delimiter
  " TSPunctBracket xxx links to Delimiter
  " TSPunctSpecial xxx links to Delimiter
  " TSConstant     xxx links to Constant
  " TSConstBuiltin xxx links to Special
  " TSConstMacro   xxx links to Define
  " TSString       xxx links to String
  " TSStringRegex  xxx links to String
  " TSStringEscape xxx links to SpecialChar
  " TSCharacter    xxx links to Character
  " TSNumber       xxx links to Number
  " TSBoolean      xxx links to Boolean
  " TSFloat        xxx links to Float
  " TSFunction     xxx links to Function
  " TSFuncBuiltin  xxx links to Special
  " TSFuncMacro    xxx links to Macro
  " TSParameter    xxx links to Identifier
  " TSParameterReference xxx links to TSParameter
  " TSMethod       xxx links to Function
  " TSField        xxx links to Identifier
  " TSProperty     xxx links to Identifier
  " TSConstructor  xxx links to Special
  " TSAnnotation   xxx links to PreProc
  " TSAttribute    xxx links to PreProc
  " TSNamespace    xxx links to Include
  " TSSymbol       xxx links to Identifier
  " TSConditional  xxx links to Conditional
  " TSRepeat       xxx links to Repeat
  " TSLabel        xxx links to Label
  " TSOperator     xxx links to Operator
  " TSKeyword      xxx links to Keyword
  " TSKeywordFunction xxx links to Keyword
  " TSKeywordOperator xxx links to TSOperator
  " TSException    xxx links to Exception
  " TSType         xxx links to Type
  " TSTypeBuiltin  xxx links to Type
  " TSInclude      xxx links to Include
  " TSVariableBuiltin xxx links to Special
  " TSText         xxx links to TSNone
  " TSStrong       xxx cterm=bold gui=bold
  " TSEmphasis     xxx cterm=italic gui=italic
  " TSUnderline    xxx cterm=underline gui=underline
  " TSStrike       xxx cterm=strikethrough gui=strikethrough
  " TSTitle        xxx links to Title
  " TSLiteral      xxx links to String
  " TSURI          xxx links to Underlined
  " TSNote         xxx links to SpecialComment
  " TSWarning      xxx links to Todo
  " TSDanger       xxx links to WarningMsg
  " TSTag          xxx links to Label
  " TSTagDelimiter xxx links to Delimiter
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
                \ '\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK)>'
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
set background=dark
" might as well play it safe, kids
if has("termguicolors")
  set termguicolors
endif
colorscheme apprentice
" colorscheme tokyonight
" colorscheme dracula
" colorscheme nord
" colorscheme aurora
" colorscheme gruvbox
" colorscheme OceanicNext
" colorscheme highlite

" hide line showing switch in insert/normal mode
set noshowmode
set noruler


let g:projectionist_heuristics = {}
let g:projectionist_heuristics['package.json'] = {
  \   '*.js': {
  \     'alternate': [
  \       '{dirname}/{basename}.test.js',
  \       '{dirname}/__tests__/{basename}.test.js',
  \       '{dirname}/{basename}.module.scss',
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
  \       '{dirname}/__tests__/{basename}.test.ts',
  \       '{dirname}/__tests__/{basename}.test.tsx',
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
  \       '{dirname}/__tests__/{basename}.test.ts',
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

" mfussenegger/nvim-dap
lua << EOF
local dap = require('dap')
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
  }
  vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>d_ :lua require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover(function () return vim.fn.expand("<cexpr>") end)<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>da :lua require'debugHelper'.attach()<CR>

" theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
let g:dap_virtual_text = v:true

" jank/vim-test and mfussenegger/nvim-dap
nnoremap <leader>dd :TestNearest -strategy=jest<CR>
function! JestStrategy(cmd)
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
  call luaeval("require'debugHelper'.debugJest([[" . testName . "]], [[" . fileName . "]])")
endfunction
let g:test#custom_strategies = {'jest': function('JestStrategy')}

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

" let g:closetag_filetypes = 'html,xhtml,jsx,javascript'
let g:closetag_filenames='*.html,*.js,*.jsx,*.tsx'
let g:closetag_regions = {
     \ 'typescript': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_emptyTags_caseSensitive = 1

let g:vim_jsx_pretty_colorful_config = 1

let g:git_messenger_always_into_popup = 1
let g:git_messenger_include_diff = 'current'
let g:git_messenger_extra_blame_args ='-w' " Ignore whitespace

" vim-doge
let g:doge_enable_mappings = 0
" let g:javascript_plugin_jsdoc = 1
"let g:doge_javascript_settings = {
" \  'destructuring_props': 1,
" \ }

" DEFAULT COC.NVIM START

set updatetime=100

" Give more space for displaying messages
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

au BufReadCmd /zip:*.yarn/cache/*.zip/* call OpenZippedFile(expand('<afile>'))

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

augroup CocGroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Coc search
nnoremap <leader>se :CocSearch <C-R><C-W><CR>
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" execute codelens action
nmap <leader>al <Plug>(coc-codelens-action)
" apply codeAction to the current buffer.
nmap <leader>ab <Plug>(coc-codeaction)
" apply codeaction under the cursor
nmap <leader>ac <Plug>(coc-codeaction-cursor)
" Apply AutoFix to problem on the current line.
nmap <leader>afl <Plug>(coc-fix-current)
" Display actions on the current line
nmap <leader>rf :CocAction<cr>
" fix eslint (all)
nmap <leader>aff :<C-u>CocCommand eslint.executeAutofix<cr>
" format file
nmap <leader>afo <Plug>(coc-format)
" auto fix imports
nmap <leader>ai :<C-u>CocCommand tsserver.organizeImports<cr>
" add prettier command
:command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
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
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" restart when coc gets wonky
nnoremap <silent> <leader>cr :<C-u>CocRestart<CR>
nnoremap <silent> <leader>cs :<C-u>CocStart<CR>

" COC.SNIPPET START

" max items to show in popup list
set pumheight=20

" close preview when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" make sure to kill coc pid when closing nvim (not sure if needed)
autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
		\	| call system('kill -9 '.g:coc_process_pid) | endif

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
" let g:coc_node_path = '/usr/local/bin/node' " use node v14?
" COC.SNIPPET END

" coc-fzf remappings
let g:coc_fzf_opts= ['--layout=reverse']
let g:coc_fzf_preview='right:50%'

nnoremap <silent><nowait> <leader>cfa :<C-u>CocFzfList actions<CR>
nnoremap <silent><nowait> <leader>cfb :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> <leader>cfB :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><nowait> <leader>cfc :<C-u>CocFzfList commands<CR>
nnoremap <silent><nowait> <leader>cfe :<C-u>CocFzfList extensions<CR>
nnoremap <silent><nowait> <leader>cfl :<C-u>CocFzfList location<CR>
nnoremap <silent><nowait> <leader>cfL :<C-u>CocFzfList<CR>
nnoremap <silent><nowait> <leader>cfo :<C-u>CocFzfList outline<CR>
nnoremap <silent><nowait> <leader>cfs :<C-u>CocFzfList symbols<CR>
nnoremap <silent><nowait> <leader>cfS :<C-u>CocFzfList snippets<CR>
nnoremap <silent><nowait> <leader>cfv :<C-u>CocFzfList services<CR>
nnoremap <silent><nowait> <leader>cfr :<C-u>CocFzfListResume<CR>
nnoremap <silent><nowait> <leader>cfy :<C-u>CocFzfList yank<CR>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent> <Leader>nf  :CocCommand explorer --position floating<CR>
nnoremap <silent> <Leader><Leader> :CocCommand explorer --toggle<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

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
" :Buffers Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Search file names and file contents
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

" Search lines in _all_ buffers
command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))

" do not search filename, just file contents of all file Lines in root dir
command! -bang -nargs=* Lines
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case  -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({ 'options': ['--delimiter', ':', '--nth', '4..', '--color', 'hl:123,hl+:222'] }), <bang>0)

" override default preview settings in zshrc
command! -bang -nargs=* HistoryCmds call fzf#vim#command_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))
command! -bang -nargs=* HistorySearch call fzf#vim#search_history(fzf#vim#with_preview({'options': ['--preview-window', 'hidden']}))

let g:fzf_action = {
  \ 'ctrl-t': 'tab',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" open fzf in a floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Fzf display mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'options': ['--preview-window', 'hidden']})

" switch finder so ignore settings are used
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" scope path to current dir
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
"     \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
"     \ fzf#wrap({'dir': expand('%:p:h')}))

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

inoremap <expr> <c-x><c-f> JsFzfImport()

" Global line completion (not just open buffers)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

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

" Init jest in current cwd, require global jest command exists
command! JestInit :call CocActionAsync('runCommand', 'jest.init')

" Run jest for current file
nnoremap <leader>tf :call CocActionAsync('runCommand', 'jest.fileTest', ['%'])<CR>
" Run jest for current test
nnoremap <leader>tt :call CocActionAsync('runCommand', 'jest.singleTest')<CR>
" Run jest for current project
nnoremap <leader>tp :call CocActionAsync('runCommand', 'jest.projectTest')<CR>
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

au BufNewFile ~/Documents/notes/diary/*.md
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
