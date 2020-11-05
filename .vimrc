"""" Enable Vundle: vim plugin manager

 filetype plugin on
"
"
" """" Basic Behavior
"
 set number              " show line numbers
 set wrap                " wrap lines
 set encoding=utf-8      " set encoding to UTF-8 (default was "latin1")
 set mouse=a             " enable mouse support (might not work well on Mac OS
" X)
 set wildmenu            " visual autocomplete for command menu
 set lazyredraw          " redraw screen only when we need to
 set showmatch           " highlight matching parentheses / brackets [{()}]
 set laststatus=2        " always show statusline (even with only single
" window)
 set ruler               " show line and column number of the cursor on right
 "side of statusline
" set visualbell          " blink cursor on error, instead of beeping
"
"
" """" Key Bindings
"
" " move vertically by visual line (don't skip wrapped lines)
nmap <C-j> <C-]>

"
"
" """" Vim Appearance
"
" " put colorscheme files in ~/.vim/colors/
 " good colorschemes: murphy, slate, molokai, badwolf,
 colorscheme slate 
" solarized
"
" " use filetype-based syntax highlighting, ftplugins, and indentation
syntax enable
filetype plugin indent on
"
"
" """" Tab settings
"
 set tabstop=4           " number of spaces per <TAB>
 set expandtab           " convert <TAB> key-presses to spaces
 set shiftwidth=4        " set a <TAB> key-press equal to 4 spaces
"
 set autoindent          " copy indent from current line when starting a new
 "line
 set smartindent         " even better autoindent (e.g. add indent after '{')
"
"
" """" Search settings
"
" set incsearch           " search as characters are entered
" set hlsearch            " highlight matches
"
" " turn off search highlighting with <CR> (carriage-return)
" nnoremap <CR> :nohlsearch<CR><CR>
"
"
" """" Miscellaneous settings that might be worth enabling
"
" "set cursorline         " highlight current line
" "set background=dark    " configure Vim to use brighter colors
" "set autoread           " autoreload the file in Vim if it has been changed
" outside of Vim

set nopaste

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

autocmd BufNewFile,BufRead *.bb* set syntax=sh


