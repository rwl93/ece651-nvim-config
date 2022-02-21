" ECE 651 Vimrc
" Randy Linderman
" Plugin List {{{
call plug#begin()
" Install vim-plug to get help files
Plug 'junegunn/vim-plug'
" Required by other plugins
Plug 'nvim-lua/plenary.nvim'
" Gradle wrapper
Plug 'hdiniz/vim-gradle'
" Clover code coverage helper
Plug 'rwl93/dcoverage'
" Testing tools
Plug 'vim-test/vim-test'
" Colorscheme
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'whatyouhide/vim-gotham'
" Nice icons
" Replaced with nvim-web-devicons: Plug 'ryanoasis/vim-devicons'
" NOTE: requires a patched font
Plug 'kyazdani42/nvim-web-devicons'
" Tabline
Plug 'nvim-lualine/lualine.nvim'
" Git integration
" Replaced with gitsigns: Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
" Color helper
Plug 'norcalli/nvim-colorizer.lua'
" Commands and text objects for surrounding objects {(['""'])}
Plug 'tpope/vim-surround'
" Easy commenting mappings
Plug 'tpope/vim-commentary'
" Elegant Netrw settings
Plug 'tpope/vim-vinegar'
" Handy bracket mappings
Plug 'tpope/vim-unimpaired'
" Project manager
Plug 'tpope/vim-projectionist'
" Repeat commands
Plug 'tpope/vim-repeat'
" Tagbar navigation
Plug 'preservim/tagbar'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Nice syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" File searching
" NOTE: Ctrlp is a good alternative if you find telescope too distracting.
" Plug 'kien/ctrlp.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Neovim LSP setup
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'octaltree/cmp-look'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
call plug#end()
" }}}
" UI {{{
" Basic UI {{{
set nocompatible
filetype plugin indent on
syntax enable
" Show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" Show completion matches in a status line
set wildmenu
" command line completion behavior
set wildmode=longest,list
set showtabline=2
" Show matching ({[]})
set showmatch
" Enable hidden buffers
set hidden
" keep 200 lines of command history
set history=200
" Use system clipboard
set clipboard^=unnamedplus
set encoding=utf-8
" Powerful backspace
set backspace=indent,eol,start
" Use modelines
set modeline
set modelines=5
" Intuitive splitting behavior
set splitbelow splitright
" Remove annoying bells
set novisualbell
set noerrorbells
set fileformat=unix
set formatoptions+=t
" }}}
" Numbering {{{
set number
set relativenumber
" }}}
" Searching {{{
" Do incremental searching
set incsearch
" Highlight search
set hlsearch
" }}}
" Folding {{{
set foldmethod=indent
set foldenable
set foldnestmax=10
set foldlevelstart=99
set foldlevel=99
" }}}
" Cursorline {{{
set cursorline
autocmd! VimEnter,Colorscheme * hi CursorLine ctermbg=234
" }}}
" Colors {{{
set t_Co=256
set background=dark
colorscheme dracula
" }}}
" Standard tabs etc {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set smartindent
set smarttab
" }}}
" Highlighting {{{
highlight BadWhitespace ctermbg=red guibg=darkred
highlight Todo ctermfg=194 ctermbg=60 guifg=#d3ebe9 guibg=#4e5166
set colorcolumn=80
match BadWhitespace /\s\+$/
" }}}
" GUI {{{
" Using the gui is not recommended
set termguicolors
set guioptions-=T
set guioptions-=m
set guioptions-=r
if has('gui_running')
    set background=dark
