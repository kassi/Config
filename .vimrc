syntax on

filetype indent on                  " determine indentation
filetype plugin on                  " determine file type

set autoindent
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set clipboard=unnamed
"set cursorline                      " highlight current line
set encoding=utf-8
set expandtab                       " Spaces instead of tabs
set fileencoding=utf-8
set formatoptions+=t
set history=1000                    " store lots of :cmdline history
set hlsearch                        " highlight search results
set incsearch                       " show search results while searching
set laststatus=2                    " Always display the statusline in all windows
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " Highlight trailing spaces
set modeline
set mouse=a ttymouse=xterm2         " enable the use of the mouse in terminals
set nocompatible                    " do not use vim in vi compatible mode
"set noshowmode                      " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set number                          " show line numbers
set ruler                           " show cursor position in statusbar
set shiftwidth=2                    " Amount of columns for indentation in n mode
set shortmess+=I                    " suppress intro message when starting Vim :intro.
set showcmd                         " show commands in statusbar
set showmatch                       " show matching paren/braces
"set smartindent                     " set smart indent - don't use if filetype indent is on
set smartcase                       " case sensitiv. only if search term contains uc letter
set softtabstop=2                   " Amount of columns for backspace
set tabstop=2                       " A tab is two colums
set term=xterm-256color
set textwidth=0                     " Turn off physical line wrapping
set wrap                            " Enable visual wrapping
set wrapmargin=0                    " Turn off physical line wrapping

if has('autocmd')
  augroup MyAutoCmd
    autocmd!
    autocmd MyAutoCmd BufWritePost .vimrc nested source $MYVIMRC
  augroup END
  au BufRead,BufNewFile *.md set tw=80
  au BufRead,BufNewFile *.pro set filetype=prolog
  au BufRead,BufNewFile .zsh/* set filetype=zsh
  au filetype crontab setlocal nobackup nowritebackup
endif

" paste mode auto detection
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function! XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" VIM config
let mapleader = "\t"
nmap <leader>v :tabedit $MYVIMRC<CR>

map ä :tabnext<CR>
map ö :tabprev<CR>

" CtrlP
let g:ctrlp_show_hidden = 1

" VIM Session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

colorscheme murphy
set statusline=
set statusline+=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%\ %l:%c
set statusline+=\ 

