### Dotfiles Configuration

This is a collection of dotfiles for various use cases.

#### Configurations

- `zsh` : zsh configuration
- `nvim` : Neovim Configuration
- `atuin` : Atuin configuration
- `starship` : Starship configuration
- `jupyter` : Jupyter configuration
- `warp` : Warp configuration
- `superfile` : Superfile configuration
- `wallpapers`: Favorite wallpapers
- `tmux`: Tmux Configuration


#### Setup

1. Clone this repo

```bash
git clone https://github.com/jaimish/dotfiles.git ~/dotfiles
```

2. Install stow if you haven't already

```bash
brew install stow  # for macOS
```

3. Now whatever configuration you want to stow back, run this command

```bash
cd ~/dotfiles
stow zsh  # syncing zsh configuration
stor <placeholder>  # Replace the name from above list
```

4. Now you can edit the files in the cloned repo and they will be stowed back

5. To remove the stowed files, run this command

```bash
cd ~/dotfiles
stow -D zsh  # removing zsh configuration from stow tracking
```

6. To stow a new set of files, run this command

```bash
# Adding symlinks to stow tracking your dotfiles
stow --adopt .
```


#### Stowing a new configuration

1. We need to first replicate the directory structure, for example if tmux is in `.config/nvim` then we need to have `dotfiles/nvim/.config/nvim`

```bash
mkdir -p ~/dotfiles/tmux/.config/tmux && mv ~/.config/tmux/* ~/dotfiles/tmux/.config/tmux
```

2. Then inside dotfiles, just run this command

```bash
stow tmux

# If you face conflict, try with --adopt flag
# stow --adopt tmux
```
