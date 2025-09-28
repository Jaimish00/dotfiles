# Zsh Configuration Guide

This is a comprehensive Zsh configuration setup with various plugins, aliases, and utilities to enhance your shell experience.

## Overview

This configuration includes:

- Modular Zsh setup with separate files for organization
- Syntax highlighting and autosuggestions
- Git integration with extensive aliases
- macOS-specific utilities
- Base64 encoding/decoding
- FZF integration for fuzzy finding
- Custom aliases and functions
- Completion system setup

## File Structure

```bash
.zshrc                     # Main Zsh configuration
.zsh/
├── README.md              # This guide
├── env.zsh                # Environment variables
├── aliases.zsh            # Custom aliases
├── functions.zsh          # Custom functions
├── keybindings.zsh        # Key bindings and completion setup
├── external.zsh           # External tool integrations
├── fzf.zsh                # FZF configuration
├── additional.zsh         # Additional tool configurations
├── completions/           # Custom completion files
│   ├── _atuin             # Atuin completions
│   ├── _bun               # Bun completions
│   ├── _delta             # Delta completions
│   ├── _docker            # Docker completions (Docker CLI)
│   └── _httpie            # HTTPie completions
└── plugins/               # Zsh plugins
    ├── aliases/           # Alias management plugin
    ├── brew.zsh           # Brew aliases
    ├── copybuffer.zsh     # Copy buffer utilities
    ├── copyfile.zsh       # File copying utilities
    ├── docker.zsh         # Docker aliases
    ├── encode64/          # Base64 encoding plugin
    ├── eza.zsh            # Eza (modern ls) aliases
    ├── fzf-tab/           # FZF tab completion
    ├── git.zsh            # Git aliases and functions
    ├── macos.zsh          # macOS utilities
    │   ├── music          # Music/iTunes control
    │   └── spotify        # Spotify control
    ├── python.zsh         # Python utilities
    ├── zsh-autosuggestions/  # ZSH autosuggestions
    ├── zsh-defer/            # ZSH deferred loading
    └── zsh-syntax-highlighting/  # ZSH syntax highlighting
```

## Installation

1. Clone or copy this `.zsh` directory to your home directory
2. Source the main configuration in your `.zshrc`:

    ```zsh
    # Add to your ~/.zshrc
    source ~/.zsh/env.zsh
    # ... other sources as in the main .zshrc
    ```

3. Restart your Zsh session or run `source ~/.zshrc`

## Key Features

### Plugins

#### Core Plugins

- **zsh-syntax-highlighting**: Syntax highlighting for commands
- **zsh-autosuggestions**: Fish-like autosuggestions
- **zsh-defer**: Deferred loading for performance
- **fzf-tab**: FZF-powered tab completion

#### Utility Plugins

- **git**: Extensive git aliases and functions
- **macos**: macOS-specific utilities and app controls
- **encode64**: Base64 encoding/decoding
- **aliases**: Alias management and cheatsheet

### Git Integration

The git plugin provides numerous aliases:

#### Branch Management

- `gco <branch>` - Checkout branch
- `gcb <branch>` - Create and checkout branch
- `gbda` - Delete merged branches
- `gbm <name>` - Move/rename branch

#### Commit Operations

- `gc <message>` - Commit with message
- `gca` - Commit all changes
- `gcm` - Checkout main branch
- `gcd` - Checkout develop branch

#### Status and Info

- `gst` - Git status
- `gl` - Git log
- `gd` - Git diff
- `gds` - Git diff staged

#### Remote Operations

- `gp` - Git push
- `gpf` - Git push force
- `gpr` - Git pull rebase
- `gf` - Git fetch

### macOS Utilities

#### Finder Integration

- `ofd` - Open current directory in Finder
- `pfd` - Print Finder directory
- `pfs` - Print Finder selection

#### Terminal Management

- `tab` - Open new terminal tab
- `vsplit_tab` - Vertical split tab
- `split_tab` - Horizontal split tab

#### System Controls

- `showfiles` - Show hidden files in Finder
- `hidefiles` - Hide hidden files in Finder
- `btrestart` - Restart Bluetooth

#### Media Controls

- `music` - Control Music/iTunes app
- `spotify` - Control Spotify app

### Aliases

#### Navigation

- `..` - Go up one directory
- `...` - Go up two directories
- `....` - Go up three directories

#### File Operations

- `ls` - Enhanced ls with icons (via eza)
- `lt` - Tree view
- `cp` - Copy with confirmation
- `mv` - Move with confirmation
- `rm` - Remove with confirmation

#### System

- `c` - Clear screen
- `h` - History
- `path` - Show PATH
- `now` - Current time
- `nowdate` - Current date

### Completions

Custom completions are provided for:

- Delta (diff tool)
- Bun (JavaScript runtime)
- Docker
- HTTPie
- Atuin (shell history)

## Customization

### Adding New Aliases

Edit `aliases.zsh` to add your own aliases:

```zsh
# Example
alias myalias="command --options"
```

### Modifying Environment Variables

Edit `env.zsh` to set your preferred environment variables:

```zsh
export EDITOR="your_editor"
export PATH="$HOME/custom/bin:$PATH"
```

### Adding Plugins

1. Place plugin files in `plugins/`
2. Source them in the main `.zshrc`
3. Update the plugins array if needed

## Troubleshooting

### Common Issues

#### compdef errors

If you see "command not found: compdef", ensure `compinit` is called before plugins that use completions.

#### Plugin not loading

Check that the plugin file exists and the source path is correct in `.zshrc`.

#### Completions not working

Ensure `~/.zsh/completions` is in your `fpath` and `compinit` has been run.

### Performance

If startup is slow, consider using `zsh-defer` for non-essential plugins:

```zsh
zsh-defer source ~/.zsh/plugins/slow-plugin.zsh
```

## Dependencies

This configuration assumes you have installed:

- Zsh
- Git
- FZF
- Eza (modern ls replacement)
- Delta (diff tool)
- Various command-line tools as needed

## Contributing

Feel free to modify and extend this configuration. If you add useful features, consider updating this README.

## License

This Zsh configuration is provided as-is. Check individual plugin licenses for their respective terms.
