filetype off
set nocompatible
" ---- PLUGINS ----
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'joshdick/onedark.vim'
Plug 'kien/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
if has("gui_running")
    Plug 'valloric/youcompleteme'
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
endif

call plug#end()
" ---- PLUGINS END ----

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Plugin Settings 
let g:airline_theme='luna'  
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

autocmd Filetype go setlocal shiftwidth=4 tabstop=4

" Gui
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif
set guifont=Monaco\ for\ Powerline:h10

" General
filetype plugin on
set ruler
set guioptions-=L
set laststatus=2
set mouse=a

" set the cursor to a vertical line in insert mode and a solid block in command mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=0\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" line numbers
set relativenumber
set number

" indents, 4 spaces for tab
set cindent
set smartindent
set expandtab
set smarttab
set tabstop=8
set softtabstop=0
set shiftwidth=4
" fuck beeps
set visualbell
set noerrorbells
set completeopt-=preview

" color scheme & syntax colors
syntax on
colorscheme onedark
" hi Normal guibg=#202529
" highlight Pmenusel term=reverse ctermfg=0 ctermbg=1 

" highlight 
set hlsearch

" Hotkeys
let mapleader = ","
map <Leader>n :NERDTreeToggle <Esc>
map <Leader>h :nohl<CR>

imap jj <Esc>
imap jk <Esc>
nmap <CR> O<Esc>
nnoremap Q <nop>

" switch views
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-q> :q<CR>

" switch tabs mappings
nmap <S-Tab> :tabp<CR>
nmap <Tab> :tabn<CR>
nmap <C-N> :tabnew<CR>
