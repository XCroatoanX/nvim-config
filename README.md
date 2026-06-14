# nvim-config
My custom, high-performance Neovim configuration built with native packages.

![Neovim Screenshot](https://github.com/XCroatoanX/nvim-config/blob/master/nvim-screenshot.png?raw=true)

## Prerequisites

For this configuration to run flawlessly, ensure the following native binaries are pre-installed on your system:

* Core Builders: git, rust (cargo), and system build essentials (base-devel or build-essential) for compiling native extensions.
* System Finders: fd (modern find tool) and ripgrep (rg for live grepping).
* Git Interface: lazygit
* Font: A patched Nerd Font (e.g., Fira Code Nerd Font) to render structural symbols and file icons properly.

## Installation & Setup

1. Make sure you have Neovim (v0.12+) installed.
2. Clone this repository directly into your Neovim configuration directory:

   Linux / macOS:
   git clone [https://github.com/XCroatoanX/nvim-config.git](https://github.com/XCroatoanX/nvim-config.git) ~/.config/nvim/

   Windows:
   git clone [https://github.com/XCroatoanX/nvim-config.git](https://github.com/XCroatoanX/nvim-config.git) ~/AppData/Local/nvim/

3. Open Neovim. The native package architecture (vim.pack) will automatically fetch, link, and compile required plugin libraries (including compiling the ultra-fast Rust fuzzy-matching engine for blink.cmp).

---

## Component Cheatsheet

### 📂 File Management (nvim-tree)
* Ctrl + e : Toggle file tree sidebar explorer.
* a : Create a new file or directory inside the active folder.
* r : Rename a file or folder.
* Enter : Open selected file or expand directory tree.

### 🔍 Search & Discovery (telescope.nvim & snacks.nvim)
* <leader>ff : Find files (automatically anchored to the project root directory).
* <leader>fg : Live grep search string across the project.
* <leader>fb : List active open buffers.
* <leader>fo : Show recently opened files history.
* <leader>fh : Search native Neovim help tags.

### 🤖 AI Engineering (opencode.nvim & Native Copilot)
* <leader>oa : Ask Opencode an LLM question about the active context buffer (@this).
* <leader>ox : Open the interactive action selection menu.
* Ctrl + . : Toggle the integrated Opencode processing terminal panel.
* go / goo : Add an operator range or targeted line directly into the context pool.
* Shift + Ctrl + u / Shift + Ctrl + d : Scroll the AI feedback panel up or down.
* <a-a> : (Inside Snacks Picker) Stream selected files straight to your active AI session.

> Copilot Configuration: Run :LspCopilotSignIn within any active workspace buffer to authenticate your connection. Run :LspCopilotSignOut to disconnect.

### ⚡ Autocompletion (blink.cmp)
* <CR> : Accept highlighted autocompletion entry.
* <Tab> / <S-Tab> : Step forward or step backward through active completion choices and snippets.

### 🌳 Structural Code Control (Treesitter)
* Ctrl + Space : Initialize target selection scope / Expand active node context outward.

### 🛠️ Diagnostics & Code Health (trouble.nvim)
* <leader>xx : Toggle the aggregate global diagnostics layout panel.
* <leader>xX : Filter diagnostics down strictly to the local active buffer file.
* <leader>xq : Toggle local quickfix output list.

### ⚙️ Package Management & LSP Configuration (mason.nvim)
* Execute :Mason to open the package server controller.
* LSP setups are automatically wired up to track active packages via mason-lspconfig.

### 🚀 Miscellaneous Utilities
* <leader>lg : Open floating lazygit UI interface context.
* + / - : Increment or decrement the numbers positioned under your editing cursor.
