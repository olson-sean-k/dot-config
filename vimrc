call pathogen#infect()

set listchars=nbsp:·,tab:>·,trail:·
set list

" Do not wrap lines.
set nowrap

" Automatially indent.
set autoindent
" Insert tabs based on shiftwidth, not tabstop.
set smarttab
" Automatically indent by four spaces.
set shiftwidth=4
" Tabs display as four spaces.
set tabstop=4
" Use spaces for tabs.
set expandtab

set wildmenu
set wildmode=list:longest

" Disable smart indenting for pasting text.
set pastetoggle=<F2>

" Highlight search.
set hlsearch
" Highlight column 80.
set colorcolumn=80

" Backspace over everything in insert mode.
set backspace=indent,eol,start

" Display line numbers.
set number

" Set visualbell.
set noerrorbells

" Do not use backup files.
set nobackup
"set noswapfile

" Stash backup and swap files in a central directory.
" This doesn't work well when editing files concurrently alongside other users.
"set backupdir=~/.vim/tmp,~/.tmp,/var/tmp,/tmp
"set directory=~/.vim/tmp,~/.tmp,/var/tmp,/tmp

" Enable syntax highlighting.
syntax on
filetype on

" Map , to leader key.
let mapleader=","
noremap \ ,
noremap <C-1> :let @/ = ""<CR><C-1>

" Map ctrl+h/j/k/l to window movement.
map <C-h> <C-w>h<C-w>_
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-l> <C-w>l<C-w>_

colorscheme solarized
set background=dark

" NERDTree.
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP.
let g:ctrlp_cmd = "CtrlPMRUFiles"
let g:ctrlp_working_path_mode=1

" Golang.
autocmd FileType go setlocal noexpandtab
