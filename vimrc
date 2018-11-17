if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'justinmk/vim-sneak'
Plug 'Asheq/close-buffers.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

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
set splitright                                            " open vertical splits to the right
set splitbelow                                            " open horizontal splits to the bottom

" use /tmp for swap, backup, and undo files
set directory=/tmp
set backupdir=/tmp
set undofile
set undodir=/tmp

" colors
colorscheme onedark
set termguicolors

" set special key to bold red
hi SpecialKey ctermfg=red guifg=red cterm=bold

" fzf
let g:fzf_tags_command = 'ctags -R' " Command to generate tags file
let $FZF_DEFAULT_COMMAND = 'ag -g ""' " ignore files specified by .gitignore: https://github.com/junegunn/fzf.vim/issues/121

" airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1 " install powerline font glyphs
let g:airline#extensions#tabline#enabled = 1 " display all buffers when a single tab is open
let g:airline#extensions#tabline#formatter = 'unique_tail' " only display the filename in buffer

" vim sneak
let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" don't open the first result automatically
cnoreabbrev Ack Ack!

" leader mappings
let mapleader = " "
noremap <leader>l :set number!<CR>
noremap <leader>c :noh<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>f :Files<CR>
noremap <leader>t :Tags<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>a :Ack! <cword><CR>
noremap <leader>x :cclose<CR>
noremap <leader>q :CloseHiddenBuffers<CR>

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
