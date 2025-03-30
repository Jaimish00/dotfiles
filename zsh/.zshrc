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
	
	# Navigation and file management
	zsh-interactive-cd
	wd
	k
	copyfile
	copybuffer
	
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
alias n="nvim"

# File listing (using eza with enhanced formatting)
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
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

# Project-specific aliases
alias reset-ops="make reset-migrate && make down && make up && sleep 10 && curl --location --request POST 'http://localhost:3567/recipe/dashboard/user' \
--header 'rid: dashboard' \
--header 'Content-Type: application/json' \
--data-raw '{"email": "jaimish+admin@opshealth.io","password": "local123"}'"

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
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Tre command - Enhanced tree with automatic aliasing
tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

# UV (Python package installer)
eval "$(uv generate-shell-completion zsh)"

# pipx path (added on 2025-01-13)
export PATH="$PATH:/Users/jaimish/.local/bin"

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

# ZSH Completions for Homebrew
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#   autoload -Uz compinit
#   compinit
# fi

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
