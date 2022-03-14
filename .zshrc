# if [ -z "$TMUX" ]; then
#   ~/bin/ta
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
  # exit 1
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# make with the nice completion
# autoload -U compinit; compinit
# autoload -Uz compinit
# if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
#   compinit
# else
#   compinit -C
# fi

# use homebrew sqlite install
export PATH="/usr/local/opt/sqlite/bin:$PATH"

fpath=(
  $fpath
  /usr/local/share/zsh/site-functions
)

# color term
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
# https://github.com/kovidgoyal/kitty/issues/2047#issuecomment-934058006 ?
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# set for git delta, iirc
export LESS=FRX
# telescope and less? https://github.com/nvim-telescope/telescope.nvim/issues/253#issuecomment-730071741
# export LESS=iMRS

# make with the pretty colors
autoload colors; colors

# TODO: replace with https://github.com/jeffreytse/zsh-vi-mode ??
#vim binding
bindkey -v
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward

# https://github.com/zsh-users/zsh-autosuggestions#key-bindings
bindkey  "^[[H"   beginning-of-line # Home key
bindkey  "^[[F"   end-of-line # End key
# bindkey '^ '      autosuggest-accept # ctrl + space to accept the current suggestion. right arrow or EOL, also works
bindkey '^x'      autosuggest-execute # ctrl + x to execute the current suggestion
bindkey '^ '      forward-char
bindkey '^n'      forward-word
bindkey '^p'      backward-word

# remove normal/insert mode switch delay
export KEYTIMEOUT=5

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# ic camelCase motions
autoload -U select-word-match
zle -N select-in-camel select-word-match
zle -N select-a-camel select-word-match
zstyle ':zle:*-camel' word-style normal-subword
bindkey -M viopp ic select-in-camel

# i/ and a/ path component motions
zstyle ':zle:select-*-directory' word-style unspecified
zstyle ':zle:select-*-directory' word-chars $'/<>=;&| \t\n'

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

# options https://gist.github.com/mattmc3/c490d01751d6eb80aa541711ab1d54b1
# changing dirs
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir

# completions
setopt always_to_end           # move cursor to the end of a completed word
setopt glob_dots               # include dotfiles when globbing

# expansion/globbing
setopt extendedglob            # Treat the ‘#’, ‘~’ and ‘^’ characters as part of filename

# history
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_ignore_all_dups    # Delete old recorded entry if new entry is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt inc_append_history      # write to the history file immediately, not when the shell exits
# setopt share_history         # Share history between all sessions

# input/output
setopt interactive_comments     # Allow comments even in interactive shells

# job control
setopt auto_resume             # attempt to resume existing job before creating a new process (vim!)
setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
unsetopt rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

# prompting
setopt nonomatch               # tell zsh to pass the unevaluated argument like bash
setopt prompt_subst            # parameter expansion, command substitution and arithmetic expansion are performed in prompts

# don't append failed command to ~/.zsh_history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# Bindings
# external editor support
autoload edit-command-line
zle -N edit-command-line
bindkey '^o' edit-command-line
# bindkey '^x^e' edit-command-line

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

# default apps
# I have no idea why I have to unset this but otherwise I don't get LESS paging
unset DELTA_PAGER
export PAGER='less'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANWIDTH=999

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# FZF SETTINGS

# tmux
export FZF_TMUX=1 # open in pop-up
export FZF_TMUX_OPTS="-p -w 90% -h 60%"
export FZF_TMUX_POP_UP_OPTS="-p 90%,90%"

# default fzf
export FZF_DEFAULT_COMMAND='rg --files'
# files
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS $FZF_SHOW_PREVIEW --select-1"
# directories
export FZF_ALT_C_COMMAND="$FZF_CTRL_T_COMMAND --type d"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS $FZF_SHOW_PREVIEW --select-1"
# history
# modify keybindings.zsh or add plugin: https://github.com/junegunn/fzf/issues/477#issuecomment-230338992
# ctrl-x to execute, enter to put in cmd line
export FZF_CTRL_R_OPTS="$FZF_HIDE_PREVIEW"

# presentation
export BAT_THEME="Enki-Tokyo-Night"

export FZF_HEADER_DEFAULT="ALT-k/j page up/down, CTRL-u/d preview half-page up/down, \ to toggle"
export FZF_HEADER_FILES="CTRL-s/ALT-d to select/unselect-all, CTRL-v open in nvim"
export FZF_HEADER_PASTE="CTRL-y to copy into clipboard"
export FZF_YANK_COMMAND="--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

