#===============================================================================
# ZSH CONFIGURATION
#===============================================================================

# Load zsh-defer for async loading
source ~/zsh-defer/zsh-defer.plugin.zsh

#===============================================================================
# ENVIRONMENT VARIABLES
#===============================================================================

# PATH configuration
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:/Users/jaimish/.local/bin"  # pipx path
export PATH="/Users/jaimish/.bun/bin:$PATH"    # bun path
export PATH=~/.console-ninja/.bin:$PATH        # Console Ninja

# Editor configuration
export EDITOR='nvim'
export VISUAL='nvim'

# Application themes
export BAT_THEME='Catppuccin Mocha'
export EZA_CONFIG_DIR="$HOME/.config/eza"

# Docker configuration
export COMPOSE_BAKE=true

# Terminal configuration
export DISABLE_AUTO_TITLE='true'

#===============================================================================
# OH-MY-ZSH SETUP
#===============================================================================

# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Zsh completions
fpath=(~/.zsh/completions/zsh-completions/src ~/.zsh/completions $fpath)
fpath=(/Users/jaimish/.docker/completions $fpath)  # Docker completions

# Initialize completions
autoload -Uz compinit
compinit

# Oh My Zsh plugins
plugins=(
	git python sudo history dirhistory systemd command-not-found common-aliases z httpie
	zsh-interactive-cd wd k copyfile copybuffer fzf-tab
	bgnotify zsh-autosuggestions zsh-syntax-highlighting you-should-use
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Command execution time
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_COLOR="yellow"

#===============================================================================
# KEY BINDINGS
#===============================================================================

# Auto-suggestions bindings
zsh-defer source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

#===============================================================================
# ALIASES
#===============================================================================

# System shortcuts
alias cls="clear"
alias cl="clear"
alias srczsh="exec zsh"

# Editor shortcuts
alias n="nvim"
alias v="vim"

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

# HTTP requests
alias http="xh"

# Lazy tools
alias lzd="lazydocker"
alias lzg="lazygit"
alias lzs="lazysql"
alias kubectl="kubecolor"

# Tmux shortcuts
alias t="tmux"
alias tls="tmux ls"

# Git shortcuts
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

#===============================================================================
# FUNCTIONS
#===============================================================================

# Git functions
generate-commit-message() {
  local branch prompt commit

  branch=$(git branch --show-current 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")

  prompt="Branch: ${branch}

Generate a commit message. Always follow these guidelines:
- Title must always be <= 50 chars, MUST start with one of: feat:, fix:, style:, refactor:, doc:
- No need to add scope or filenames in the title in paranthesis. Meaning no feat(config), feat(FileName) like this.
- Wrap code identifiers in backticks (\`\`).
- Body (if needed, try to explain the commit here in bullet points): wrap at 72 chars.
Format:
<type>: <short description>

[optional body]"

  commit=$(git diff --staged | lumen draft --context "$prompt")
  printf '%s\n' "$commit"
}

logg() {
    git lg | fzf --ansi --no-sort \
        --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % git show % --color=always' \
        --preview-window=right:50%:wrap --height 100% \
        --bind 'enter:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "git show % | nvim -c \"setlocal buftype=nofile bufhidden=wipe noswapfile nowrap\" -c \"nnoremap <buffer> q :q!<CR>\" -")' \
        --bind 'ctrl-e:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "gh browse %")'
}

# Dotfiles management
dotstow() {
  local name=$1
  if [[ -z "$name" ]]; then
    name=$(gum input --placeholder "Enter the name of the directory to stow")
  fi

  local src="$HOME/.config/$name"
  local dst="$HOME/dotfiles/$name/.config/$name"

  if [[ ! -d "$src" ]]; then
    gum style --foreground 196 "No config found at $src"
    return 1
  fi

  gum confirm "Move $src into $dst and stow it?" || return 1

  mkdir -p "$dst"
  mv "$src"/* "$dst"/
  rmdir "$src" 2>/dev/null || true

  (cd ~/dotfiles && stow "$name")
  gum style --foreground 82 "✔ Successfully stowed $name"
}

dotunstow() {
  local name=$1
  if [[ -z "$name" ]]; then
    name=$(gum input --placeholder "Enter the name of the directory to unstow")
  fi

  local src="$HOME/dotfiles/$name/.config/$name"
  local dst="$HOME/.config/$name"

  if [[ ! -d "$src" ]]; then
    gum style --foreground 196 "No stowed config found at $src"
    return 1
  fi

  gum confirm "Unstow $name and move it back to $dst?" || return 1

  (cd ~/dotfiles && stow -D "$name")

  mkdir -p "$dst"
  mv "$src"/* "$dst"/
  rmdir "$src" 2>/dev/null || true

  gum style --foreground 82 "✔ Successfully unstowed $name"
}

# Docker security scanning
scanimg() {
  image_name=$(gum input --placeholder "Enter image name")
  if [ -z "$image_name" ]; then
    gum style --foreground 1 "❌ Image name is required. Aborting."
    return 1
  fi
  image_tag=$(gum input --placeholder "Enter image tag (optional, default: latest)")
  if [ -z "$image_tag" ]; then
    image_tag="latest"
  fi

  docker images | grep "$image_name" | grep "$image_tag"
  if [ $? -eq 0 ]; then
    gum style --foreground 10 "✓ Image $image_name:$image_tag exists locally"
  else
    gum style --foreground 10 "Pulling image $image_name:$image_tag"
    docker pull "$image_name:$image_tag"
    gum style --foreground 10 "✓ Image $image_name:$image_tag pulled"
  fi

  output_report_name=$(gum input --placeholder "Enter output report name (optional, default: report_$image_name.html)")
  if [ -z "$output_report_name" ]; then
    output_report_name="report_$image_name.html"
  fi
  gum style --foreground 10 "Running scan with output report $output_report_name"
  trivy scan2html image --scanners vuln,secret,misconfig,license "$image_name:$image_tag" --scan2html-flags --output "$output_report_name"
  gum style --foreground 10 "✓ Scan complete"
}

# Database management
create-authdb() {
  docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$1\";"
}

create-opsdb() {
  docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$1\";"
}

create-fresh-dbs() {
  auth_db=$(gum input --placeholder "Enter name for auth DB" --prompt "authdb > ")
  if [ -z "$auth_db" ]; then
    gum style --foreground 1 "❌ Auth DB name is required. Aborting."
    return 1
  fi

  ops_db=$(gum input --placeholder "Enter name for ops DB" --prompt "opsdb > ")
  if [ -z "$ops_db" ]; then
    gum style --foreground 1 "❌ Ops DB name is required. Aborting."
    return 1
  fi

  gum spin --title "Creating auth DB: $auth_db" -- \
    docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$auth_db\";"

  gum style --foreground 10 "✓ Created auth DB: $auth_db"

  gum spin --title "Creating ops DB: $ops_db" -- \
    docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$ops_db\";"

  gum style --foreground 10 "✓ Created ops DB: $ops_db"

  gum style --foreground 212 --bold --border double --padding "1 2" "🎉 Databases created successfully!"
}

# Navigation functions
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# Process management
pkill() {
  ps aux | fzf --height 40% --layout=reverse --prompt="Select process to kill: " | awk '{print $2}' | xargs -r sudo kill
}

# Project-specific aliases (Alloi)
alias reset-ops="make reset-migrate && make down && make up && sleep 10 && curl --location --request POST 'http://localhost:3567/recipe/dashboard/user' \
--header 'rid: dashboard' \
--header 'Content-Type: application/json' \
--data-raw '{\"email\": \"jaimish+admin@opshealth.io\",\"password\": \"local123\"}'"

alias start-servers="tmux kill-session -t servers && tmuxp load -s servers ~/.tmuxp/ops_servers.yaml"

#===============================================================================
# EXTERNAL TOOLS INTEGRATION
#===============================================================================

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Atuin (shell history)
eval "$(atuin init zsh)"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# UV (Python package installer)
eval "$(uv generate-shell-completion zsh)"

# Navi shell widget
eval "$(navi widget zsh)"

# Tre command - Enhanced tree with automatic aliasing
tre() { command tre "$@" -e && zsh-defer source "/tmp/tre_aliases_$USER" 2>/dev/null; }

#===============================================================================
# FZF CONFIGURATION
#===============================================================================

# FZF Catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Set up fzf key bindings and fuzzy completion
zsh-defer source <(fzf --zsh)

#===============================================================================
# ADDITIONAL TOOLS
#===============================================================================

# Television - Ultimate general purpose fuzzy finder
eval "$(tv init zsh)"

# Windsurf integration
export PATH="/Users/jaimish/.codeium/windsurf/bin:$PATH"
