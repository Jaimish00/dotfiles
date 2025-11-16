# System shortcuts
alias cls="clear"
alias cl="clear"
alias srczsh="exec zsh"

# App shortcuts
alias n="nvim"
alias v="vim"
alias c="cursor"

# NPM shortcuts
alias nrd="npm run dev"
alias ni="npm install"

# Make shortcuts
alias mu="make up"
alias md="make down"
alias mb="make build"

# Configuration shortcuts
alias zshconfig="sudo nvim ~/.zshrc"
alias sshconfig="sudo nvim ~/.ssh/config"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"
alias ohmyzsh="sudo nvim ~/.oh-my-zsh"

# File operations
alias o="fd --type f --hidden --exclude .git | fzf-tmux -p -- --reverse | xargs nvim"

# File listing with eza
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2 --icons --git"
alias la="tree"
alias lsa="ls -a"

# HTTP requests
alias http="xh"

# Lazy tools
alias lzd="lazydocker"
alias lzg="lazygit"
alias lzs="lazysql"

# Kubectl shortcuts
alias kubectl="kubecolor"
# Make "kubecolor" borrow the same completion logic as "kubectl"
compdef kubecolor=kubectl

# Tmux shortcuts
alias t="tmux"
alias tls="tmux ls"

# Git shortcuts
alias stash="lazygit stash"
alias gplo="git pull origin"
alias checkout-development="gco development && gpodt"
alias checkout-develop="gco develop && gpodp"
alias galias="alias | grep git"
alias last-pulled-logs="git log HEAD@{1}..HEAD"
alias last-pulled-changes="git diff HEAD@{1}..HEAD"
alias gfind="git log -S"
alias gorphans="git remote prune origin"
alias gmirror="git fetch --all && git pull --all"
alias git-prune-local="git fetch -p && git branch -vv | awk '/: gone]/{print \$1}' | xargs -r git branch -d"

# Security tools
alias ash="uvx git+https://github.com/awslabs/automated-security-helper.git@v3.0.0"

alias ..="cd .."
alias ...="cd ../.."

unset git_version
