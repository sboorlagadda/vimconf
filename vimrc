" .vimrc
"
" Author: Matt McCredie <mccredie@gmail.com>
" Credits: Bob Koss gave me his configuration and all of the accompanying
"          tools.  He stole all of his configuration from other people. I've
"          tuned it to suit my needs.
"

" Preamble -------------------------------------------------------------------
"

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'wellle/targets.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'crusoexia/vim-monokai'
call plug#end()
" :PlugInstall to install

syntax on
filetype plugin indent on

colorscheme monokai
set t_Co=256

" Spelling
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" where it should get the dictionary files
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

" Set title of window to file name
set title

" Basic stuff --------------------------------------------------------------
"

set spell
set backspace=indent,eol,start
set history=50
set ruler
set number
set rnu
set showcmd
set incsearch
set autoindent
set autowrite
set laststatus=2
set hidden  "ok to have buffers not visible what weren't written
set wrapscan    "search scan wraps around the file
set formatoptions=tcroql
set updatetime=250
"quiet
set visualbell
set noerrorbells

"backups were so last century. Commit often to git
set nobackup
set noswapfile


" Better Completion
" Where to look for ^N and ^P completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

set fileformat=unix


" When editing a file, always jump to the last known cursor position.
augroup line_return
    au!
    au BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

augroup END

inoremap kj <Esc>
inoremap <Esc> <nop>
vnoremap kj <Esc>
vnoremap <Esc> <nop>


let mapleader=","

nnoremap <leader>, :b#<CR>

nnoremap <leader>f :NERDTreeToggle<CR>
vnoremap <leader>f :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$'] " Ignore pyc files


let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" I like to edit vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Move around splits with <c-hjkl>
"
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" source this file whenever I change it
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

nnoremap gF :view <cfile><cr>  : open file under cursor, create if necessary


" Setup syntastic for javascript / eslint
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
