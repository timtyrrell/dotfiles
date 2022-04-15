alias ls='lsd'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias lart='ls -lart'
alias md='mkdir -p'
alias rd='rmdir'
alias tree='tree-git-ignore'
alias cl='clear'

#vim
alias vi='nvim'
alias vim='nvim'
alias n='nvim'
alias nn='nvim .'
alias nm='nvim -u ~/.config/nvim/mini.vim'
alias no='nvim -u NORC'
alias nv='nvim -u ~/code/timtyrrell/dotfiles/init-nvim-lsp.vim'
alias ndebug='nvim -V9myVim.log'
alias nvim-startuptime='rm /tmp/vim.log; nvim --startuptime /tmp/vim.log -c "quit" && cat /tmp/vim.log'

alias wl='watchman watch-list'
alias wda='watchman watch-del-all'

# tmux
alias tmn='tmux new -s'
alias tma='tmux attach -t'
alias tms='tmux switch-client -t'
alias tmls='tmux ls'
alias tag='ta ~/code/invitae'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"
# alias tkill=tmux display-popup -E "for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf); do tmux kill-session -t \$s; done;"

# docker
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcps='docker-compose ps'
alias kt='kubetail'
alias ks='stern -l'
alias k='kubectl'
alias kctx='kubectx'
alias kc="kubecolor"
alias kns='kubens'

# kitty ssh: skitty hostname
# to copy files on connect, edit: ~/.config/kitty/ssh.conf
alias skitty=kitty +kitten ssh

# python
alias pactivate='source $(poetry env info --path)/bin/activate'

# https://qmacro.org/autodidactics/2021/08/06/tmux-output-formatting/
# 1. Open a popup
# 2. Show you all the docker images on your system in an FZF menu
# 3. Select your choice
# 4. A split pane (from target pane) will run docker run --rm -it <chosen_image>
alias dselect='tmux display-popup -E "docker image ls --format '{{.Repository}}' | fzf | xargs tmux split-window -h docker run --rm -it"'

# another option: https://github.com/natkuhn/Chrome-debug
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222&'

# git aliases
alias g='git'
alias ga='git add'
alias gap='git add -p'
alias gnap='git add -N --ignore-removal . && gap && gref'
# alias gnap='git add $(git ls-files -N -add -o --exclude-standard) || git add -N --ignore-removal . && gap && gref'
alias gb="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcf='git commit --fixup'
alias gcl='git clean -f -d'
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias glod='git log --oneline --decorate'
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gp='git push'
alias gpf='git pushf'
alias gpu='git pull'
alias gput='git fetch --tags -f && git pull'
alias gpr='git pull --rebase'
alias pulls='git browse -- pulls'
alias branches='git browse -- branches'
# alias open-PLACEHOLDER='git browse PLACEHOLDER'
alias gst='git status -sb'
alias gstl='git status'
alias ghst='gh pr status'
alias ghpr='gh pr list | fzf-tmux -p 90%,90% --preview "gh pr diff --color=always {+1}" |  { read first rest ; echo $first ; } | xargs gh pr checkout'
alias ghd='gh pr list | fzf-tmux -p 90%,90% --preview "gh pr diff --color=always {+1}" |  { read first rest ; echo $first ; } | xargs gh pr diff'
alias gs='fbr'
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
# alias gcob='git checkout -b'
alias gcop='git checkout -p' # interactive hunk revert
alias gres='git restore --staged .'
alias gappend='git add . && git commit --amend -C HEAD'
alias gamend='git commit --amend -C HEAD'
alias gappendyolo='git add . && HUSKY_SKIP_HOOKS=1 git commit --amend -C HEAD'
alias gclean 'git clean -fd'
alias unstage='git restore --staged .'
alias grestore="git restore --staged . && git restore ."
alias reset_authors='git commit --amend --reset-author -C HEAD'
alias grhr="git_reset_hard_remote"
alias grhl="git_reset_hard_local"
alias stash="git add . && git add stash"
alias wip="git add . && HUSKY_SKIP_HOOKS=1 gc -m 'wip [ci skip]'"
alias undo="git reset HEAD~1 --mixed"
alias unwip="undo"
# alias unwip="git reset --soft 'HEAD^' && git restore --staged ."
alias nuke="unwip && grestore"
alias pokey="gco main && gpr && gco - && gr -"
alias gup="git up"
alias hokey="pokey"
alias sha="git rev-parse HEAD"
alias cannonball="git add . && git commit --amend -C HEAD && git push --force-with-lease"
alias cannonballyolo="git add . && HUSKY_SKIP_HOOKS=1 git commit --amend -C HEAD && git push --force-with-lease"
alias fix='nvim +/HEAD `git diff --name-only | uniq`'

# https://github.com/gennaro-tedesco/gh-f
alias ghf='gh f'
alias ghfp='gh f prs'
alias ghfb='gh f branches'
alias ghfk='gh f pick'
alias ghfr='gh f runs'

# https://github.com/rnorth/gh-combine-prs
alias ghpr_combine='gh combine-prs --query "author:app/dependabot"'
alias ghpr_combineyolo='gh combine-prs --query "author:app/dependabot" --skip-pr-check'

# tmux alias
alias tmux_plugins_install="~/.tmux/plugins/tpm/bin/install_plugins"
alias tmux_plugins_update="~/.tmux/plugins/tpm/bin/update_plugins all"
alias tmux_plugins_clean="~/.tmux/plugins/tpm/bin/clean_plugins"

# random alias
alias be="bundle exec"
alias nvm="fnm"
alias strat="start"
alias ns="npm start"
alias barf="rm -rf node_modules && npm i"
alias rimraf="rm -rf node_modules"

# brew tap jason0x43/homebrew-neovim-nightly
# brew cask install neovim-nightly
alias update-neovim-nightly="brew reinstall neovim-nightly"
alias brew-tmux-head="brew reinstall tmux"
alias brew-install="brew bundle install --global"
alias brew-outdated="brew update && echo 'OUTDATED:' && brew outdated"
alias brewup="brew update; brew upgrade; brew cleanup"
alias crate-update="cargo install-update -a"
alias ghu="gh extension upgrade --all"
alias zsh-update="zcomet self-update && zcomet update"

alias reload='source ~/.zshrc; echo -e "\n\u2699  \e[33mZSH config reloaded\e[0m \u2699"'
