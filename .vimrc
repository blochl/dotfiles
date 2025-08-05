" Gotta be first
set nocompatible

call plug#begin('~/.vim/plugged')

" --- Making Vim look good ---
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- Programming stuff ---
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/syntastic'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/a.vim'
Plug 'sheerun/vim-polyglot'
Plug 'sheerun/vim-mustache-handlebars'
Plug 'PProvost/vim-ps1'
Plug 'bronson/vim-trailing-whitespace'
Plug 'rking/ag.vim'
Plug 'junegunn/vim-easy-align'
Plug 'ervandew/supertab'
"Plug 'jlanzarotta/bufexplorer'

" --- Working with Git ---
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" --- Other text editing features ---
Plug 'Raimondi/delimitMate'
Plug 'chikamichi/mediawiki.vim'

" --- man pages, Tmux ---
Plug 'jez/vim-superman'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" ----- General settings -----
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch
set cursorline
set ignorecase
set smartcase

"syntax on

set mouse=a

" --- Sets how many lines of history VIM has to remember ---
set history=1000

" --- Turn on the WiLd menu ---
set wildmenu
set wildmode=list:longest,full

" --- Spelling ---
nmap <silent> <leader>s :set spelllang=en_us spell!<CR>

" --- See 80th column ---
if (exists('+colorcolumn'))
    set colorcolumn=80
    hi ColorColumn ctermbg=9
endif

" --- Buffers handling ---
" Buffers - next/previous/list&pick: F12, F11, F5.
nnoremap <silent> <F12> :bn!<CR>
nnoremap <silent> <F11> :bp!<CR>
nnoremap <F5> :buffers<CR>:buffer<space>
"" F6 - buffer-explore
"nnoremap <silent> <F6> :BufExplorer<CR>

" --- GUI options ---
if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
  "set guifont=Hack\ 12
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set mouseshape=n:beam  "mouse pointer shape
endif

" ----- Plugin-Specific Settings -----

" --- altercation/vim-colors-solarized settings ---
" Toggle this to "light" for light colorscheme
set background=dark
"set background=light

" Uncomment the next line if your terminal is not configured for solarized
let g:solarized_termcolors=256
set t_Co=256

" Set the colorscheme
colorscheme solarized

" Fix Solarized spellchecker highlighting on modern Vim
hi SpellBad cterm=undercurl ctermfg=NONE ctermbg=52 gui=undercurl guisp=#dc322f
hi SpellCap cterm=undercurl ctermfg=NONE ctermbg=17 gui=undercurl guisp=#268bd2
hi SpellLocal cterm=undercurl ctermfg=NONE ctermbg=23 gui=undercurl guisp=#2aa198
hi SpellRare cterm=undercurl ctermfg=NONE ctermbg=53 gui=undercurl guisp=#6c71c4

" Do not underline the line number
hi CursorLineNr cterm=none

" --- vim-airline/vim-airline settings ---
" Always show statusbar
set laststatus=2

" Fancy arrow symbols, requires a patched font
" To install a patched font, install a forPowerline font from:
"     https://github.com/powerline/fonts
" change the terminal font to it, and uncomment the next line:
let g:airline_powerline_fonts = 1

" Show PASTE if in paste mode
let g:airline_detect_paste = 1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" --- scrooloose/nerdtree ---
" Open/close NERDTree with \t
nmap <silent> <leader>t :NERDTreeToggle<CR>
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- scrooloose/syntastic settings ---
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" --- ludovicchabant/vim-gutentags settings ---
" Print statusline indication when generating ctags
set statusline+=%{gutentags#statusline()}

" --- majutsushi/tagbar settings ---
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" --- airblade/vim-gitgutter settings ---
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" --- Raimondi/delimitMate settings ---
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" --- Superman settings ---
" better man page support
noremap K :SuperMan <cword><CR>

" --- Ag settings ---
" Type \f to search the word in all files in the current dir
nmap <silent> <leader>f :Ag <C-r>=expand("<cword>")<CR><CR>
" Type <space>/ followed by a string, to search for it in all the project files
nnoremap <space>/ :Ag<space>

" --- Easy align settings ---
vnoremap <silent> <Enter> :EasyAlign<CR>

" --- Auto indentation per language ---
autocmd Filetype h setlocal ts=4 sts=4 sw=4 et
autocmd Filetype c setlocal ts=4 sts=4 sw=4 et
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4 et
autocmd Filetype sh setlocal ts=4 sts=4 sw=4 et
autocmd Filetype dockerfile setlocal ts=4 sts=4 sw=4 et
autocmd Filetype python setlocal ts=4 sts=4 sw=4 et
autocmd Filetype tex setlocal ts=2 sts=2 sw=2 et

" --- SuperTab settings ---
let g:SuperTabDefaultCompletionType = 'context'
au FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif
