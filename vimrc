if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-rails'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
call plug#end()

" colors
colorscheme onedark
set termguicolors

" fzf
let g:fzf_tags_command = 'ctags -R'

" airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1 " install powerline font glyphs
let g:airline#extensions#tabline#enabled = 1 " display all buffers when a single tab is open
let g:airline#extensions#tabline#formatter = 'unique_tail' " only display the filename in buffer

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" don't open the first result automatically
cnoreabbrev Ack Ack!

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
set nocursorline                                          " turned off highlight cursor line (too slow)
set title                                                 " set the terminal's title
set encoding=utf-8                                        " needed for airline (powerline) fonts

" use /tmp for swap, backup, and undo files
set directory=/tmp
set backupdir=/tmp
set undofile
set undodir=/tmp

" auto reload .vimrc on save
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" leader mappings
let mapleader = " "
noremap <leader>l :set number!<CR>
noremap <leader>c :noh<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>g :GFile<CR>
noremap <leader>f :Files<CR>
noremap <leader>\ :BufExplorer<CR>
noremap <silent> <Leader>a :Ack! <cword><CR>

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
