#===============================================================================
# ENVIRONMENT VARIABLES
#===============================================================================

# Add custom paths
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.zsh/plugins/git-extra-commands/bin:$PATH"
export PATH="$PATH:~/Users/jaimish/.temporalio/bin"
# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Language
export LANG="en_US.UTF-8"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Disable less history
export LESSHISTFILE=-

# Python
export PYTHONPATH="$PYTHONPATH:$HOME/.local/lib/python3.*/site-packages"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Add any other environment variables here
