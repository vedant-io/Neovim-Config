<div align="center">

# My Neovim Setup

</div>

<p align="center">
  <img src="https://img.shields.io/badge/Neovim-0.9.1-57A143?style=for-the-badge&logo=neovim&logoColor=white" alt="Neovim Version" />
  <img src="https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white" alt="Made with Lua" />
</p>

<p align="center">
  A meticulously crafted Neovim configuration designed for a powerful and efficient development workflow.
</p>

---

## 🌟 Features

- **Fast & Lightweight**: Optimized for speed with lazy-loading plugins via `lazy.nvim`.
- **Modern UI**: A beautiful and functional interface using Catppuccin, Lualine, and Bufferline.
- **Powerful Development Tools**: Packed with features for LSP, autocompletion, formatting, and Git integration.
- **Intuitive Navigation**: Seamlessly navigate your projects with Nvim-Tree and Telescope.
- **Extensible**: Easily customize and add your own plugins and settings.

## 📋 Prerequisites

- [Neovim](https://github.com/neovim/neovim/releases/tag/v0.9.1) (v0.9.1 or higher)
- [Git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## 🚀 Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/your-nvim-config.git ~/.config/nvim
    ```

2.  **Launch Neovim:**

    ```bash
    nvim
    ```

    `lazy.nvim` will automatically handle the installation of all plugins.

## 🧩 Plugins

This configuration is built upon a collection of high-quality plugins. Here are some of the key players:

| Plugin | Description |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | A modern plugin manager for Neovim |
| [Catppuccin](https://github.com/catppuccin/nvim) | A soothing pastel theme for the high-spirited programmer |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | A blazing fast and easy to configure statusline |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | A file explorer for Neovim written in Lua |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | A highly extendable fuzzy finder over lists |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | A collection of common configurations for the Nvim LSP client |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | A completion engine plugin for Neovim |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | A plugin for interacting with Git |

... and many more!

## ⌨️ Key-bindings

This configuration uses the `<Space>` key as the leader key.

### General

| Keybinding | Action |
|---|---|
| `<leader>e` | Toggle file explorer |
| `<leader><leader>` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |

### Git

| Keybinding | Action |
|---|---|
| `<leader>lg` | Open Lazygit |

---