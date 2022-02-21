# (Neo)Vim Setup for ECE651
Herein lies a humble Vim setup to balance the powers that be, namely Emacs.
We'll be installing Neovim due to its native LSP support. However, a Vim8 setup
guide can be found [here](./vim8setup.md).

__NOTE__: This setup has been tested on a Ubuntu 20.04.3 LTS. The scripts use the `apt`
package manager which will need to be updated for other distributions.

## Initial Dev Setup
Please follow the ECE651 dev setup guide before continuing.

## Build Neovim from source
The Ubuntu package manager version of Neovim does not include the LSP tools so we'll be building from source.
Please run [this build script](./neovim_build.sh)  that will run through the Neovim build process:
```sh
./neovim_build.sh
```
See [Neovim build doc](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for full instructions.

## Setup Neovim environment
We'll be using vim's built in `pack` package manager for installing the plugins by cloning plugins into the
`~/.vim/pack/USERNAME/start/PACKAGENAME` (see [vim pack docs]() or run `:h packages` for more info)
## Useful mappings and commands
- Remapped `jk` in insert mode to `<Esc>` ([here](vimrc#L1))

## Package list
- Darcula : cool dark colorscheme
- vim-projectionist : helpful for switching between main and test files
    - Setup `.projections.json` in your project dir (__NOTE__ the `.` means it's a hidden file) 
    	An example projectionist config for the battleship project is given below
	and in [projectionist template](projections.json)
    - Use `:A` to switch between main and test files (`A` stands for alternate)
- fugitive : Git integration
    - Open git status pane with `:G`
    - stage files with `-` or `s`
    - `cc` to commit
    - `:Gpull` to pull
    - `:Gpush` to push
   
