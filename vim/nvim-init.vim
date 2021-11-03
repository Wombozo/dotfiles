" Plugins
call plug#begin('~/.vim/plugged')
 Plug 'ryanoasis/vim-devicons' " Set of icons
 Plug 'preservim/nerdtree' " Tree Navigation
 Plug 'wincent/terminus' " Paste option and cursor shape
 Plug 'nvim-treesitter/nvim-treesitter' " More highlighting
 Plug 'junegunn/vim-peekaboo' " Marks on the side
 Plug 'kshenoy/vim-signature' " Display marks
 Plug 'itchyny/lightline.vim' " Bottom fancy line
 Plug 'cohama/lexima.vim' " Autoclose parenthesis
 Plug 'rust-lang/rust.vim' " Syntax highlighting, formatting
 Plug 'neovim/nvim-lspconfig' " Configure nvim LSP
 Plug 'jackguo380/vim-lsp-cxx-highlight'  " Sementic highlighting using LSP
 Plug 'hrsh7th/nvim-compe' " Auto-complete
 Plug 'wsdjeg/FlyGrep.vim' " Recurse grep
 Plug 'lvht/mru' " Recent files navigation
 Plug 'xolox/vim-misc' " Dependency for vim-notes
 Plug 'xolox/vim-notes' " Taking notes
call plug#end()
filetype plugin indent on

" Basic Behavior
 set number              " Show line numbers
 set relativenumber      " Relative lines

" NerdTree
 nmap <C-f> :NERDTree<CR>
 let g:NERDTreeWinPos = "left"
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Quit vim if only NERTTree tab remains
 nmap <C-h> <C-w>h
 nmap <C-l> <C-w>l
 nmap <C-k> <C-w>k
 nmap <C-j> <C-w>j
 let NERDTreeQuitOnOpen=1

" Vim Appearance
 set termguicolors
 colorscheme default

" Tab settings
 set tabstop=4           " Number of spaces per <TAB>
 set expandtab           " Convert <TAB> key-presses to spaces
 set shiftwidth=4        " Set a <TAB> key-press equal to 4 spaces
 set autoindent          " Copy indent from current line when starting a new line
 set smartindent         " Even better autoindent (e.g. add indent after '{')

" Lists
 set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
 nnoremap <C-t> :set list!<CR>

" pmenu
 highlight Pmenu ctermbg=gray guibg=gray

" MRU
 nnoremap <C-e> :Mru<CR>

" :DiffSaved (:diffoff to get out)
 function! s:DiffWithSaved()
   let filetype=&ft
   diffthis
   vnew | r # | normal! 1Gdd
   diffthis
   exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
 endfunction
 com! DiffSaved call s:DiffWithSaved()

" Syntax for some file extensions
" autocmd BufNewFile,BufRead *.pgn set syntax=pgn

" Lightline
 set noshowmode
 let g:lightline = {
       \ 'colorscheme': 'one',
      \ }

" FlyGrep
 nnoremap <C-g> :FlyGrep<CR>

" Notes
 nnoremap <C-n> :Note 
