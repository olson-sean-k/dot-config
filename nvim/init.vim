call pathogen#infect()

let s:root=expand('<sfile>:p:h')
let s:repo=fnamemodify(resolve(expand('<sfile>:p')), ':ht')

set updatetime=1500

set listchars=nbsp:·,tab:>·,trail:·
set list

set nowrap
set textwidth=80
set autoindent
set smarttab
set shiftwidth=4
set tabstop=4
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

set number

set noerrorbells

set nobackup

set hidden

" Display status and hide mode (lightline; see below).
set noshowmode
set laststatus=2

syntax on
filetype on

colorscheme solarized
set background=dark

let mapleader=","
noremap \ ,
noremap <C-1> :let @/ = ""<CR><C-1>

" Map ctrl+h/j/k/l to window movement.
map <C-h> <C-w>h<C-w>_
map <C-j> <C-w>j<C-w>_
map <C-k> <C-w>k<C-w>_
map <C-l> <C-w>l<C-w>_

" Highlight word beneath cursor.
function s:invert_empty_pattern(pattern)
    if a:pattern ==# ''
        return '^$'
    else
        return a:pattern
    endif
endfunction
function s:match_cursor_hold_search(cword)
    let fsearch = s:invert_empty_pattern(@/)
    let bsearch = s:invert_empty_pattern(@?)
    if !(a:cword =~ '^\_s*$' || a:cword =~ fsearch || a:cword =~ bsearch)
        highlight CursorHoldSearch cterm=reverse ctermfg=4 guifg=Black guibg=Blue
        :exec 'match CursorHoldSearch #\V\<' . a:cword . '\>#'
    endif
endfunction
augroup cursor_hold_search
    au!
    au CursorHold * call s:match_cursor_hold_search(expand('<cword>'))
augroup END

" CtrlP.
let g:ctrlp_cmd="CtrlPMRUFiles"
let g:ctrlp_working_path_mode=1

" NERDTree.
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CoC
nmap <silent> gd <PLUG>(coc-definition)
nmap <silent> gi <PLUG>(coc-implementation)
nmap <silent> gr <PLUG>(coc-references)
nmap <silent> <F2> <PLUG>(coc-rename)

nnoremap <nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-j>"
nnoremap <nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-k>"
inoremap <nowait><expr> <A-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <A-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nnoremap <silent> K :call <SID>coc_hover()<CR>
function s:coc_hover()
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
    \               [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]]
    \ },
    \ 'component_function': {
    \     'gitbranch': 'FugitiveHead'
    \ },
    \ }

" Go.
autocmd FileType go setlocal noexpandtab

" Rust.
autocmd FileType rust setlocal colorcolumn=80,100
