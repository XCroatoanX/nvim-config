# nvim-config
My neovim config :D

![Neovim Screenshot](https://github.com/XCroatoanX/nvim-config/blob/master/nvim-screenshot.png?raw=true)

## Prerequisites
For this config to work, you need to have `npm`, `neovim`, `git`, `tree-sitter-cli` (install with npm),`fd`, `ripgrep`, `lazygit` preinstalled

## How to use
1. Install neovim latest
2. Install a nerd font, like Fire Code Nerd
3. Clone this config:<br>
**Linux / Mac** = `git clone https://github.com/XCroatoanX/nvim-config.git ~/.config/nvim/`<br>
**Windows** = `git clone https://github.com/XCroatoanX/nvim-config.git ~/AppData/local/nvim/`
4. Open neovim, everything will install automatically

## Cheatsheet
### nvim-tree
For opening file manager, use `NvimTreeOpen` or `ctrl + e`
* To create a file, press `a`
* To edit a file, press `r`
* For details, press `i`
* For opening, press `t`

### LSP Install
* To install an LSP server, use `:Mason` and install what you need.
* LSP setup is handled by `mason-lspconfig` + `nvim-lspconfig`.

### Telescope
To search for a file, use `Telescope find_files` and search for filename or content

### Project Root
* Set cwd to detected project root: `<leader>pr`
* Print detected project root: `<leader>pp`
* Command alternatives: `:ProjectRoot` and `:ProjectRootPrint`

### Sessions
* Save session: `<leader>ss` (or `:SessionSave`)
* Load session: `<leader>sl` (or `:SessionLoad`)
* Delete session: `<leader>sd` (or `:SessionDelete`)

### Treesitter
* Syntax highlighting and indentation are enabled through Treesitter.
* Incremental selection keymaps:
  * Init/increase node: `ctrl + space`
  * Increase scope: `ctrl + s`
  * Decrease node: `alt + space`

### AI
* Ask opencode about current context: `<leader>oa`
* Run opencode action selector: `<leader>ox`
* Toggle opencode terminal: `ctrl + .`
* Accept inline AI suggestion: `tab`
* Next/previous inline AI suggestion: `alt + ]` / `alt + [`
* Toggle inline AI suggestions in current buffer: `<leader>uc`

### Copilot LSP
* Recommended: install `copilot-language-server` via `:Mason` (package name: `copilot-language-server`).
* Alternative: install it manually and make sure `copilot-language-server` is in your `PATH`.
* Sign in from Neovim with `:LspCopilotSignIn` in a buffer where Copilot is attached.
* Sign out with `:LspCopilotSignOut` in a buffer where Copilot is attached.

### DAP
Documentation will come after implementation

### Lazygit
To use LazyGit, you have to be in normal mode. Press `space` and `lg`.

More info will follow
