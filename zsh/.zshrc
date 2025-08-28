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

# Cleanup local branches without remote tracking
alias git-cleanup-branches='
git_cleanup_local_branches() {
    # Get all local branches without remote tracking
    local branches=($(git for-each-ref --format="%(refname:short)" refs/heads/ | while read branch; do
        if ! git rev-parse --verify "$branch@{upstream}" >/dev/null 2>&1; then
            echo "$branch"
        fi
    done))
    
    # Filter out current branch
    local current_branch=$(git branch --show-current)
    branches=(${branches[@]/$current_branch})
    
    if [ ${#branches[@]} -eq 0 ]; then
        echo "No local branches without remote tracking found (excluding current branch)"
        return 0
    fi
    
    echo "Found ${#branches[@]} local branches without remote tracking:"
    echo
    
    for branch in "${branches[@]}"; do
        if [ -n "$branch" ]; then
            echo "Branch: $branch"
            
            # Show some info about the branch
            local last_commit=$(git log -1 --format="%h %s" "$branch" 2>/dev/null)
            if [ -n "$last_commit" ]; then
                echo "Last commit: $last_commit"
            fi
            
            # Ask user if they want to delete this branch
            if gum confirm "Delete branch '\''$branch'\''?"; then
                if git branch -D "$branch"; then
                    echo "✓ Deleted branch: $branch"
                else
                    echo "✗ Failed to delete branch: $branch"
                fi
            else
                echo "⏭ Skipped branch: $branch"
            fi
            echo
        fi
    done
    
    echo "Branch cleanup completed!"
}
git_cleanup_local_branches
'

# Interactive stash manager
alias gstash='
git_stash_manager() {
    local action=$(gum choose "save" "list" "apply" "pop" "drop" "show" --header "What do you want to do with stash?")
    
    case $action in
        "save")
            local message=$(gum input --placeholder "Stash message (optional)")
            if [ -n "$message" ]; then
                git stash push -m "$message"
            else
                git stash push
            fi
            ;;
        "list")
            git stash list
            ;;
        "apply"|"pop"|"drop"|"show")
            local stashes=$(git stash list | cut -d: -f1)
            if [ -z "$stashes" ]; then
                echo "No stashes found"
                return
            fi
            local selected=$(echo "$stashes" | gum choose --header "Select stash:")
            if [ -n "$selected" ]; then
                git stash $action "$selected"
            fi
            ;;
    esac
}
git_stash_manager
'

# Interactive file finder and editor
alias ff='
file_finder() {
    local file=$(find . -type f -not -path "*/.*" -not -path "*/node_modules/*" -not -path "*/.git/*" | gum filter --placeholder "Search files...")
    
    if [ -n "$file" ]; then
        local action=$(gum choose "edit" "view" "copy-path" --header "What to do with $file?")
        case $action in
            "edit")
                ${EDITOR:-vim} "$file"
                ;;
            "view")
                cat "$file" | gum pager
                ;;
            "copy-path")
                echo "$file" | pbcopy  # macOS clipboard
                echo "Path copied to clipboard: $file"
                ;;
        esac
    fi
}
file_finder
'

