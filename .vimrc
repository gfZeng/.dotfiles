" Turn on line numbering, turn it of with "set nonu"
set nu
set mouse=a

" Set syntax on
syn on

" Indent automatically depending on filetype
filetype indent on
set autoindent
set smartindent
set autoread
set cinoptions+=g0
set cinoptions+=:0

" Case insensitive search
set ic

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

" Add comment Automatically
function AddTitle()
    call setline(1, "\/***********************************************")
    call append(1, "*        Author: Zeng ~~~ ndtm.idea@gmail.com")
    call append(2, "*    Setup Time: " . strftime("%Y-%m-%d %H:%M"))
    call append(3, "* Last Modified: " . strftime("%Y-%m-%d %H:%M"))
    call append(4, "*      Filename: " . expand("%"))
    call append(5, "*  Destcription: ")
    call append(6, "************************************************/")
endfunction

map fuck :call AddTitle()<CR>:$<CR>o
map shit :/* *Last Modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@<CR>:$<CR>o

set formatoptions+=r
set fileencodings=utf-8,gbk

" taglist
" let Tlist_Show_One_File=1
" let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"" WinManager
"let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap wm :WMToggle<cr>
"" changing-over windows
"let g:miniBufExplMapWindowNavVim=1

" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-

" set paste toggle
set pastetoggle=<F6>

" set for Powerline
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
"let g:Powerline_symbols = 'fancy'
"
" DOS character
nmap dos :set ff=dos<CR>:set fileencoding=gbk<CR>

" set colorscheme
colorscheme desert

" setting for mutt
au BufRead /tmp/mutt-* set tw=72

" Sets +x on stuff starting with the magic shebang.
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod a+x <afile>

" auto insert Python header
function InsertPythonHeader()
    let l1 = getline(1)
    if  match('\#!/', l1) == 0
        exec 1
        normal O
        call setline(1,'#!/usr/bin/env python')
    endif
"    if match("\#", l2) == 0 && (match("-", l2)  != 2 ¦¦ (match("code", l2) != 2))
"        exec 2
"        normal O
"        call setline(2,'#-*- coding:utf-8 -*-')
"    endif
endfunction
au FileType python call InsertPythonHeader()

" html autoclosetage
"au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
set showcmd
set showmatch

" set map leader {
let mapleader=','
" }
"
" pathogen {
execute pathogen#infect()
filetype plugin on
" }


" taglist and nerdtree {
let Tlist_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
nnoremap <leader>tl :Tlist<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>ct :CommandT<CR>
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }
"
" auto sava {
au focusLost * silent! wa
" }
"
" fcitx {
set ttimeoutlen=100
" }

source $VIMRUNTIME/vimrc_example.vim

set nobackup
set nowritebackup
