set listchars=eol:$,nbsp:-,tab:>-,trail:-
set list

set nowrap									"do not wrap lines

set autoindent								"automatially indent
set smarttab								"insert tabs based on shiftwidth, not tabstop
set shiftwidth=4							"automatically indent by four spaces
set tabstop=4								"tabs display as four spaces

set pastetoggle=<F2>						"disable smart indenting for pasting text

set backspace=indent,eol,start				"backspace over everything in insert mode

set number									"display line numbers

"set visualbell								"do not beep
set noerrorbells

set nobackup								"do not use backup files
"set noswapfile

syntax on									"enable syntax highlighting

if 256 <= &t_Co || has("gui_running")
	colorscheme sunburst
endif

autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
