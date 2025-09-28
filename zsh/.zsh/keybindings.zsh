#===============================================================================
# KEY BINDINGS
#===============================================================================

# Auto-suggestions bindings
zsh-defer source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

# Completions
fpath+=(~/.zsh/completions)
autoload -Uz compinit
compinit