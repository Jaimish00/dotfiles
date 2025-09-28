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

# Television - Ultimate general purpose fuzzy finder
eval "$(tv init zsh)"

# Navi shell widget
eval "$(navi widget zsh)"

# Tre command - Enhanced tree with automatic aliasing
tre() { command tre "$@" -e && zsh-defer source "/tmp/tre_aliases_$USER" 2>/dev/null; }