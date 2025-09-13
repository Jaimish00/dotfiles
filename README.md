# Dotfiles Configuration

This is a collection of dotfiles for various use cases.

## Configurations

- `zsh` : Zsh shell configuration, plugins, and aliases
- `nvim` : Neovim configuration and plugins
- `atuin` : Atuin shell history configuration
- `starship` : Starship prompt configuration
- `jupyter` : Jupyter Notebook/Lab configuration
- `warp` : Warp terminal configuration
- `superfile` : Superfile configuration
- `wallpapers` : Favorite wallpapers
- `tmux` : Tmux configuration and sessions
- `bat` : Bat syntax-highlighting theme and config
- `bpytop` : Bpytop system monitor configuration and themes
- `ghostty` : Ghostty terminal emulator configuration

## Setup

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
   stow <placeholder>  # Replace the name from above list
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

## Stowing a new configuration

1. We need to first replicate the directory structure, for example if tmux is in `.config/tmux` then we need to have `dotfiles/tmux/.config/tmux`

   ```bash
   mkdir -p ~/dotfiles/tmux/.config/tmux && mv ~/.config/tmux/* ~/dotfiles/tmux/.config/tmux
   ```

2. Then inside dotfiles, just run this command

   ```bash
   stow tmux

   # If you face conflict, try with --adopt flag
   # stow --adopt tmux
   ```

## Stowing and Unstowing using Aliases

   ```
   dotstow eza
   dotunstow lazyeza
   ```

## Screenshots

### starship
<img width="500" height="111" alt="image" src="https://github.com/user-attachments/assets/859ae7bd-e870-49f2-bcb7-4019dc30bc0f" />


### atuin
<img width="500" height="774" alt="image" src="https://github.com/user-attachments/assets/37e2053f-8b22-4b89-a9dc-9f72d3b377cb" />

### bpytop
<img width="500" height="945" alt="image" src="https://github.com/user-attachments/assets/6fcfdd04-56d3-42da-95b4-63cac5aa1411" />


### Jupyter Lab
<img width="500" height="944" alt="image" src="https://github.com/user-attachments/assets/8856237d-83c9-474c-bd71-55f77d939f31" />

### Superfile
<img width="500" height="942" alt="image" src="https://github.com/user-attachments/assets/35d925a0-960b-4688-aede-ea0d5eee6701" />

### Bat
<img width="500" height="414" alt="image" src="https://github.com/user-attachments/assets/bbb5ee0b-22c6-4b7e-b2bd-2833d7332ec7" />

### Tmux
<img width="500" height="899" alt="image" src="https://github.com/user-attachments/assets/fb3517f9-8337-41ca-8b53-bc2eadce219f" />

