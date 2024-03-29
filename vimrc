" auto-install vim-plug
if has('nvim')
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif
  call plug#begin('~/.config/nvim/plugged')
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
Plug 'jlanzarotta/bufexplorer'
Plug 'bogado/file-line'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/which-key.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "bash", "comment", "css", "dockerfile", "graphql", "html", "javascript", "jsdoc", "json", "json5", "markdown", "markdown_inline", "python", "regex", "ruby", "scss", "sql", "typescript", "yaml" },
    auto_install = true, -- Automatically install missing parsers when entering buffer
  }
  require("nvim-tree").setup() -- empty setup using defaults

  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" vim settings
set expandtab                                             " expand tabs to spaces
set tabstop=2 softtabstop=2                               " number of spaces inserted for a tab
set shiftwidth=2                                          " number of spaces inserted with the reindent operations
set number                                                " display line numbers
set showmatch                                             " briefly displays matching bracket
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " how to display whitespace chars
set list                                                  " display whitespace (also see :set listchars)
set visualbell                                            " no beeping
set nowrap                                                " don't wrap long lines
set ignorecase                                            " case-insensitive searching
set smartcase                                             " case-sensitive if expression contains capital
set hlsearch                                              " highlight search words
set cursorline                                            " turn off highlight cursor line (too slow)
set nocursorcolumn                                        " turn off highlight cursor column (too slow)
set title                                                 " set the terminal's title
set encoding=utf-8                                        " needed for airline (powerline) fonts
set splitright                                            " open vertical splits to the right
set splitbelow                                            " open horizontal splits to the bottom

" use /tmp for swap, backup, and undo files
set directory=/tmp
set backupdir=/tmp
set undofile
set undodir=/tmp

" colors
syntax enable
set termguicolors
colorscheme OneDark

" set special key to bold red
hi SpecialKey ctermfg=red guifg=red cterm=bold

" fzf
let g:fzf_tags_command = 'ctags -R' " Command to generate tags file
let $FZF_DEFAULT_COMMAND = 'ag -g ""' " ignore files specified by .gitignore: https://github.com/junegunn/fzf.vim/issues/121
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0) " exclude file names from search: https://github.com/junegunn/fzf.vim/issues/609

" airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1 " install powerline font glyphs
let g:airline#extensions#tabline#enabled = 1 " display all buffers when a single tab is open
let g:airline#extensions#tabline#formatter = 'unique_tail' " only display the filename in buffer

" vim sneak
let g:sneak#label = 1
noremap f <Plug>Sneak_s
noremap F <Plug>Sneak_S

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" don't open the first result automatically
cnoreabbrev Ack Ack!

" BufExplorer
let g:bufExplorerDisableDefaultKeyMapping=1 " disable default mappings

" leader mappings
let mapleader = " "
"noremap <leader>a :Ack! <cword><CR>
noremap <Leader>a :call fzf#vim#ag(expand('<cword>'))<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>e :BufExplorer<CR>
noremap <leader>c :Commits!<CR>
noremap <leader>f :Files<CR>
noremap <leader>g :GF!?<CR>
noremap <leader>h :noh<CR>
noremap <leader>l :set number!<CR>
noremap <leader>n :NvimTreeToggle<CR>
noremap <leader>t :Tags<CR>
noremap <leader>x :cclose<CR>
noremap <leader><leader>a :Ag<CR>
noremap <leader><leader>j :call JsBeautify()<CR>
if has('nvim')
  noremap <leader><leader>v :e ~/.config/nvim/init.vim<CR>
else
  noremap <leader><leader>v :e ~/.vimrc<CR>
endif

" switch windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" cycle through quickfix window
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>

" cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" auto reload .vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
