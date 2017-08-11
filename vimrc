call pathogen#infect()

let s:repo = fnamemodify(resolve(expand('<sfile>:p')), ':ht')

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

set hidden

" Display status and hide mode (interop with lightline).
set noshowmode
set laststatus=2

" Stash backup and swap files in a central directory.
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

" CtrlP.
let g:ctrlp_cmd = "CtrlPMRUFiles"
let g:ctrlp_working_path_mode=1

if has('nvim')
    " deoplete.
    let g:deoplete#enable_at_startup=1
    let g:deoplete#enable_smart_case=1
    let g:deoplete#sources#syntax#min_keyword_length=3
else
    " neocomplete.
    let g:neocomplete#enable_at_startup=1
    let g:neocomplete#enable_smart_case=1
    let g:neocomplete#sources#syntax#min_keyword_length=3
endif

" NERDTree.
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" lightline.
let g:lightline={
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
    \ },
    \ 'component_function': {
    \     'gitbranch': 'fugitive#head'
    \ },
    \ }

" Go.
autocmd FileType go setlocal noexpandtab

" Rust.
autocmd FileType rust setlocal colorcolumn=80,100
let $RUST_SRC_PATH="~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap <Leader>gd <Plug>(rust-doc)
