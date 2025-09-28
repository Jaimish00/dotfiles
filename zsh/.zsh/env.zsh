#===============================================================================
# ENVIRONMENT VARIABLES
#===============================================================================

# Add custom paths
export PATH="$HOME/bin:$PATH"

# Editor
export EDITOR="code"

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