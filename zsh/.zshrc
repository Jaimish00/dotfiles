#===============================================================================
# ZSH CONFIGURATION
#===============================================================================

# Load zsh-defer for async loading
source ~/.zsh/plugins/zsh-defer/zsh-defer.plugin.zsh

# Completions
fpath+=(~/.zsh/completions)
autoload -Uz compinit
compinit

#===============================================================================
# ENVIRONMENT VARIABLES
#===============================================================================

source ~/.zsh/env.zsh

# fzf-tab
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# zsh syntax highlighting
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# you-should-use (brew specific)
source $HOMEBREW_PREFIX/share/zsh-you-should-use/you-should-use.plugin.zsh

# Additional plugins
source ~/.zsh/plugins/git.zsh
source ~/.zsh/plugins/copyfile.zsh
source ~/.zsh/plugins/copybuffer.zsh
source ~/.zsh/plugins/brew.zsh
source ~/.zsh/plugins/aliases/aliases.plugin.zsh
source ~/.zsh/plugins/docker.zsh
source ~/.zsh/plugins/eza.zsh
source ~/.zsh/plugins/macos.zsh
source ~/.zsh/plugins/python.zsh
source ~/.zsh/plugins/encode64/encode64.plugin.zsh

# Zsh plugins
# manual - Installed in ``plugins/`` directory
# brew specific - Installed via Homebrew
plugins=(
	git  # manual
	python # manual
	command-not-found # manual, not working
	copyfile # manual
	copybuffer # manual
	fzf-tab # manual
	bgnotify # brew specific
	git-extras # brew specific
	zsh-autosuggestions # manual
	zsh-syntax-highlighting # manual
	brew # manual
	docker # manual
	eza # manual
	macos # manual
	encode64 # manual
)

# Command execution time
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_COLOR="yellow"

#===============================================================================
# KEY BINDINGS
#===============================================================================

source ~/.zsh/keybindings.zsh

#===============================================================================
# ALIASES
#===============================================================================

source ~/.zsh/aliases.zsh

#===============================================================================
# FUNCTIONS
#===============================================================================

source ~/.zsh/functions.zsh

#===============================================================================
# EXTERNAL TOOLS INTEGRATION
#===============================================================================

source ~/.zsh/external.zsh

#===============================================================================
# FZF CONFIGURATION
#===============================================================================

source ~/.zsh/fzf.zsh

#===============================================================================
# ADDITIONAL TOOLS
#===============================================================================

source ~/.zsh/additional.zsh
