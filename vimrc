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

colorscheme solarized
set background=dark

autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