endif
" }}}
" }}}
" Custom mappings {{{
" Leader
let mapleader = ","
" Escape!!!! with jk
inoremap jk <Esc>
" Buffer navigation
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
" highlight (select in visual mode) last inserted text
nnoremap gV `[v`]
" Split movement {{{
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
" }}}
" Folds
nnoremap <space> za
" Edit config files faster
nnoremap sv :source ~/.config/nvim/init.vim<CR>
nnoremap ev :e ~/.config/nvim/init.vim<CR>
" Clear search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" AutoGroups {{{
" Remove trailing whitespace on save
au BufWritePre * :%s/\s\+$//e
au BufNewFile,BufFilePre,BufRead  *.md  set filetype=markdown
au! BufNewFile,BufRead  *.csv  setf csv
" " Python Autogroup {{{
augroup python
  autocmd!
  autocmd BufNewFile,BufRead *.py set filetype=python
  autocmd FileType python
        \ syn keyword pythonSelf self             |
        \ highlight def link pythonSelf Special   |
        \ let python_highlight_all=1              |
augroup end
" }}}
" C/C++ Autogroup {{{
augroup c
  autocmd!
  autocmd BufNewFile,BufRead *.cpp,*.c,*.h
        \ set fileformat=unix                 |
        \ set filetype=cpp                    |
        \ set makeprg=make\ -C\ ../build\ -j9 |
        \ set wildignore=*.o,tags,*~          |
        \ packadd termdebug                   |
augroup end
" }}}
" Java Autogroup {{{
augroup j
  autocmd!
  autocmd BufNewFile,BufRead *.java set filetype=java
augroup end
" }}}
" XML Autogroup {{{
augroup xml html
  autocmd!
  autocmd BufNewFile,BufRead *.xml,*.html
        \ set tabstop=2                       |
        \ set softtabstop=2                   |
        \ set shiftwidth=2                    |
        \ set fileformat=unix                 |
augroup end
" }}}
" LaTeX Autogroup {{{
augroup latex
  autocmd!
  autocmd BufNewFile,BufRead *.tex,*.cls
        \ set tabstop=2              |
        \ set softtabstop=2          |
        \ set shiftwidth=2           |
        \ set filetype=tex           |
augroup end
" }}}
" Vim Autogroup {{{
augroup vim
  autocmd!
  autocmd FileType vim
    \ set tabstop=2                       |
    \ set softtabstop=2                   |
    \ set shiftwidth=2                    |
augroup end
" }}}
" }}}
" Custom commands {{{
" Taken from default vimrc
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
" }}}
" Plugin Config {{{
" Treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
EOF
" }}}
" Lualine (statusline) {{{
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
" Telescope {{{
" Use j/k for moving in telescope
lua << EOF
local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
    file_ignore_patterns = { "%.class", "%~", },
  },
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
require("telescope").load_extension('file_browser')
EOF

" nnoremap <C-f> :lua require('telescope.builtin').git_files(require('telescope.themes').get_ivy({previewer=false})<CR>
nnoremap <C-f> <cmd>Telescope git_files<CR>
" nnoremap <leader>ff <cmd>Telescope find_files cwd=expand("%:p:h")<cr>
nnoremap <leader>ff <cmd>Telescope find_files <cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').grep_string({search=vim.fn.expand("<cword>")})<CR>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string({search=vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fm <cmd>Telescope oldfiles<CR>
nnoremap <leader>bg <cmd>Telescope current_buffer_fuzzy_find layout_config={prompt_position='top'} sorting_strategy=ascending <CR>
nnoremap <leader>bw <cmd>lua require('telescope.builtin').grep_string({cwd=vim.fn.expand("%:p:h"), search=vim.fn.expand("<cword>")})<CR>
nnoremap <leader>bs <cmd>lua require('telescope.builtin').grep_string({cwd=vim.fn.expand("%:p:h"), search=vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>vh <cmd>Telescope help_tags<CR>
nnoremap <leader>gb <cmd>Telescope git_branches<CR>
nnoremap <leader>gc <cmd>Telescope git_commits<CR>
nnoremap <leader>ld <cmd>Telescope lsp_definitions<CR>
nnoremap <leader>lr <cmd>Telescope lsp_references<CR>
nnoremap <leader>li <cmd>Telescope lsp_implementations<CR>
nnoremap <leader>ls <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader>lws <cmd>Telescope lsp_workspace_symbols<CR>
" }}}
" LSP Servers {{{
lua << EOF
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
  require('lspconfig').sumneko_lua.setup{ capabilities = capabilities }
  require('lspconfig').jdtls.setup{ capabilities = capabilities }
  require('lspconfig').vimls.setup{ capabilities = capabilities }
  require('lspconfig').clangd.setup{ capabilities = capabilities }
  require('lspconfig').dockerls.setup{ capabilities = capabilities }
  require('lspconfig').pyright.setup{ capabilities = capabilities }
  require('lspconfig').texlab.setup{ capabilities = capabilities }
  require('lspconfig').zeta_note.setup{ capabilities = capabilities }
EOF

augroup lsp_map
  autocmd!
  autocmd FileType java,vim,python,cpp,lua
    \ nnoremap <buffer> gD <cmd>lua vim.lsp.buf.declaration()<cr>                |
    \ nnoremap <buffer> gd <cmd>lua vim.lsp.buf.definition()<cr>                 |
    \ nnoremap <buffer> K  <cmd>lua vim.lsp.buf.hover()<cr>                      |
    \ nnoremap <buffer> gr <cmd>lua vim.lsp.buf.references()<cr>                 |
    \ nnoremap <buffer> gs <cmd>lua vim.lsp.buf.signature_help()<cr>             |
    \ nnoremap <buffer> gi <cmd>lua vim.lsp.buf.implementation()<cr>             |
    \ nnoremap <buffer> gt <cmd>lua vim.lsp.buf.type_definition()<cr>            |
    \ nnoremap <buffer> <leader>gw <cmd>lua vim.lsp.buf.document_symbol()<cr>    |
    \ nnoremap <buffer> <leader>gW',<cmd>lua vim.lsp.buf.workspace_symbol()<cr>  |
    \ nnoremap <buffer> <leader>af <cmd>lua vim.lsp.buf.code_action()<cr>        |
    \ nnoremap <buffer> <leader>ar <cmd>lua vim.lsp.buf.rename()<cr>             |
    \ nnoremap <buffer> <leader>= <cmd>lua vim.lsp.buf.formatting()<cr>          |
    \ nnoremap <buffer> <leader>ai <cmd>lua vim.lsp.buf.incoming_calls()<cr>     |
    \ nnoremap <buffer> <leader>ao <cmd>lua vim.lsp.buf.outgoing_calls()<cr>     |
    " \ nnoremap <buffer> <leader>ah <cmd>lua vim.lsp.buf.hover()<cr> |
    " \ nnoremap <buffer> <leader>ee <cmd>lua vim.lsp.util.show_line_diagnostics()<cr>
augroup END
" }}}
" Completion {{{
set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua << EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  -- Global setup.
  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'snippy' }, -- For snippy users.
      { name = 'ultisnips' }, -- For ultisnips users.
      { name = 'buffer', keyword_length = 5 },
      { name = 'look',   keyword_length = 2,
        option = {
          convert_case = true,
          loud = true,
          --dict = '/usr/share/dict/words'
        },
      },
    }),

    formatting = {
      format = lspkind.cmp_format{
        max_width = 50,
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          ultisnip = "[snip]",
          gh_issues = "[issues]",
          look = "look",
        },
      },
    },

    experimental = {
      native_menu = false,
      ghost_text = true,
    },
  })

  -- `/` cmdline setup.
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- uncomment this if you would like to use it but I find it annoying
  -- instead use wildmode standard w/ vim
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path', max_item_cound = 10 }
    }, {
      { name = 'cmdline', max_item_cound = 10 }
    })
  })