# Docker container manager
alias docks='
docker_manager() {
    local action=$(gum choose "containers" "images" "compose" "cleanup" --header "Docker management:")
    
    case $action in
        "containers")
            # Get container names only, no table formatting
            local container_names=$(docker ps -a --format "{{.Names}}")
            if [ -z "$container_names" ]; then
                echo "No containers found"
                return
            fi
            
            # Create a formatted list for display
            local container_info=$(docker ps -a --format "{{.Names}} ({{.Status}}) [{{.Image}}]")
            local selected=$(echo "$container_info" | gum choose --header "Select container:")
            
            if [ -n "$selected" ]; then
                # Extract just the container name (everything before the first space)
                local container_name=$(echo "$selected" | cut -d" " -f1)
                echo "Selected container: $container_name"
                
                local container_action=$(gum choose "start" "stop" "restart" "logs" "exec" "remove" --header "Action for $container_name:")
                case $container_action in
                    "exec")
                        # Try bash first, fallback to sh
                        docker exec -it "$container_name" /bin/bash 2>/dev/null || docker exec -it "$container_name" /bin/sh
                        ;;
                    "logs")
                        docker logs -f "$container_name"
                        ;;
                    "remove")
                        if gum confirm "Remove container $container_name?"; then
                            docker rm -f "$container_name"
                        fi
                        ;;
                    *)
                        docker "$container_action" "$container_name"
                        ;;
                esac
            fi
            ;;
        "images")
            # Get image info without table headers
            local image_list=$(docker images --format "{{.Repository}}:{{.Tag}} ({{.Size}}) [{{.CreatedAt}}]")
            if [ -z "$image_list" ]; then
                echo "No images found"
                return
            fi
            
            local selected=$(echo "$image_list" | gum choose --header "Select image:")
            if [ -n "$selected" ]; then
                # Extract image name (everything before the first space/parenthesis)
                local image_name=$(echo "$selected" | cut -d" " -f1)
                echo "Selected image: $image_name"
                
                local image_action=$(gum choose "remove" "inspect" "history" --header "Action for $image_name:")
                case $image_action in
                    "remove")
                        if gum confirm "Remove image $image_name?"; then
                            docker rmi "$image_name"
                        fi
                        ;;
                    "inspect")
                        docker inspect "$image_name" | gum pager
                        ;;
                    "history")
                        docker history "$image_name"
                        ;;
                esac
            fi
            ;;
        "compose")
            # Check if docker-compose.yml exists
            if [ ! -f "docker-compose.yml" ] && [ ! -f "docker-compose.yaml" ] && [ ! -f "compose.yml" ] && [ ! -f "compose.yaml" ]; then
                echo "No docker-compose file found in current directory"
                return
            fi
            
            local compose_action=$(gum choose "up" "down" "restart" "logs" "ps" --header "Docker Compose:")
            case $compose_action in
                "up")
                    if gum confirm "Run in detached mode?"; then
                        docker compose up -d
                    else
                        docker compose up
                    fi
                    ;;
                "logs")
                    docker compose logs -f
                    ;;
                "ps")
                    docker compose ps
                    ;;
                *)
                    docker compose "$compose_action"
                    ;;
            esac
            ;;
        "cleanup")
            echo "Docker cleanup options:"
            if gum confirm "Remove stopped containers?"; then
                docker container prune -f
                echo "✓ Removed stopped containers"
            fi
            if gum confirm "Remove unused images?"; then
                docker image prune -f
                echo "✓ Removed unused images"
            fi
            if gum confirm "Remove unused networks?"; then
                docker network prune -f
                echo "✓ Removed unused networks"
            fi
            if gum confirm "Remove unused volumes? (WARNING: This may delete data!)"; then
                docker volume prune -f
                echo "✓ Removed unused volumes"
            fi
            if gum confirm "Remove build cache?"; then
                docker builder prune -f
                echo "✓ Removed build cache"
            fi
            ;;
    esac
}
docker_manager
'

# Process killer with search
alias pkill-interactive='
process_killer() {
    local processes=$(ps aux | grep -v "grep\|ps aux" | awk "{print \$2, \$11}" | tail -n +2)
    local selected=$(echo "$processes" | gum filter --placeholder "Search processes to kill...")
    
    if [ -n "$selected" ]; then
        local pid=$(echo "$selected" | awk "{print \$1}")
        local process_name=$(echo "$selected" | cut -d" " -f2-)
        
        if gum confirm "Kill process $pid ($process_name)?"; then
            kill "$pid" && echo "Process $pid killed" || echo "Failed to kill process $pid"
        fi
    fi
}
process_killer
'

function logg() {
    git lg | fzf --ansi --no-sort \
        --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % git show % --color=always' \
        --preview-window=right:50%:wrap --height 100% \
        --bind 'enter:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "git show % | nvim -c \"setlocal buftype=nofile bufhidden=wipe noswapfile nowrap\" -c \"nnoremap <buffer> q :q!<CR>\" -")' \
        --bind 'ctrl-e:execute(echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % sh -c "gh browse %")'
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

# Starship prompt
eval "$(starship init zsh)"

# Console Ninja
PATH=~/.console-ninja/.bin:$PATH

# Atuin (shell history)
eval "$(atuin init zsh)"

# Zoxide (smarter cd)
eval "$(zoxide init zsh)"

# FZF (fuzzy finder) configuration
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
# export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
# export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/jaimish/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Added by Windsurf
export PATH="/Users/jaimish/.codeium/windsurf/bin:$PATH"
