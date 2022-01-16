notify() {
  if [ -z $1 ]; then
    terminal-notifier -title "CMD" -message "Completed!"  -sound purr -ignoreDnD
  elif [ -z $2 ]; then
    terminal-notifier -message "$1" -sound purr -ignoreDnD
  elif [ -z $3 ]; then
    terminal-notifier -title "$1" -message "$2" -sound purr -ignoreDnD
  else
    terminal-notifier -title "$1" -subtitle "$2" -message "$3" -sound purr -ignoreDnD
  fi
}

fkill() {
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

tree-git-ignore() {
    # tree respecting gitignore

    local ignored=$(git ls-files -ci --others --directory --exclude-standard)
    local ignored_filter=$(echo "$ignored" \
                    | egrep -v "^#.*$|^[[:space:]]*$" \
                    | sed 's~^/~~' \
                    | sed 's~/$~~' \
                    | tr "\\n" "|")
    tree --prune -I ".git|${ignored_filter: : -1}" "$@"
}

in_tmux () {
  if [ -n "$TMUX" ]; then
    return 0
  else
    return 1
  fi
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf-tmux -p 90%,90% -preview-window=:hidden --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

tmt() {
  if [[ -z "$TMUX" ]]; then
    tmux attach -t "$session_name"
  else
    tmux switch-client -t "$session_name"
  fi
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

# quick rebase with origin
greb() {
  REMOTE=${1:-main}
  git fetch origin && git rebase origin/${REMOTE}
}

# USAGE:
# git fixup
# git rebase -i master --autosquash
# https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html

function git-fixup () {
  git log --oneline -n 20 | fzf-tmux -p 90%,90% | cut -f 1 | xargs git commit --no-verify --fixup
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
                --bind "alt-y:execute:$_gitLogLineToHash | pbcopy"
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

# checkout existing branch otherwise create new branch
gcob() {
	BRANCH=$1
	ARGS=$2

  if [ "$BRANCH" = "" ] ||
		 [ "$BRANCH" = "-" ]; then
    git checkout $BRANCH
	elif [ "$BRANCH $ARGS" = "-- ." ]; then
    git checkout -- .
  else
    git checkout $(git show-ref --verify --quiet refs/heads/$BRANCH || echo '-b') $BRANCH
  fi
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

gpush() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git push -u origin "${BRANCH}"
}

kube-toggle() {
  if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
  else
    POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

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

# Select a docker container to start and attach
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header $'╱ Enter (kubectl exec) ╱ CTRL-O (open log in editor) ╱ CTRL-R (reload) ╱\n\n' \
        --bind 'ctrl-/:change-preview-window(80%,border-bottom|hidden|)' \
        --bind 'enter:execute:kubectl exec -it --namespace {1} {2} -- bash > /dev/tty' \
        --bind 'ctrl-o:execute:${EDITOR:-vim} <(kubectl logs --all-containers --namespace {1} {2}) > /dev/tty' \
        --bind 'ctrl-r:reload:$FZF_DEFAULT_COMMAND' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}

###################################
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-tmux-popup() {
  fzf-tmux -p 90%,90% --border --bind ctrl-/:toggle-preview "$@"
}

# git status
_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-tmux-popup -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

# git branches
_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux-popup --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# git tags
_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux-popup --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

# Commit hashes
_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-tmux-popup --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

# git remotes
_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-tmux-popup --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

# git stashes
_gs() {
  is_in_git_repo || return
  git stash list | fzf-tmux-popup --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# bind-git-helper() {
#   local c
#   for c in $@; do
#     eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
#     eval "zle -N fzf-g$c-widget"
#     eval "bindkey '^g^$c' fzf-g$c-widget"
#   done
# }
# bind-git-helper f b t r h s
# unset -f bind-git-helper
###################################