EOF
" }}}
" Linting {{{
lua << EOF
  require('lint').linters_by_ft = {
    markdown = {'vale', },
    python = {'pylint',},
    vimwiki = {'proselint',},
    java = {'checkstyle',},
  }
EOF
au BufWritePost,InsertLeave,TextChanged <buffer> lua require('lint').try_lint()
" }}}
" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>u"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"" }}}
" ALE {{{
" let g:ale_completion_enabled = 0
" let g:ale_disable_lsp = 0
" let g:ale_linters = {'java': ['eclipselsp']}
" }}}
" vim-test {{{
nnoremap <silent> t<C-n> :TestNearest<CR>
nnoremap <silent> t<C-f> :TestFile<CR>
nnoremap <silent> t<C-s> :TestSuite<CR>
nnoremap <silent> t<C-l> :TestLast<CR>
nnoremap <silent> t<C-g> :TestVisit<CR>
let test#java#runner = 'gradletest'
" let test#strategy = 'vimterminal'
" }}}
" CtrlP Uncomment if you prefer over telescope {{{
" let g:ctrlp_map = '<c-f>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_custom_ignore='.class'
"}}}
" Netrw {{{
let g:netrw_keepdir=0
autocmd FileType netrw setl bufhidden=delete
let g:netrw_localcopydircmd='cp -r'
"" }}}
" Fugitive {{{
" Auto remove old fugitive files
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}
" Colorizer {{{
lua require'colorizer'.setup()
" }}}
" }}}
" vim: foldmethod=marker : foldlevel=0 :
