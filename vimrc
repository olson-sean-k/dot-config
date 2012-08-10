call pathogen#infect()

set listchars=nbsp:·,tab:>·,trail:·
set list

"do not wrap lines
set nowrap

"automatially indent
set autoindent
"insert tabs based on shiftwidth, not tabstop
set smarttab
"automatically indent by four spaces
set shiftwidth=4
"tabs display as four spaces
set tabstop=4

set wildmenu
set wildmode=list:longest

"disable smart indenting for pasting text
set pastetoggle=<F2>

"backspace over everything in insert mode
set backspace=indent,eol,start

"display line numbers
set number

"set visualbell
set noerrorbells

"do not use backup files
set nobackup
"set noswapfile

"enable syntax highlighting
syntax on
filetype on

"map , to leader key
let mapleader=","
noremap \ ,
noremap <C-1> :let @/ = ""<CR><C-1>

"map ctrl+h/j/k/l to window movement
map <C-h> <C-w>h<C-w>_
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-l> <C-w>l<C-w>_

colorscheme solarized
set background=dark

autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

"NERDTree
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"CtrlP
let g:ctrlp_cmd = "CtrlPMRUFiles"
let g:ctrlp_working_path_mode=1
