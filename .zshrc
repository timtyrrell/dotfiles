# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof # zsh perf check

fpath=(
  $fpath
  ~/.zsh/functions
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
autoload -U compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# Completion for kill-like commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

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

# fzf-tab
# only show preview for specified commands below
export FZF_TAB_OPTS='--preview-window=:hidden'

local extract="
# trim input(what you select)
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"
local sanitized_in='${~ctxt[hpre]}"${${in//\\ / }/#\~/$HOME}"'
zstyle ':completion:*' special-dirs true
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:40%
zstyle ':fzf-tab:complete:exa:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:40%
zstyle ':fzf-tab:complete:bat:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:70%
zstyle ':fzf-tab:complete:cat:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:70%
zstyle ':fzf-tab:complete:nvim:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:70%
zstyle ':fzf-tab:complete:git:*' extra-opts --preview=$extract'preview_file_or_folder.sh $realpath' --preview-window=right:70%

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
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

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi

  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

gcr() {
  git checkout -b $1 origin/$1
}

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
export PAGER='less'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# fzf settings
export FZF_TMUX=1 # open in pop-up using unreleased tmux version
export FZF_TMUX_OPTS="-p -w 90% -h 60%"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND --type d"
export FZF_CTRL_R_OPTS="--preview-window=:hidden"
export BAT_THEME="Nord"

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview '([[ -f {} ]] && (bat --style=full --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='dark'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-s:select-all'
--bind 'ctrl-u:page-up'
--bind 'ctrl-d:page-down'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-v:execute(nvim {} < /dev/tty > /dev/tty 2>&1)+accept'
"

# directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  emulate -L sh
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    out=( "${(@f)out}" )
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

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Install or open the webpage for the selected application 
# using brew cask search as input source
# and display a info quickview window for the currently marked application
install_cask() {
  local token
  token=$(brew search --casks | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

  if [ "x$token" != "x" ]
  then
      echo "(I)nstall or open the (h)omepage of $token"
      read input
      if [ $input = "i" ] || [ $input = "I" ]; then
          brew cask install $token
      fi
      if [ $input = "h" ] || [ $input = "H" ]; then
          brew cask home $token
      fi
  fi
}
# Uninstall or open the webpage for the selected application 
# using brew list as input source (all brew cask installed applications) 
# and display a info quickview window for the currently marked application
uninstall_cask() {
  local token
  token=$(brew cask list | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

  if [ "x$token" != "x" ]
  then
      echo "(U)ninstall or open the (h)omepage of $token"
      read input
      if [ $input = "u" ] || [ $input = "U" ]; then
          brew cask uninstall $token
      fi
      if [ $input = "h" ] || [ $token = "h" ]; then
          brew cask home $token
      fi
  fi
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# aliases
alias ls="exa"
alias ll="exa -lah --icons --git"
alias md='mkdir -p'
alias vi='nvim'
alias vim='nvim'
alias n='nvim'
alias rd='rmdir'
alias tweak='vim ~/.config/nvim/init.vim'
alias tree='tree-git-ignore'

alias tmn='tmux new -s'
alias tma='tmux attach -t'

gref() {
  command git --no-pager diff --cached --stat | command grep "|\s*0$" | awk '{system("command git reset " $1)}'
}

# https://dev.to/hotoolong/make-git-status-and-gh-easier-to-use-with-fzf-4pl3
# fzf_git_pull_request() {
  # local query (commandline --current-buffer)
  # if [[test -n $query]]; then
  #   set fzf_query --query "$query"
  # fi

  # local base_command gh pr list --limit 100
  # local bind_commands "ctrl-a:reload($base_command --state all)"
  # set bind_commands $bind_commands "ctrl-o:reload($base_command --state open)"
  # set bind_commands $bind_commands "ctrl-c:reload($base_command --state closed)"
  # set bind_commands $bind_commands "ctrl-g:reload($base_command --state merged)"
  # set bind_commands $bind_commands "ctrl-a:reload($base_command --state all)"
  # local bind_str (string join ',' $bind_commands)

  # local out ( \
  #   command $base_command | \
  #   fzf $fzf_query \
  #       --prompt='Select Pull Request>' \
  #       --preview="gh pr view {1}" \
  #       --expect=ctrl-k,ctrl-m \
  #       --header='enter: open in browser, C-k: checkout, C-a: all, C-o: open, C-c: closed, C-g: merged, C-a: all' \
  # )
  # if [[test -z $out]]; then
  #   return
  # fi
  # local pr_id (echo $out[2] | awk '{ print $1 }')
  # if [[test $out[1] = 'ctrl-k']]; then
  #   commandline "gh pr checkout $pr_id"
  #   commandline -f execute
  # elif [[test $out[1] = 'ctrl-m']]; then
  #   commandline "gh pr view --web $pr_id"
  #   commandline -f execute
  # fi
# }

# git aliases
alias ga='git add'
alias gap='git add -p'
alias gnap='git add -N --ignore-removal . && gap && gref'
# alias gnap='git add $(git ls-files -o --exclude-standard) || git add -N --ignore-removal . && gap && gref'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcp='git cherry-pick'
alias gcl='git clean -f -d'
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias glod='git log --oneline --decorate'
alias gp='git push'
alias gpr='git pull --rebase'
alias gst='git status'
alias gs='fbr'
alias gfb='git fuzzy branch'
alias gfpr='git fuzzy pr'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias gco='git checkout'
alias gres='git restore --staged .'
alias gappend='git add . && git commit --amend -C HEAD'
alias unstage='git restore --staged .'
alias grestore="git restore --staged . && git restore ."
alias reset-authors='git commit --amend --reset-author -C HEAD'
alias wip="git add . && LEFTHOOK=0 gc -m 'wip [ci skip]'"
alias unwip="git reset --soft 'HEAD^' && git restore --staged ."
alias undo="unwip"
alias nuke="unwip && grestore"
alias pokey="gco master && gpr && gco - && gr -"
alias hokey="pokey"
alias sha="git rev-parse HEAD"
alias cannonball="git add . && git commit --amend -C HEAD && git push --force-with-lease"
alias fix='nvim +/HEAD `git diff --name-only | uniq`'
alias be="bundle exec"
alias nvm="fnm"
alias strat="start"
alias barf="rm -rf node_modules && npm i"
alias stash="git add . && git add stash"
alias tmux_plugins_install="~/.tmux/plugins/tpm/bin/install_plugins"
alias tmux_plugins_update="~/.tmux/plugins/tpm/bin/update_plugins all"
alias tmux_plugins_clean="~/.tmux/plugins/tpm/bin/clean_plugins"

# temp:
alias release="gco release/nextjs"
alias start="npm run start:next"

# brew tap jason0x43/homebrew-neovim-nightly
# brew cask install neovim-nightly
alias update-neovim-nightly="brew reinstall neovim-nightly"
alias install-tmux-head="brew install --HEAD tmux"
# alias brew-outdated="brew update && echo 'OUTDATED:' && brew outdated"
alias brew-outdated="brew bundle --global"
alias zinit-update="zinit self-update"
alias zinit-plugin-update="zinit update --all"

ZSH_AUTOSUGGEST_USE_ASYNC=true
alias reload='source ~/.zshrc; echo -e "\n\u2699  \e[33mZSH config reloaded\e[0m \u2699"'

# set cd autocompletion to commonly visited directories
cdpath=(~/code/tuftandneedle)
# don't display the common ones with `cd` command
zstyle ':completion:*:complete:cd:*' tag-order \
    'local-directories named-directories'

# remove duplicates in $PATH
typeset -aU path

export PATH="$HOME/Library/Python/2.7/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$HOME/bin/git-fuzzy/bin:$PATH"
export PATH="$HOME/bin:$PATH"

eval "$(direnv hook zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(rbenv init -)"
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
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light kazhala/dotbare
# zinit light wfxr/forgit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# if [[ ! -v TMUX ]]; then
#   tmux_chooser && exit
# fi

# zprof # zsh perf check
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
