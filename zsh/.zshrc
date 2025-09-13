# For zsh-defer
source ~/zsh-defer/zsh-defer.plugin.zsh


#-------------------------------------------------------------------------------
# OH-MY-ZSH CONFIGURATION
#-------------------------------------------------------------------------------

# Path configuration
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
# Uncomment to use a specific theme or set to "random" for variety
# ZSH_THEME="ultima"
# For random themes, you can specify candidates:
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

#-------------------------------------------------------------------------------
# ZSH BEHAVIOR OPTIONS
#-------------------------------------------------------------------------------

# Uncomment to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment for hyphen-insensitive completion (_ and - interchangeable)
# HYPHEN_INSENSITIVE="true"

# Update behavior configuration
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# zstyle ':omz:update' frequency 13   # update frequency in days

# Terminal behavior options
# DISABLE_MAGIC_FUNCTIONS="true"      # fix pasting URLs
# DISABLE_LS_COLORS="true"            # disable colors in ls
# DISABLE_AUTO_TITLE="true"           # disable auto-setting terminal title
# ENABLE_CORRECTION="true"            # enable command auto-correction

# Completion waiting indicators
# COMPLETION_WAITING_DOTS="true"      # show red dots while waiting
# Can also use custom string: COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Repository status options
# DISABLE_UNTRACKED_FILES_DIRTY="true"  # faster status check for large repos

# History timestamp format
# HIST_STAMPS="mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or custom strftime format
# HIST_STAMPS="mm/dd/yyyy"

# Custom directory for Oh My Zsh
# ZSH_CUSTOM=/path/to/new-custom-folder

# ZSH Completions for Homebrew
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#   autoload -Uz compinit
#   compinit
# fi
#

# Zsh completions
# fpath=(~/.zsh/completions $fpath)
fpath=(~/.zsh/completions/zsh-completions/src ~/.zsh/completions $fpath)

autoload -Uz compinit
compinit

#-------------------------------------------------------------------------------
# PLUGINS
#-------------------------------------------------------------------------------

plugins=(
	# Core functionality
	git
	python
	sudo
	history
	dirhistory
	systemd
	command-not-found
	common-aliases
	z
  httpie

	# Navigation and file management
	zsh-interactive-cd
	wd
	k
	copyfile
	copybuffer
  fzf-tab

	# Notifications and suggestions
	bgnotify
	zsh-autosuggestions
	zsh-syntax-highlighting
	you-should-use
)

source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------
# COMMAND EXECUTION TIME
#-------------------------------------------------------------------------------

ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_COLOR="yellow"

#-------------------------------------------------------------------------------
# AUTO SUGGESTIONS BINDINGS
#-------------------------------------------------------------------------------

zsh-defer source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

#-------------------------------------------------------------------------------
# EDITOR CONFIGURATION
#-------------------------------------------------------------------------------

export EDITOR='nvim'
export VISUAL='nvim'

export BAT_THEME='Catppuccin Mocha'

#-------------------------------------------------------------------------------
# ALIASES
#-------------------------------------------------------------------------------

# Configuration shortcuts
alias zshconfig="sudo nvim ~/.zshrc"
alias sshconfig="sudo nvim ~/.ssh/config"
alias tmuxconfig="nvim ~/.config/tmux/tmux.conf"
alias srczsh="exec zsh"
alias ohmyzsh="sudo nvim ~/.oh-my-zsh"
alias cls="clear"
alias cl="clear"

alias n="nvim"
alias v="vim"
alias tls="tmux ls"
alias t="tmux"
alias o="fd --type f --hidden --exclude .git | fzf-tmux -p -- --reverse | xargs nvim"
alias ash="uvx git+https://github.com/awslabs/automated-security-helper.git@v3.0.0"


# HTTP requests with xh!
alias http="xh"

# File listing (using eza with enhanced formatting)
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias la=tree
alias cat=bat

# Eza config
export EZA_CONFIG_DIR="$HOME/.config/eza"
# Alternative: Using colorls
# alias ls='colorls -A --sd'
# alias sudo-ls='sudo colorls -A --sd'

# Lazy tools shortcuts
alias lzd='lazydocker'
alias lzg='lazygit'
alias lzs='lazysql'

# Git shortcuts
alias gplo="git pull origin"
alias checkout-development="gco development && gpodt"
alias checkout-develop="gco develop && gpodp"
alias galias="alias | grep git"
alias last-pulled-logs="git log HEAD@{1}..HEAD"  # Show logs between last pulled commit and HEAD
alias last-pulled-changes="git diff HEAD@{1}..HEAD"  # Show changes between last pulled commit and HEAD
alias gfind="git log -S"  # Search in git history
alias gorphans='git remote prune origin'  # Remove all stale remote-tracking branches
alias gmirror='git fetch --all && git pull --all'  # Fetch all remotes and pull all branches
alias git-prune-local='git fetch -p && git branch -vv | awk "/: gone]/{print \$1}" | xargs -r git branch -d'

