# My dotfiles

**_This repository contains my config dot files for applications:_**

- **Terminal**: [Kitty](./kitty) (or [Alacritty](./alacritty))
  - **Multiplexer**: [Tmux](./tmux)
  - **Theme**: [Starship](./starship)
- **Shell**: [Fish](./fish) (or [Zsh](./zsh))
- **IDE**: [Neovim](./neovim)
- **WindowManagement**: [Yabai](./yabai)
  - **Hotkey**: [skhd](./skhd)
- **Git commands UI**: [Lazygit](./lazygit)
- **Font**: [Nerd Font](https://github.com/ryanoasis/nerd-fonts) [CaskaydiaCove](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode)
- **Music**: [cmus](https://github.com/cmus/cmus) [cava](./cava) [Background Music](https://github.com/kyleneideck/BackgroundMusic)

## Install + setup

Clone this repository:

```bash
git clone git@github.com:hungvx-dev/Dotfiles.git
cd Dotfiles
```

Run these commands to install and setup for Mac OS

```bash
chmode -R +x ./bootstrap/macos && ./bootstrap/macos/init.sh
```

## Show cases

### Terminal (Kitty + fish + starship + fzf)

![Alt text](./images/terminal.png "Title")
![Alt text](./images/terminal-1.png "Title")

### Tmux sessions

![Alt text](./images/tmux.png "Title")
![Alt text](./images/tmux-2.png "Title")

### Neovim

![Alt text](./images/neovim.png "Title")
![Alt text](./images/nvim-info.png "Title")
![Alt text](./images/nvim-diagnotics.png "Title")
![Alt text](./images/nvim-autocomplete.png "Title")

### Lazygit

![Alt text](./images/lazygit.png "Title")
![Alt text](./images/lazygit-1.png "Title")
![Alt text](./images/git-log.png "Title")

### Music

![Alt text](./images/cmus.png "Title")

## References

- [Installing Fish shell on MacOS (Intel and M2) using brew](https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262)
- [Installing tmux-256color for macOS](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)
