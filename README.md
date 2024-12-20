# My dotfiles

**_These are my dotfiles. Take anything you want, but at your own risk._**
**_It mainly targets macOS systems_**
**_This repository contains my configuration for applications:_**

## Tools

- **Terminal**: [Kitty](./kitty) (or [Alacritty](./alacritty))
  - **Multiplexer**: [Tmux](./tmux)
  - **Theme**: [Starship](./starship)
- **Shell**: [Fish](./fish) (or [Zsh](./zsh))
- **IDE**: [Neovim](./neovim)
- **Window Management**: [Yabai](./yabai) + [skhd](./skhd) / [Aerospace](./aerospace)
- **Activity Monitor**: [Btop](./btop)
- **Git**:
  - CLI: [Lazygit](./lazygit)
  - [delta](https://github.com/dandavison/delta) - a syntax-highlighting pager for git, diff, and grep output
- **Version Manager**:
  - [fnm](https://github.com/Schniz/fnm) - 🚀 fast and simple Node.js version manager, built in Rust
- **Font**: [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
  - _**JetBrainsMono**_
  - [JetBrainsMono Nerd Font](https://github.com/JetBrains/JetBrainsMono)
  - [Iosevka Nerd Font](https://github.com/be5invis/Iosevka)
- **Music**: [cmus](https://github.com/cmus/cmus) + [cava](./cava) + [Loopback](https://rogueamoeba.com/loopback/)
- **Keyboard Customize**: - [karabiner-elements](https://karabiner-elements.pqrs.org/) a powerful and stable keyboard customize for macOS.
- **Vietnamese Keyboard**: [OpenKey](https://github.com/tuyenvm/OpenKey)
- **Wallpapers**: [My wallpapers](./wallpapers)

## Install + setup

Clone this repository:

```bash
git clone git@github.com:hungvx-dev/Dotfiles.git
cd Dotfiles
```

Run these commands to install and setup for Mac OS

```bash
chmod -R +x ./bootstrap/macos && ./bootstrap/macos/init.sh
```

## Node

- Enable pnpm: `corepack enable pnpm`
- Disable yarn: `corepack disable yarn`

## Show cases

### Terminal (Kitty + fish + starship)

![Terminal 1](./images/terminal.png "Title")
![Terminal 2](./images/terminal-1.png "Title")

### Search (fzf + ripgrep + fd + bat)

### Multiplexer window

![Tmux 1](./images/multiplex-window.png "Title")

### Btop

![Btop](./images/btop.png "Title")

### Neovim

![Neovim](./images/neovim.png "Title")
![Neovim](./images/nvim-info.png "Title")
![Neovim](./images/nvim-diagnotics.png "Title")
![Neovim](./images/nvim-autocomplete.png "Title")
![Neovim](./images/nvim-autocomplete-1.png "Title")

### Lazygit

![Lazygit](./images/lazygit.png "Title")
![Lazygit](./images/lazygit-1.png "Title")
![Lazygit](./images/git-log.png "Title")

### Music

![Music](./images/cmus.png "Title")
![Music](./images/cmus-cava.png "Title")

## References

- [Installing Fish shell on MacOS (Intel and M2) using brew](https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262)
- [Installing tmux-256color for macOS](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)

## Bugs

- [eslint_d: Failed to load config](https://github.com/mantoni/eslint_d.js/issues/235#issuecomment-1441222659)
