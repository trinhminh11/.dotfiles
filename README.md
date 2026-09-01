# Dotfiles

My personal, intentionally simple setup for Zsh and tmux, tested on Linux (Debian-based) and macOS. Everything uses `Monokai-Classic`—I really love the theme, and if you don't, that's your problem.

Also, check out my [trinhminh11/kickstart.nvim](https://github.com/trinhminh11/kickstart.nvim). Of course, it uses `Monokai-Classic` too.

## Installation

Clone the repository to `~/.dotfiles`, then run the setup script:

```bash
git clone https://github.com/trinhminh11/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup_zsh.bash
```

That's it. `setup_zsh.bash` installs and configures everything needed for the current setup.

> The script backs up an existing `~/.zshrc` as `~/.zshrc.bak` and an existing tmux config as `tmux.conf.bak` before linking these dotfiles.

## What's inside

### Zsh

I use [sindresorhus/pure](https://github.com/sindresorhus/pure) for a super-simple prompt. No complicated framework or giant collection of plugins—just a clean shell that does what I need.

### tmux

I try to use as few plugins as possible. Right now, the only tmux plugin I really need is [mrjones2014/smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim), which makes navigation between Neovim and tmux splits seamless. It is essential to my workflow.

Technically, that means I might not need TPM at all. But who knows what the future holds? I am considering adding automatic session saving for shutdowns and reboots, so TPM stays for now.

#### Workspace and terminal sessions

I use a custom `tmux` function from [`zsh/.zshrc`](./zsh/.zshrc) to keep my editor workspace and terminal windows separate:

```text
┌─────────────────────────────┐
│ <directory>-workspace       │
│ ┌─────────────────────────┐ │
│ │                         │ │
│ │          Neovim         │ │
│ │                         │ │
│ └─────────────────────────┘ │
│ ┌─────────────────────────┐ │
│ │ <directory>-term        │ │
│ │ multiple terminal       │ │
│ │ windows                 │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

Running `tmux` by itself creates or attaches to a session named `<directory>-workspace` on the isolated `workspace` server. I keep this session simple: it is my editor workspace, and I do not intend to use multiple windows inside it.

While inside that workspace, pressing ``Ctrl+`​`` opens a small pane at the bottom and starts another tmux session named `<directory>-term` on the separate `term` server. This inner session is where I keep multiple terminal windows.

Why nested tmux? I picked up the habit from VS Code, where one editor can have a terminal panel with several terminal tabs. A normal tmux layout does not give me quite the same separation. The inner session keeps the editor workspace clean, gives the terminal panel its own windows, and keeps both away from the default tmux server.

#### Keymaps

The main workspace prefix is `Ctrl-s`. The inner terminal session uses `Ctrl-t`, so its commands do not collide with the outer session.

| Key | Action |
| --- | --- |
| `Ctrl-s` | Prefix for the outer tmux session (workspace) |
| `Ctrl-t` | Prefix for the inner tmux session (terminal) |
| `Ctrl-h/j/k/l` | Move left, down, up, or right across tmux panes and Neovim splits |
| `Alt-h/j/k/l` | Resize the current pane in the corresponding direction |
| `Prefix-h/j/k/l` | Create a 20% split to the left, below, above, or right |
|  ``Ctrl+`​``| Open the 20% terminal pane and start the inner tmux session |
| `Ctrl-Tab` / `Ctrl-Shift-Tab` | Move to the next or previous window—mostly used in the terminal session |
| `Prefix-n` | Create a new window |
| `Prefix-c` | Close the current pane |
| `Prefix-r` | Reload the current tmux config |

Copy mode uses Vim-style bindings:

| Key | Action |
| --- | --- |
| `Prefix-v` | Enter copy mode |
| `v` | Start a selection |
| `Ctrl-v` | Toggle rectangular selection |
| `y` | Copy the selection to the system clipboard and leave copy mode |

## Philosophy

Keep the configuration simple, keep the plugin count low, and only add something when it genuinely improves the workflow.