alias generate-commit-message='lumen explain --diff --staged -q "Generate commit message for these changes and make sure to follow character length guidelines (50 chars for title and 72 chars for description) when generating messages. Wrap code related words in ``. Do not add scope in commit title, keep it simple one line title, but do add feat: fix: style: refactor: doc: in title. Do not add file wise names, follow this strucutre, <type>: <description>

[optional body]"'

function logg() {
    git lg | fzf --ansi --no-sort \
        --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % git show % --color=always' \
        --preview-window=right:50%:wrap --height 100% \
        --bind 'enter:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "git show % | nvim -c \"setlocal buftype=nofile bufhidden=wipe noswapfile nowrap\" -c \"nnoremap <buffer> q :q!<CR>\" -")' \
        --bind 'ctrl-e:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "gh browse %")'
}

# Stow a config directory into ~/dotfiles
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

# Unstow a config directory from ~/dotfiles
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



# Scan any docker image for vulnerabilities using Trivy
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
  # check locally if image exists
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

# Project-specific aliases (Alloi)
alias reset-ops="make reset-migrate && make down && make up && sleep 10 && curl --location --request POST 'http://localhost:3567/recipe/dashboard/user' \
--header 'rid: dashboard' \
--header 'Content-Type: application/json' \
--data-raw '{"email": "jaimish+admin@opshealth.io","password": "local123"}'"

alias start-servers="tmux kill-session -t servers && tmuxp load -s servers ~/.tmuxp/ops_servers.yaml"

create-authdb() {
  docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$1\";"
}

create-opsdb() {
  docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$1\";"
}

create-fresh-dbs() {
  # Ask for the auth DB name
  auth_db=$(gum input --placeholder "Enter name for auth DB" --prompt "authdb > ")
  if [ -z "$auth_db" ]; then
    gum style --foreground 1 "❌ Auth DB name is required. Aborting."
    return 1
  fi

  # Ask for the ops DB name
  ops_db=$(gum input --placeholder "Enter name for ops DB" --prompt "opsdb > ")
  if [ -z "$ops_db" ]; then
    gum style --foreground 1 "❌ Ops DB name is required. Aborting."
    return 1
  fi

  # Create auth DB
  gum spin --title "Creating auth DB: $auth_db" -- \
    docker exec -it authdb psql -U opshealth_user -c "CREATE DATABASE \"$auth_db\";"

  gum style --foreground 10 "✓ Created auth DB: $auth_db"

  # Create ops DB
  gum spin --title "Creating ops DB: $ops_db" -- \
    docker exec -it postgresql-opshealth psql -U postgres -c "CREATE DATABASE \"$ops_db\";"

  gum style --foreground 10 "✓ Created ops DB: $ops_db"

  gum style --foreground 212 --bold --border double --padding "1 2" "🎉 Databases created successfully!"
}



# Navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

#-------------------------------------------------------------------------------
# EXTERNAL TOOLS INTEGRATION
#-------------------------------------------------------------------------------

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"


# Console Ninja
PATH=~/.console-ninja/.bin:$PATH

# Atuin (shell history)
eval "$(atuin init zsh)"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# FZF (fuzzy finder) configuration

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

function pkill() {
  ps aux | fzf --height 40% --layout=reverse --prompt="Select process to kill: " | awk '{print $2}' | xargs -r sudo kill
}

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Set up fzf key bindings and fuzzy completion
zsh-defer source <(fzf --zsh)

# Tre command - Enhanced tree with automatic aliasing
tre() { command tre "$@" -e && zsh-defer source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# UV (Python package installer)
eval "$(uv generate-shell-completion zsh)"

# Navi shell widget
eval "$(navi widget zsh)"

# pipx path (added on 2025-01-13)
export PATH="$PATH:/Users/jaimish/.local/bin"

# bun path
export PATH="/Users/jaimish/.bun/bin:$PATH"

# for docker compose
export COMPOSE_BAKE=true

# for tmuxp
export DISABLE_AUTO_TITLE='true'
#-------------------------------------------------------------------------------
# COMMENTED/DISABLED FEATURES (for reference)
#-------------------------------------------------------------------------------

# thefuck command corrector
# eval $(thefuck --alias)

# Superfile configuration
# spf() {
#     os=$(uname -s)
#     # Linux
#     if [[ "$os" == "Linux" ]]; then
#         export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
#     fi
#     # macOS
#     if [[ "$os" == "Darwin" ]]; then
#         export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
#     fi
#     command spf "$@"
#     [ ! -f "$SPF_LAST_DIR" ] || {
#         . "$SPF_LAST_DIR"
#         rm -f -- "$SPF_LAST_DIR" > /dev/null
#     }
# }

# Auto-Warpify for Warp terminal
# printf 'P$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "bash", "uname": "Darwin" }}'

# Default FZF configuration (currently disabled)
# export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# export FZF_CTRL_T_OPTS="
#   --walker-skip .git,node_modules,target
#   --preview 'bat -n --color=always {}'
#   --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target --preview 'tree -C {}'"
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jaimish/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Added by Windsurf
export PATH="/Users/jaimish/.codeium/windsurf/bin:$PATH"
