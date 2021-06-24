# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof # zsh perf check

fpath=(
  $fpath
  /usr/local/share/zsh/site-functions
)

# color term
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
export LESS=FRX

# make with the nice completion
# autoload -U compinit; compinit
autoload -Uz compinit
# if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
#   compinit
# else
#   compinit -C
# fi

# Completion for kill-like commands
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache

# make with the pretty colors
autoload colors; colors

#vim binding
bindkey -v
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward
bindkey  "^[[H"   beginning-of-line # Home key
bindkey  "^[[F"   end-of-line # End key

export KEYTIMEOUT=5 # remove normal/insert mode switch delay

zstyle ':completion:*' special-dirs true

# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
zstyle ":completion:*:git-checkout:*" sort false

# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# set cd autocompletion to commonly visited directories
# cdpath=(~/code/WORKPLACEDIR)
# don't display the common ones with `cd` command
zstyle ':completion:*:complete:cd:*' tag-order \
    'local-directories named-directories'

# fzf-tab
zstyle ':fzf-tab:*' fzf-bindings 'alt-k:preview-half-page-up' 'alt-j:preview-half-page-down'

# local fzf_tab_preview_debug='
# echo "word: $word"
# echo "group: $group"
# echo "desc: $desc"
# echo "realpath: $realpath"
# '
# zstyle ':fzf-tab:complete:*' fzf-preview $fzf_tab_preview_debug

local preview_command='
if [[ -d $realpath ]]; then
    exa -a --icons --tree --level=1 --color=always $realpath 
elif [[ -f $realpath ]]; then
    bat --pager=never --color=always --line-range :80 $realpath
else
    exit 1
fi
'
# https://github.com/junegunn/fzf#settings
#
# zstyle ':completion:*:*:vim:*:*files'
zstyle ':fzf-tab:complete:*' fzf-preview $preview_command
zstyle ':fzf-tab:complete:git-checkout:argument-rest' fzf-preview '
[[ $group == "[recent branches]" || $group == "[local head]" ]] && git log --max-count=3 -p $word | delta
'
# use gig-git-status-branch.sh to display upstream differences? ./git-status-branch -d $word

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' show-group brief

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 200 200

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $2 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

# options https://gist.github.com/mattmc3/c490d01751d6eb80aa541711ab1d54b1#file-1-setopts-zsh-L50
setopt appendhistory         # sessions will append their history list to the history file
setopt extendedglob          # Treat the ‘#’, ‘~’ and ‘^’ characters as part of filename
setopt auto_cd               # if a command isn't valid, but is a directory, cd to that dir
setopt nonomatch             # tell zsh to pass the unevaluated argument like bash
setopt interactivecomments   # Allow comments even in interactive shells.
setopt hist_ignore_all_dups  # Delete old recorded entry if new entry is a duplicate
setopt share_history         # Share history between all sessions.
setopt prompt_subst          # parameter expansion, command substitution and arithmetic expansion are performed in prompts

# Bindings
# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Partial word history completion
bindkey '\ep' up-line-or-search
bindkey '\en' down-line-or-search
bindkey '\ew' kill-region

# alt-c 
bindkey "ç" fzf-cd-widget

# disable in tmux
if [ -z "$TMUX" ]; then
  fg-widget() {
    stty icanon echo pendin -inlcr < /dev/tty
    stty discard '^O' dsusp '^Y' lnext '^V' quit '^\' susp '^Z' < /dev/tty
    zle reset-prompt
    if jobs %- >/dev/null 2>&1; then
      fg %-
    else
      fg
    fi
  }

  # Use C-z to foreground in zsh
  zle -N fg-widget
  bindkey -M emacs "^Z" fg-widget
  bindkey -M vicmd "^Z" fg-widget
  bindkey -M viins "^Z" fg-widget
fi

