# Neovim Configuration

A personal Neovim configuration written in Lua and built on top of Neovim's
native `vim.pack` plugin manager (Neovim 0.12+) plus a curated set of plugins
for a modern and efficient development experience.

## Table of Contents
- [Features](#features)
- [File Structure](#file-structure)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
- [Plugins](#plugins)
  - [Core](#core)
  - [Appearance & UI](#appearance--ui)
  - [Editing & Motions](#editing--motions)
  - [File Management](#file-management)
  - [Completions & LSP](#completions--lsp)
  - [Formatting](#formatting)
  - [Treesitter](#treesitter)
  - [Git](#git)
  - [Tools](#tools)

## Features

*   **Plugin Manager**: Uses Neovim's built-in `vim.pack` for fast startup and
    dependency-free plugin management (no external manager required).
*   **Lazy Loading**: Non-essential plugins are scheduled after `VimEnter` to
    keep startup time minimal.
*   **Editing Features**: Autocompletion (blink.cmp), snippets, auto-pairing,
    surrounding, improved text objects, and yank history/cycling.
*   **LSP**: Full LSP support via `nvim-lspconfig` (using the new
    `vim.lsp.enable` API) for diagnostics, code actions, hover, rename, and
    more.
*   **Formatting**: Automatic formatting on save and on demand with
    `conform.nvim`.
*   **File Navigation**: Edit the filesystem like a buffer with `oil.nvim`, and
    fuzzy-find everything with `fzf-lua`.
*   **Git Integration**: Inline git signs, hunk staging/resetting, and blame via
    `gitsigns.nvim`.
*   **Custom Statusline**: A hand-written, dependency-free statusline
    (`lua/plugins/status.lua`) showing mode, git state, diagnostics, filetype,
    and cursor position.
*   **Treesitter**: Auto-installs parsers for newly opened file types.

## File Structure

```
nvim/
├── init.lua                    -- Entry point: enables loader and requires modules
├── lua/
│   ├── options.lua             -- Core editor options and diagnostics
│   ├── keymaps.lua             -- Global keymaps
│   ├── autocmds.lua            -- Autocmds (relative numbers, auto-save, yank highlight)
│   ├── packages.lua            -- vim.pack bootstrap and plugin entry points
│   └── plugins/
│       ├── alpha.lua           -- Dashboard / startup screen
│       ├── completions.lua     -- blink.cmp, mini.nvim modules, gitsigns
│       ├── fzf.lua             -- fzf-lua fuzzy finder and pickers
│       ├── lang.lua            -- LSP config and conform.nvim formatting
│       ├── status.lua          -- Custom hand-written statusline
│       ├── theme.lua           -- Colorscheme (nord) and transparent backgrounds
│       ├── treesitter.lua      -- Treesitter config and auto-install
│       └── yanky.lua           -- Yank history and snacks.nvim picker
└── nvim-pack-lock.json         -- Locked plugin revisions for vim.pack
```

## Installation

### Prerequisites

Before you begin, ensure you have the following external dependencies installed:

*   [**Neovim**](https://github.com/neovim/neovim/wiki/Installing-Neovim) (**v0.12.0 or newer** — required for `vim.pack`, `vim.lsp.enable`, and `vim.loader`)
*   [**Git**](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
*   [**fzf**](https://github.com/junegunn/fzf#installation) (fuzzy finder backend for `fzf-lua`)
*   [**ripgrep**](https://github.com/BurntSushi/ripgrep#installation) (for `fzf-lua` live grep)
*   [**fd**](https://github.com/sharkdp/fd#installation) (for `fzf-lua` file finding)
*   [**A Nerd Font**](https://www.nerdfonts.com/font-downloads) (for icons)
*   [**tree-sitter CLI**](https://github.com/tree-sitter/tree-sitter) (used by `nvim-treesitter` to build parsers; a C compiler such as `gcc`/`clang` may also be required to compile them)

### Setup

1.  Clone this repository to your Neovim configuration directory (e.g.,
    `~/.config/nvim`):
    ```bash
    git clone https://github.com/mathaimp/nvim.git ~/.config/nvim
    ```
2.  Start Neovim. `vim.pack` will automatically clone the required plugins on
    first launch.
3.  (Optional) Update all plugins to their latest locked/pinned revisions:
    ```vim
    :lua vim.pack.update()
    ```
4.  **Manually install your language servers and formatters.** This config does
    *not* use an auto-installer (no `mason.nvim`). Install the tools you need on
    your system, e.g.:
    *   Language servers (`lua_ls`, `ty`, `rust-analyzer`, `nixd`) — configured
        in `lua/plugins/lang.lua`.
    *   Formatters (`stylua`, `ruff`, `nixfmt`) — configured in
        `lua/plugins/lang.lua`.

## Plugins

### Core

| Plugin | Description                               |
| ------ | ----------------------------------------- |
| `vim.pack` (Neovim built-in) | Native plugin manager introduced in Neovim 0.12; no external manager needed |

### Appearance & UI

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) | A fast and fully programmable startup dashboard |
| [gbprod/nord.nvim](https://github.com/gbprod/nord.nvim) | The Nord colorscheme for Neovim      |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons (Nerd Font)          |
| [folke/noice.nvim](https://github.com/folke/noice.nvim) | Better UI for commandline and search          |
| `lua/plugins/status.lua` (custom)          | Hand-written statusline with mode, git, diagnostics, filetype, and cursor info |

### Editing & Motions

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim) | `mini.pairs`, `mini.ai`, `mini.surround`, `mini.jump`, `mini.files` |
| [gbprod/yanky.nvim](https://github.com/gbprod/yanky.nvim) | Improved yank/put with history and cycling |
| `nvim.undotree` (`packadd`)                | Visualize and browse the undo history     |

### File Management

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim) | Edit the filesystem like a Neovim buffer |

### Completions & LSP

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | A fast, Rust-powered completion engine |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Preconfigured snippet collection     |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configurations for Neovim's LSP client |

> **Configured language servers** (`vim.lsp.enable`): `lua_ls`, `ty`,
> `rust_analyzer`, `nixd`.

### Formatting

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Lightweight yet powerful formatter, with format-on-save |

> **Configured formatters**: `stylua` (Lua), `ruff_format` (Python), `nixfmt`
> (Nix); falls back to LSP formatting when no formatter is set.

### Treesitter

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Treesitter configs; auto-installs parsers for new file types |

### Git

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs, hunk actions, and blame |

### Tools

| Plugin                                     | Description                               |
| ------------------------------------------ | ----------------------------------------- |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | A high-performance fuzzy finder built on `fzf` |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | Picker and assorted QoL utilities (used for yank history) |
| [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless navigation between tmux panes and Neovim splits |
