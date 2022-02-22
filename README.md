# (Neo)Vim Setup for ECE651
Herein lies a humble Vim setup to balance the powers that be, namely Emacs.
We'll be installing Neovim due to its native LSP support.

__NOTE__: This setup has been tested on a Ubuntu 20.04.3 LTS. The scripts use the `apt`
package manager which will need to be updated for other distributions.

## Build Neovim from source
The Ubuntu package manager version of Neovim does not include the LSP tools so we'll be building from source.
Please run [this build script](./neovim_build.sh)  that will run through the Neovim build process:
```sh
./neovim_build.sh
```
See [Neovim build doc](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for full instructions.

## Setup Neovim environment
We'll be using [vim-plug](https://github.com/junegunn/vim-plug) package manager
for handling installing plugins. The build script setups up vim-plug with
documentation and runs the installer. Please reference vim-plug's homepage and
documentation (':h plug') to learn more.

## Config Overview
TODO:...
Please see `:h ece651-config` for documentation on the plugins, settings, and
mappings used by this config.

## Package list
- [vim-plug](https://github.com/junegunn/vim-plug) : Plugin manager
- [dcoverage](https://github.com/rwl93/dcoverage) : Clover code coverage helper
    - Normal mode map: `,dg` or `:DcovGenAndSaveCoverage` to generate Clover coverage report
    - `,ds` to toggle code highlighting
    - `,dc` to toggle coverage report
- [Telescope](https://github.com/nvim-telescope/telescope.nvim): File navigation
    - Fuzzy finder file navigation
    - `<C-f>`: Find files in git repository
    - sevaral sources installed not listed in this list.
- LSP and completion is setup for Java, C/C++, Docker, Markdown, Lua, Vim
- [vim-projectionist](https://github.com/tpope/vim-projectionist) : helpful for switching between main and test files
    - Setup `.projections.json` in your project dir
    - An example projectionist config for the battleship project is given in [projectionist template](projections.json)
    - Use `:A` to switch between main and test files (`A` stands for alternate)
    - Should add `.projections.json` to your `.gitignore`
- [fugitive](https://github.com/tpope/vim-fugitive) : Git integration
    - Open git status pane with `:G`
    - stage files with `-` or `s`
    - see inline diff with =
    - `cc` to commit
    - `:Git pull` to pull
    - `:Git push` to push
    - See `:h fugitive` as there is much more
    - Also, see [Vimcasts 31-35](http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/)
- [vim-gradle](https://github.com/hdiniz/vim-gradle): Gradle wrapper
    - `:Gradle <commands>` (e.g. `:Gradle clean build`)
    - `:h vim-gradle`
- [vim-test](https://github.com/vim-test/vim-test) : Testing tools
    - `nmap <silent> <leader>ts :TestSuite<CR>` Run test suite
- [vim-surround](https://github.com/tpope/vim-surround): Mappings to manipulate surrounding {[()]}
- [vim-commentary](https://github.com/tpope/vim-commentary): Comment code with `gcc` or visual mode `gc`
- [vim-vinegar](https://github.com/tpope/vim-vinegar): Convenient settings for Netrw
- [vim-unimpaired](https://github.com/tpope/vim-unimpaired): Helpful bracket mappings
- [ultisnips](https://github.com/SirVer/ultisnips): Snippet manager
- [vim-snippets](https://github.com/honza/vim-snippets): Predefined snippets
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): Nice signs to mark git changes and much more (see help)
- [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua): Show colors of colorcodes
- [dracula](https://github.com/dracula): cool dark colorscheme (default)
- [gotham](https://github.com/gotham): cool dark colorscheme
- [nvim-web-devicons](https://github.com/nvim-web-devicons): Nice icons in vim (requires a patched font)
- [lualine](https://github.com/lualine.nvim): Pretty statusline
- [plenary](https://github.com/plenary.nvim): Helpful Lua commands to support other plugins
- [vim-repeat](https://github.com/tpope/vim-repeat): Repeat more commands with .
- [tagbar](https://github.com/preservim/tagbar): Tagbar for file navigation
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Fancy syntax recognition