# preview cycle window rotate: https://github.com/junegunn/fzf/commit/43f0d0c
export FZF_HIDE_PREVIEW="--preview-window=:hidden"
export FZF_SHOW_PREVIEW="
--preview '([[ -f {} ]] && (bat --style=full --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--preview-window cycle
--bind '\:toggle-preview'
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
"

export FZF_DEFAULT_OPTS="
--history=$HOME/.fzf_history
--layout=reverse
--info=inline
--height=80%
--multi
--border
--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
--color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
--color=gutter:#1a1b26
--prompt='> ' --pointer='▶' --marker='✓'
--header '$FZF_HEADER_DEFAULT'
--bind 'ctrl-s:select-all'
--bind 'alt-d:deselect-all'
--preview-window cycle
--bind '\:toggle-preview'
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
--bind 'alt-k:page-up'
--bind 'alt-j:page-down'
--bind 'ctrl-v:execute(nvim {} < /dev/tty > /dev/tty 2>&1)+accept'
"
# --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'

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

# zle -N kube-toggle
# bindkey '^]' kube-toggle  # ctrl-] to toggle kubecontext in powerlevel10k prompt

export DOTFILES="$HOME/code/timtyrrell/dotfiles"
# source $DOTFILES/zsh/init_tasks --source_only
source $DOTFILES/zsh/utils.zsh --source_only
source $DOTFILES/zsh/aliases.zsh --source_only
# source $DOTFILES/zsh/mode --source_only

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
export PYTHONPATH="."

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

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

zcomet load romkatv/powerlevel10k
zcomet load aloxaf/fzf-tab
zcomet load sudosubin/zsh-poetry
zcomet load zsh-vi-more/vi-motions
zcomet load mattmc3/zman
zcomet load greymd/docker-zsh-completion
zcomet load zsh-users/zsh-autosuggestions
zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load zsh-users/zsh-completions

# Completion for kill-like commands
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache
zstyle ':completion:*' special-dirs true

# disable sort when completing options of any command
# zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:complete:*:options' sort false

# TODO fix all this: https://superuser.com/questions/265547/zsh-cdpath-and-autocompletion
# set cd autocompletion to commonly visited directories
cdpath=($HOME/code/invitae $HOME/code/timtyrrell)
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':fzf-tab:*' show-group brief
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 200 200
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:*' fzf-bindings 'ctrl-u:preview-half-page-up' 'ctrl-d:preview-half-page-down' 'space:accept' 'alt-k:page-up' 'alt-j:page-down'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' accept-line ctrl-x

local preview_command='
if [[ -d $realpath ]]; then
  lsd --color always --icon always --depth 2 --tree $realpath
elif [[ -f $realpath ]]; then
  bat --pager=never --color=always --line-range :80 $realpath
else
  # lesspipe.sh $word | bat --color=always
  exit 1
fi
'
zstyle ':fzf-tab:complete:*' fzf-preview $preview_command
# zstyle ':fzf-tab:complete:*.*' fzf-preview $preview_command
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
# export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

# zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
# zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	# fzf-preview 'echo ${(P)word}'

# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color always --icon always --depth 2 --tree $realpath'
# zstyle ':fzf-tab:complete:git-checkout:argument-rest' fzf-preview '
# [[ $group == "[recent branches]" || $group == "[local head]" ]] && git log --max-count=3 -p $word | delta
# '
# zstyle ':fzf-tab:complete:*' fzf-preview 'less $realpath'
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word'
# zstyle -s ':fzf-tab:complete:git-add:*' fzf-preview str

zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

eval "$(pyenv init -)"

source <(stern --completion=zsh)
# setup kubecolor completion
compdef kubecolor=kubectl

# fnm
eval "$(fnm --version-file-strategy=recursive --log-level=quiet env --use-on-cd)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Created by `pipx` on 2021-10-05 19:50:54
export PATH="$PATH:/Users/timothy.tyrrell/.local/bin"

### some plugin above stomps the pbcopy yank so I moved it near the bottom
# vi-mode yank
function vi-yank-pbcopy {
  zle vi-yank
  echo "$CUTBUFFER" | pbcopy
}
zle -N vi-yank-pbcopy
bindkey -M vicmd 'y' vi-yank-pbcopy

function vi-put-after-pbcopy {
  CUTBUFFER=$(pbpaste)
  zle vi-put-after
}
zle -N vi-put-after-pbcopy
bindkey -M vicmd 'p' vi-put-after-pbcopy

function vi-put-before-pbcopy {
  CUTBUFFER=$(pbpaste)
  zle vi-put-before
}
zle -N vi-put-before-pbcopy
bindkey -M vicmd 'P' vi-put-before-pbcopy

# directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# Run compinit and compile its cache
zcomet compinit