# fg () {
#   _CMD=$(jobs -l | grep nvim | awk '{print $3}');
#   echo _CMD
    # echo $1
    # if [[ "nvim" == "$1" ]]; then
    #     _CMD=$(ps -o cmd --no-headers $(jobs -l | awk '/\[[0-9]\]\+/{print $2}'));
    # else
    #     _CMD=$(ps -o cmd --no-headers $(jobs -l | awk '/\['$1'\]/{print $2}'));
    # fi;
    # title $(basename $(echo $_CMD | awk '{print $1}')) "$_CMD";
    # unset _CMD;
    # builtin fg $*;
# }

# fkill: npm install --global fkill-cli
fkill_full() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf-tmux -p 90%,90% --ansi --multi --preview-window=:hidden | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf-tmux -p 90%,90% --ansi --multi --preview-window=:hidden | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi

  rg --files-with-matches --no-messages "$1" | fzf-tmux -p 90%,90% --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

gcr() {
  git checkout -b $1 origin/$1
}

# do instead? https://github.com/tpope/vim-rhubarb/commit/964d48f
git() {
  if command -v hub >/dev/null; then
    command hub "$@"
  else
    command git "$@"
  fi
}

function tree-git-ignore {
    # tree respecting gitignore

    local ignored=$(git ls-files -ci --others --directory --exclude-standard)
    local ignored_filter=$(echo "$ignored" \
                    | egrep -v "^#.*$|^[[:space:]]*$" \
                    | sed 's~^/~~' \
                    | sed 's~/$~~' \
                    | tr "\\n" "|")
    tree --prune -I ".git|${ignored_filter: : -1}" "$@"
}

# default apps
# export DELTA_PAGER='auto'
# I have no idea why I have to unset this but otherwise I don't get LESS paging
unset DELTA_PAGER
export PAGER='less'
export EDITOR='nvim'
# export MANPAGER='nvim +Man!'
# open new nvim session for MANPAGER
# export MANPAGER="nvim -c 'set ft=man' -"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANWIDTH=999

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fzf settings
export FZF_TMUX=1 # open in pop-up
export FZF_TMUX_OPTS="-p -w 90% -h 60%"
export FZF_TMUX_POP_UP_OPTS="-p 90%,90%"
export FZF_HIDE_PREVIEW="--preview-window=:hidden"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND --type d"
export FZF_CTRL_R_OPTS="--preview-window=:hidden"
export BAT_THEME="Enki-Tokyo-Night"

export FZF_DEFAULT_OPTS="
--history=$HOME/.fzf_history
--layout=reverse
--info=inline
--height=80%
--multi
--border
--preview '([[ -f {} ]] && (bat --style=full --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--preview-window cycle
--prompt='∼ ' --pointer='▶' --marker='✓'
--header 'CTRL-s/ALT-d to select/unselect-all, CTRL-u/d page up/down, ALT-k/j preview half-page up/down, \ to toggle, CTRL-y to copy into clipboard'
--bind '\:toggle-preview'
--bind 'ctrl-s:select-all'
--bind 'alt-d:deselect-all'
--bind 'ctrl-u:page-up'
--bind 'ctrl-d:page-down'
--bind 'alt-k:preview-half-page-up'
--bind 'alt-j:preview-half-page-down'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--bind 'ctrl-v:execute(nvim {} < /dev/tty > /dev/tty 2>&1)+accept'
"

# https://github.com/junegunn/fzf/commit/f84b3de24b63e2e26cbfa2a24e61a4173824fffd
# tweak above nvim open?
# ls | fzf --bind "enter:execute(vim {})"

