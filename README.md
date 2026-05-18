# Dotfiles

Quick guide to install and use these dotfiles.

Prerequisites
- `stow` (GNU Stow) installed. On macOS you can install it via Homebrew:

```bash
brew install stow
```

Notes
- Current stable-tested environment: Linux (Debian-based).
- It's preferable to run `scripts/setup.sh` first, but it's fine to skip.
- The repository must be located at `~/.dotfiles`.
 - If you have an existing `~/.zshrc`, move or back it up **before** running `stow zsh` — Stow will create symlinks and can conflict with an existing `~/.zshrc`.
     Example:

```bash
cp ~/.zshrc ~/.zshrc.backup
rm ~/.zshrc
```

Install
1. Open a terminal and change to the repo:

```bash
cd ~/.dotfiles
```

2. Stow the zsh configuration:

```bash
stow zsh
```

That's all — then switch to using `zsh` as your shell (e.g., `chsh -s $(which zsh)`), or start a new terminal.

Layout & Notes
- All the core logic lives in `~/.core.zshrc`.
- Your `~/.zshrc` will source `~/.core.zshrc`.
- Additional additions to `~/.zshrc` may come from other libraries or programs you add.

Troubleshooting
- Ensure the repository is checked out to `~/.dotfiles` and that `stow` has write access to your home directory.

If you want, I can also add a small checklist to automate the setup steps.
# Dotfiles Installation Guide

This guide helps you install your dotfiles using [GNU Stow](https://www.gnu.org/software/stow/). It also covers installing dependencies via Homebrew (macOS) or your Linux package manager.

## Prerequisites

### macOS

1. **Install Homebrew** (if not already installed):
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. **Install Stow**:
    ```sh
    brew install stow
    ```

### Linux

1. **Install Stow** (Debian/Ubuntu):
    ```sh
    sudo apt update
    sudo apt install stow
    ```
    **Fedora:**
    ```sh
    sudo dnf install stow
    ```
    **Arch:**
    ```sh
    sudo pacman -S stow
    ```

## Installing Dotfiles

1. **Clone your dotfiles repository:**
    ```sh
    git clone https://github.com/trinhminh11/.dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2. **Use Stow to symlink configuration files:**
    ```sh
    stow <package>
    ```
    Replace `<package>` with the folder name (e.g., `bash`, `vim`, `git`, etc.).

    Example:
    ```sh
    stow zsh
    stow aliases
    ```

## Notes

- Each package (e.g., `bash`, `vim`) should be a directory containing config files.
- Stow will symlink files into your home directory.

---

Happy customizing!
