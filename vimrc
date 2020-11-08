call pathogen#infect()

let s:repo=fnamemodify(resolve(expand('<sfile>:p')), ':ht')

set listchars=nbsp:·,tab:>·,trail:·
set list

" Do not wrap lines.
set nowrap
" Wrap at column 80.
set textwidth=80

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
set pastetoggle=<F3>

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
let g:ctrlp_cmd="CtrlPMRUFiles"
let g:ctrlp_working_path_mode=1

" TODO: Configure the interaction between these plugins and LSP.
" if has('nvim')
"     " deoplete.
"     let g:deoplete#enable_at_startup=1
"     let g:deoplete#sources#syntax#min_keyword_length=3
"     call deoplete#custom#option({
"         \ 'smart_case': v:true,
"         \ })
" else
"     " neocomplete.
"     let g:neocomplete#enable_at_startup=1
"     let g:neocomplete#sources#syntax#min_keyword_length=3
"     let g:neocomplete#enable_smart_case=1
" endif

" NERDTree.
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" coc
nmap <silent> gd <PLUG>(coc-definition)
nmap <silent> gi <PLUG>(coc-implementation)
nmap <silent> gr <PLUG>(coc-references)
nmap <silent> <F2> <PLUG>(coc-rename)

nnoremap <silent> K :call <SID>coc_hover()<CR>
function! s:coc_hover()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execut '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

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