# override builtin fzf functions for `app **<tab>`
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# override builtin fzf functions for `cd **<tab>`
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf-tmux -p 90%,90% -preview-window=:hidden --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Same as above, but with previews and works correctly with man pages in different sections.
fman() {
    man -k . | fzf-tmux -p 90%,90% -preview-window=:hidden --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

# fstash - easier way to deal with stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf-tmux -p 90%,90% --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# fgst - pick files from `git status -s` 
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgst() {
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}

# USAGE:
# git fixup
# git rebase -i master --autosquash
# https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html

function git-fixup () {
  git log --oneline -n 20 | fzf-tmux -p 90%,90% | cut -f 1 | xargs git commit --no-verify --fixup
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf-tmux -p 90%,90% -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf-tmux -p 90%,90% -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf-tmux -p 90%,90% -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -p 90%,90% -preview-window=:hidden) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf-tmux -p 90%,90% --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf-tmux -p 90%,90% --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf-tmux -p 90%,90% --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# change all these with these
# https://github.com/bkuhlmann/dotfiles/blob/main/home_files/.config/bash/functions-private.sh.tt#L223-L227
# https://github.com/bkuhlmann/dotfiles/blob/main/home_files/.config/bash/functions-public.sh.tt#L1243-L1253
git_reset_hard_remote() {
  local commit
  commit=$( git branch --show-current ) &&
  git reset --hard origin/$(echo "$commit")
}

git_reset_hard_local() {
  local commit
  commit=$( git branch --show-current ) &&
  git reset --hard $(echo "$commit")
}

gpull() {
  if [ $# -eq 0 ]
    then
      BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    else
      BRANCH=${1}
  fi
  git pull origin "${BRANCH}"
}
function gpush() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git push -u origin "${BRANCH}"
}

# aliases
# alias ls="exa"
alias ll="exa -alh --icons --git -t=mod --time-style=long-iso"
alias md='mkdir -p'
alias vi='nvim'
alias vim='nvim'
alias n='nvim'
alias rd='rmdir'
alias tweak='vim ~/.config/nvim/init.vim'
alias tree='tree-git-ignore'

alias tmn='tmux new -s'
alias tma='tmux attach -t'

# used in 'gnap' alias
gref() {
  command git --no-pager diff --cached --stat | command grep "|\s*0$" | awk '{system("command git reset " $1)}'
}

# only run lint on changes
# "git diff --name-only | grep -E '.(js|ts|tsx)$' | xargs eslint --fix"

ch() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  # Chrome search
  # cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  # Chromium search https://github.com/Eloston/ungoogled-chromium
  cp -f ~/Library/ApplicationSupport/Chromium/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf-tmux -p 90%,90% --ansi --multi --preview-window=:hidden | sed 's#.*\(https*://\)#\1#' | xargs open -a "Chromium"
}

