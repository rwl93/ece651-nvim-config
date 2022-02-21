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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Git integration
" Replaced with gitsigns: Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.vim'
Plug 'tpope/vim-fugitive'

call plug#end()
" }}}
