" ECE 651 Vimrc
" Randy Linderman
" Plugin List {{{
call plug#begin()
" Install vim-plug to get help files
Plug 'junegunn/vim-plug'
" Required by other plugins
Plug 'nvim-lua/plenary.nvim'
" Gradle & clover coverage viewer
Plug 'rwl93/dcoverage'
" Colorscheme
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'whatyouhide/vim-gotham'
" Nice icons
" Replaced with nvim-web-devicons: Plug 'ryanoasis/vim-devicons'
" Note requires a patched font
Plug 'kyazdani42/nvim-web-devicons'
" Tabline
Plug 'nvim-lualine/lualine.nvim'
" Git integration
" Replaced with gitsigns: Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
call plug#end()
" }}}
" Plugins {{{
" Lualine {{{
lua << END
require('lualine').setup {
  options = {
    theme = 'dracula',
    section_separators = '',
    component_separators = '',
  }
}
END
" }}}