# Default `fold` to screen width and break at spaces
function fold {
  if [ $# -eq 0 ]; then
    /usr/bin/fold -w $COLUMNS -s
  else
    /usr/bin/fold $*
  fi
}

# Use `fzf` against system dictionary
function spell {
  cat /usr/share/dict/words | fzf-tmux -p 90%,90% --preview 'wn {} -over | fold' --preview-window=up:60%
}

# Lookup definition of word using `wn $1 -over`.
# If $1 is not provided, we'll use the `spell` command to pick a word.
#
# Requires:
#   brew install wordnet
#   brew install fzf
function dic {
  if [ $# -eq 0 ]; then
    wn `spell` -over | fold
  else
    wn $1 -over | fold
  fi
}

:e() {
    if [[ -z $VIM_TERMINAL ]]; then
        # maybe something like this instead? nvim **'\t'
        nvim "$@"
    else
        for f; do
            echo -e "\033]51;[\"drop\", \"$f\"]\007"
        done
    fi
}

# git aliases
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gnap='git add -N --ignore-removal . && gap && gref'
# alias gnap='git add $(git ls-files -N -add -o --exclude-standard) || git add -N --ignore-removal . && gap && gref'
alias gb="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcl='git clean -f -d'
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias glod='git log --oneline --decorate'
alias gp='git push'
alias gpf='git pushf'
alias gpu='git pull'
alias gpr='git pull --rebase'
alias pulls='git browse -- pulls'
alias branches='git browse -- branches'
# alias open-PLACEHOLDER='git browse PLACEHOLDER'
alias dotfiles='cd ~/code/timtyrrell/dotfiles'
alias gst='git status -sb'
alias gstl='git status'
alias ghpr='gh pr list | fzf-tmux -p 90%,90% --preview "gh pr diff --color=always {+1}" | awk "{print $1}" | xargs gh pr checkout'
alias gs='fbr'
alias gfb='git fuzzy branch'
alias gfpr='git fuzzy pr'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gmc='git merge --continue'
alias gma='git merge --abort'
alias gms='git merge --skip'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcps='git cherry-pick --skip'
alias gcpc='git cherry-pick --continue'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcop='git checkout -p' # interactive hunk revert
alias gres='git restore --staged .'
alias gappend='git add . && git commit --amend -C HEAD'
alias gappendyolo='git add . && LEFTHOOK=0 git commit --amend -C HEAD'
alias clean 'git clean -fd'
alias unstage='git restore --staged .'
alias grestore="git restore --staged . && git restore ."
alias reset_authors='git commit --amend --reset-author -C HEAD'
alias grhr="git_reset_hard_remote"
alias grhl="git_reset_hard_local"
alias wip="git add . && LEFTHOOK=0 gc -m 'wip [ci skip]'"
alias undo="git reset HEAD~1 --mixed"
alias unwip="undo"
# alias unwip="git reset --soft 'HEAD^' && git restore --staged ."
alias nuke="unwip && grestore"
alias pokey="gco main && gpr && gco - && gr -"
alias hokey="pokey"
alias sha="git rev-parse HEAD"
alias SHA="sha"
alias cannonball="git add . && git commit --amend -C HEAD && git push --force-with-lease"
alias cannonballyolo="git add . && LEFTHOOK=0 git commit --amend -C HEAD && git push --force-with-lease"
alias fix='nvim +/HEAD `git diff --name-only | uniq`'
alias be="bundle exec"
alias nvm="fnm"
alias strat="start"
alias barf="rm -rf node_modules && npm i"
alias rimraf="rm -rf node_modules"
alias stash="git add . && git add stash"

alias tmux_plugins_install="~/.tmux/plugins/tpm/bin/install_plugins"
alias tmux_plugins_update="~/.tmux/plugins/tpm/bin/update_plugins all"
alias tmux_plugins_clean="~/.tmux/plugins/tpm/bin/clean_plugins"

# brew tap jason0x43/homebrew-neovim-nightly
# brew cask install neovim-nightly
alias update-neovim-nightly="brew reinstall neovim-nightly"
alias install-tmux-head="brew install --HEAD tmux"
alias brew-install="brew bundle install --global"
alias brew-outdated="brew update && echo 'OUTDATED:' && brew outdated"
alias brewup="brew update; brew upgrade; brew cleanup"
alias zinit-update="zinit self-update"
alias zinit-plugin-update="zinit update --all"
alias crate-update="cargo install-update -a"

ZSH_AUTOSUGGEST_USE_ASYNC=true
alias reload='source ~/.zshrc; echo -e "\n\u2699  \e[33mZSH config reloaded\e[0m \u2699"'

# remove duplicates in $PATH
typeset -aU path

# export PATH="$HOME/Library/Python/2.7/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$HOME/bin:$PATH"

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin

# eval "$(zsh)"
# eval "$(rbenv init -)"
# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following to your ~/.zshrc:
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_COMPLETION_TRIGGER=''
# bindkey '^T' fzf-completion #context (dir) aware completion
# bindkey '^I' $fzf_default_completion

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# plugins - zinit update # to update all
# zinit ice as"program" pick"bin/git-fuzzy"
# zinit light bigH/git-fuzzy
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light aloxaf/fzf-tab
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
# use docker completion script provided by Oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
zinit ice as"completion"
zinit snippet OMZ::plugins/docker/_docker
# use docker completion script provided by Oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker-compose
zinit ice as"completion"
zinit snippet OMZ::plugins/docker-compose/_docker-compose

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# if [[ "$TERM" != "screen" ]] && [[ "$SSH_CONNECTION" == "" ]]; then
#     WHOAMI=$(whoami)
#     if tmux has-session -t $WHOAMI 2>/dev/null; then
#         tmux -2 attach-session -t $WHOAMI
#     else
#         tmux -2 new-session -s $WHOAMI
#     fi
# fi

# if [[ ! -v TMUX ]]; then
#   tmux_chooser && exit
# fi

compinit

# zprof # zsh perf check
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# fnm
eval "$(fnm --log-level=quiet env --use-on-cd)"
