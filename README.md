### Dotfiles Configuration

This is a collection of dotfiles for various use cases.

#### Configurations

- `zsh` : zsh configuration
- `atuin` : Atuin configuration
- `starship.toml` : Starship configuration
- `jupyter` : Jupyter configuration
- `warp` : Warp configuration
- `superfile` : Superfile configuration
- `wallpapers`: Favorite wallpapers

#### Setup

1. Clone this repo

```
git clone https://github.com/jaimish/dotfiles.git ~/dotfiles
```

2. Install stow if you haven't already

```
brew install stow  # for macOS
```

3. Now whatever configuration you want to stow back, run this command

```
cd ~/dotfiles
stow zsh  # syncing zsh configuration
```

4. Now you can edit the files in the cloned repo and they will be stowed back

5. To remove the stowed files, run this command

```
cd ~/dotfiles
stow -D zsh  # removing zsh configuration from stow tracking
```

6. To stow a new set of files, run this command

```
# Adding symlinks to stow tracking your dotfiles
stow --adopt .
```
