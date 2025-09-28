# My dotfiles

✨ **_This is my dotfiles. Take anything you want, but at your own risk. It mainly targets MacOS systems._** ✨

# Table contents

- [Tools](#tools)
- [CLI Replacements](#-cli-replacements)
- [Setup](#%EF%B8%8F-setup)
  - [Installing](#installing)
  - [Add configuration](#add-configuration)
    - [Configuration shell (fish)](#configuration-shell-fish)
    - [Configuration git + ssh](#configuration-git--ssh)
    - [Configuration neovim](#configuration-neovim)
  - [System Maintenance](#-system-maintenance)
    - [Update packages](#update-packages)
    - [Clean packages](#clean-packages)
    - [Checkout packages](#checkout-packages)
    - [Nodejs](#nodejs)
    - [Cmus](#cmus)
- [Show case](#show-case)

# Tools

- **Package Manager**: [Nix](./nix-darwin)
- **Terminal**: [Kitty](./kitty) / [Ghostty](./ghostty)
  - **Multiplexer**: [Tmux](./tmux)
- **Shell**: [Fish](./fish)
  - **Theme**: [Starship](./starship)
- **IDE**: [Neovim](./neovim)
- **Window Management**: [Yabai](./yabai) + [skhd](./skhd)
- **Activity Monitor**: [Btop](./btop)
- **Git**:
  - [Lazygit](./lazygit)
  - [delta](https://github.com/dandavison/delta) - a syntax-highlighting pager for git, diff, and grep output
- **File Manager**:
  - [Yazi](./yazi/)
- **Version Manager**:
  - [fnm](https://github.com/Schniz/fnm) - 🚀 fast and simple Node.js version manager, built in Rust
- **Font**: [Nerd Font](https://github.com/ryanoasis/nerd-fonts)
  - _**JetBrainsMono**_
  - [JetBrainsMono Nerd Font](https://github.com/JetBrains/JetBrainsMono)
  - [Iosevka Nerd Font](https://github.com/be5invis/Iosevka)
- **Music**: [cmus](./cmus) + [cava](./cava) + [blackhole](https://github.com/ExistentialAudio/BlackHole)
- **Keyboard Customize**: - [karabiner-elements](./karabiner) a powerful and stable keyboard customize for macOS.
- **Vietnamese Keyboard**: [OpenKey](https://github.com/tuyenvm/OpenKey)
- **Wallpapers**: [Wallpapers](./wallpapers)
- **Music**: [Music](./Music)

# ⚡ CLI Replacements

- [bat > cat ](https://github.com/sharkdp/bat)
- [fd > find](https://github.com/sharkdp/fd)
- [sd > sed](https://github.com/chmln/sd)
- [rg(ripgrep) > grep](https://github.com/BurntSushi/ripgrep)
- [eza > ls](https://github.com/eza-community/eza)
- [delta > diff](https://github.com/dandavison/delta)
- [btop > top](https://github.com/aristocratos/btop)
- [tealdeer > man](https://github.com/tealdeer-rs/tealdeer?tab=readme-ov-file)
- [duf > df](https://github.com/muesli/duf)
- [dust > du](https://github.com/bootandy/dust)
- [prettyping > ping](https://github.com/denilsonsa/prettyping)

# ⚙️ Setup

## Installing

> ⚠️ All tools and applications in this setup are installed and managed via [Nix](https://nixos.org).
> Make sure you have Nix installed before proceeding.

1. **Install Nix**
   To download the Nix package manager

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. **Clone my repo**
   To download my configuration

```sh
nix-shell -p git --run "git clone git@github.com:hungvx-dev/Dotfiles.git ~/Dev/Dotfiles"
```

3. **Apply configuration**
   To install tools and applications

```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/Dev/Dotfile/nix-darwin/feiyu
```

## Add configuration

```sh
cd ~/Dev/Dotfiles
stow .
```

### Configuration shell (fish)

- Set default shell

```sh
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

```

- Install fisher (Optional)

```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install kidonng/zoxide.fish
```

### Configuration git + ssh

- Git

```sh
cd ~/Dev/Dotfiles
ln -s $(pwd)/git/me/ ~/.config/git
ln -s $(pwd)/git/me/.gitconfig ~/.config/git/config
```

- SSH

```sh
ln -s $(pwd)/ssh/config ~/.ssh/config
```

- [Setup ssh](./ssh/guide.md)

### Configuration neovim

```sh
nix-shell -p nodejs_22 cargo
neovim
```

In neovim Run `:Mason` command and install LSPs

# 📖 Usage Guide

Here are some notes on how I use my daily tools:

## ⚡ CLI Tools

### _bat_ → Pretty _cat_ with syntax highlighting

- Pretty print the contents of one or more files to `stdout`

  `bat path/to/file1 path/to/file2 ...`

### _fd_ → Fast _find_ replacement

- Recursively find files matching a specific pattern in the current directory:

  `fd "string|regex"`

- Find files that begin with a specific string:

  `fd "^string"`

- Find files with a specific extension:

  `fd [-e|--extension] txt`

- Find files in a specific directory:

  `fd "string|regex" path/to/directory`

- Include ignored and hidden files in the search:

  `fd [-H|--hidden] [-I|--no-ignore] "string|regex"`

- Execute a command on each search result returned:

  `fd "string|regex" [-x|--exec] command`

### _rg (ripgrep)_ → Super fast _grep_ replacement

`rg [OPTIONS] PATTERN [PATH...]`

- Recursively search current directory for a pattern (`regex`):

  `rg pattern`

- Recursively search for a pattern in a file or directory:

  `rg pattern <path/to/file_or_directory>`

- Options
  - Include hidden files and entries listed in `.gitignore`:
    `[-.|--hidden] --no-ignore`

### _sk_ - Fuzzy finder written in Rust. Similar to _fzf_

- Start `skim` on all files in the specified directory:

  `fd "string|regex" path/to/directory | sk`

## 🔄 System Maintenance

### Update packages

1.  Update flake: `nix flake update`
2.  Darwin rebuild: `sudo darwin-rebuild switch --flake .`

### Clean packages

- Clean nix store: `nix store gc`
- Delete old generations(optional): `sudo nix-collect-garbage -d`
- Reset dock: `defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock`

### Checkout packages

- List generations: `sudo darwin-rebuild --list-generations`
- Rollback: `sudo darwin-rebuild switch --rollback`
- Checkout generation: `sudo darwin-rebuild switch --switch-generation <generation-number>`

### Yabai

- Configure scripting addtion: `echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai`

### Nodejs

- Enable pnpm: `corepack enable pnpm`
- Disable yarn: `corepack disable yarn`

### Cmus

- Add a Music Folder `:add /path/to/your/music`
- Rescan the Library `:update-cache`
- Remove Missing Files `:clear`
- Changing the volume in cmus `:set softvol=true`

# Show cases

## Terminal (Kitty + fish + starship)

![Terminal 1](./images/terminal.png "Title")
![Terminal 2](./images/terminal-1.png "Title")

## Search (fzf + ripgrep + fd + bat)

## Multiplexer window

![Tmux 1](./images/multiplex-window.png "Title")

## Btop

![Btop](./images/btop.png "Title")

## Neovim

![Neovim](./images/neovim.png "Title")
![Neovim](./images/nvim-info.png "Title")
![Neovim](./images/nvim-diagnotics.png "Title")
![Neovim](./images/nvim-autocomplete.png "Title")
![Neovim](./images/nvim-autocomplete-1.png "Title")

## Lazygit

![Lazygit](./images/lazygit.png "Title")
![Lazygit](./images/lazygit-1.png "Title")
![Lazygit](./images/git-log.png "Title")

## Music

![Music](./images/cmus.png "Title")
![Music](./images/cmus-cava.png "Title")

# References

## Blogs

- [CLI: Improved](https://remysharp.com/2018/08/23/cli-improved)
- [Fuzzy Finding in Vim with fzf](https://bluz71.github.io/2018/12/04/fuzzy-finding-in-vim-with-fzf.html)
- [Mike Griffin](https://mikegriffin.ie/blog/)
- [Department of Information Technology](https://www.ditig.com/)

## References

- [Installing Fish shell on MacOS (Intel and Apple Silicon) using brew](https://gist.github.com/gagarine/cf3f65f9be6aa0e105b184376f765262)
- [Installing tmux-256color for macOS](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)
- [TIL: How to Fix ”Cannot Read Termcap Database” With Tmux and Kitty on MacOs](https://www.rockyourcode.com/til-how-to-fix-cannot-read-termcap-database-with-tmux-and-kitty-on-macos/)
- [256 colors cheat sheet](https://www.ditig.com/publications/256-colors-cheat-sheet)

## Bugs

- [eslint_d: Failed to load config](https://github.com/mantoni/eslint_d.js/issues/235#issuecomment-1441222659)
## Stats

![Alt](https://repobeats.axiom.co/api/embed/2553f75046483de12d2084a332fa9743fdfd386b.svg "Repobeats analytics image")
