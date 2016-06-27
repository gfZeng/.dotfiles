if !isdirectory($HOME."/.vim/bundle/Vundle.vim")
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let g:uninstalled_package_exists = 0
function! EnsurePlugin(x)
    Plugin a:x
    if !isdirectory($HOME."/.vim/bundle/".split(a:x, "/")[-1])
        let g:uninstalled_package_exists = 1
    endif
endfunction

command -nargs=1 EnsurePlugin call EnsurePlugin(<args>)

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
EnsurePlugin 'VundleVim/Vundle.vim'
"Bundle 'VimClojure'
EnsurePlugin 'guns/vim-clojure-static'

EnsurePlugin 'applescript.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
EnsurePlugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
EnsurePlugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'Command-T'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

EnsurePlugin 'auto-pairs'
EnsurePlugin 'tpope/vim-surround'
EnsurePlugin 'mattn/emmet-vim'
EnsurePlugin 'stardiviner/AutoSQLUpperCase.vim'
EnsurePlugin 'wting/rust.vim'

EnsurePlugin 'Shougo/unite.vim'
EnsurePlugin 'Shougo/neomru.vim'
EnsurePlugin 'Shougo/vimproc.vim'
EnsurePlugin 'dbakker/vim-projectroot'
EnsurePlugin 'terryma/vim-multiple-cursors'
EnsurePlugin 'jceb/vim-orgmode'
EnsurePlugin 'tpope/vim-speeddating'
EnsurePlugin 'christoomey/vim-tmux-navigator'
EnsurePlugin 'vim-ruby/vim-ruby'
EnsurePlugin 'CodeFalling/fcitx-vim-osx'

" All of your Plugins must be added before the following line
call vundle#end()            " required

if g:uninstalled_package_exists && confirm("Install uninstalled packages?", "&Yes\n&No", 2) == 1
    PluginInstall
endif

if isdirectory($HOME."/.vim/bundle/vimproc.vim") && !filereadable($HOME."/.vim/bundle/vimproc.vim/.maked")
    silent !cd ~/.vim/bundle/vimproc.vim/ && make -f make_mac.mak && touch .maked
endif

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




" ====================================================================
set number
syntax on
set ic
set showcmd

" Highlight search
" set hls

" Wrap text instead of being on one line
set lbr

" Change colorscheme from default to delek
" colorscheme delek

set expandtab
set tabstop=4
set shiftwidth=4 softtabstop=4
set incsearch ignorecase hlsearch
" Press space to clear search highlighting and any message already displayed.
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>


" Indent automatically depending on filetype
"filetype indent on
"set autoindent
"set smartindent
"set autoread
"set cinoptions+=g0
"set cinoptions+=:0
"set formatoptions+=r
"set fileencodings=utf8,gbk


" window switching
noremap <C-k> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-l> <C-w><Right>
noremap <C-h> <C-w><Left>
vnoremap * y/<C-R>"<CR>"

let mapleader="\<Space>"
function! UniteCtrlp()
    " execute ':Unite -direction=botright -buffer-name=files -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
    execute ':Unite -buffer-name=files -start-insert buffer file_rec/async:'.ProjectRootGuess().'/'
endfunction
nnoremap <silent> <leader>pu :call UniteCtrlp()<CR>
nnoremap <silent> <leader>ul :UniteResume<CR>
nnoremap <silent> <leader>b :Unite -start-insert buffer<CR>
nnoremap <silent> <leader>f :Unite -start-insert file<CR>

source $VIMRUNTIME/vimrc_example.vim
set nobackup
set nowritebackup
" set undodir=~/.vim/undodir
set noundofile
au BufWritePost * if getline(1) =~ "^#!" | silent execute "!chmod a+x <afile>" | endif
set clipboard=unnamed

au BufRead,BufNewFile *.boot setfiletype clojure
au FileType ruby setl sw=2 sts=2 et

set autochdir
set hidden
"inoremap <silent> <Esc> <C-O>:stopinsert<CR>
inoremap <Esc> <Esc><Right>

"let CursorColumnI = 0 "the cursor column position in INSERT
"autocmd InsertEnter * let CursorColumnI = col('.')
"autocmd CursorMovedI * let CursorColumnI = col('.')
"autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
