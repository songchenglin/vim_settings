"""""""""""""""""""""""""""""""""""""""""""""
" VIM configure file
"
" author: songchenglin
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
" General configure 
"""""""""""""""""""""""""""""""""""""""""""""
" History
set history=32

" auto load changed configure
if has("autocmd")
	autocmd! bufwritepost vimrc source /etc/vimrc
endif

" Encode
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileformat=unix

" Compatible with VI
"set compatible
set nocompatible

" Filetype check
filetype on
filetype plugin on "open plugin
filetype indent on "open indent

" Backup
set nobackup
set noswapfile

" Status
set laststatus=2
set statusline=%t%m%r%h%w[%L\|%l:%c]%y

" Split window
set splitright
set splitbelow

" wild menu when TAB at cmd mode
"set wildmenu

" Right click menu
set mousemodel=popup
""""""""""""""""""""""""""""""""""""""""""
" Edit configure
""""""""""""""""""""""""""""""""""""""""""
" Syntax
syntax enable
syntax on
colorscheme desert

" Line number
set number

" Search result
set hlsearch      "highlight result
set incsearch     "search real time
set ignorecase    "ignore small/large case
set smartcase 

" Indent 
set expandtab      "use SPACE replace TAB
set tabstop=4      "TAB==4*SPACE
set softtabstop=4
set shiftwidth=4   "autoindent 4
set autoindent     "new line has same indent
set smartindent    "autoindent acount syntax

" Match 
set showmatch

" Map leader
let mapleader=","

" Scroll
set scrolloff=5    "auto scroll when 5 line left

" Dont change line when text too long
if (has("gui_running"))
    set nowrap
    set guioptions+=b
    set guifont=Monospace\ 8
else
    set wrap
endif 

" backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't auto add annotation
"set paste

""""""""""""""""""""""""""""""""""""""""""
" TagList configure
""""""""""""""""""""""""""""""""""""""""""
let Tlist_Auto_Open=1
let Tlist_Use_Right_Window=0
let Tlist_Show_One_File=0
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
""""""""""""""""""""""""""""""""""""""""""
" Cscope configure
""""""""""""""""""""""""""""""""""""""""""
set cscopetag
set cscopetagorder=0
"set cscopequickfix=s-,c-,d-,i-,t-,e-
""""""""""""""""""""""""""""""""""""""""""
" Netrw configure
""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap wm :WMToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""
"Auto descripe
""""""""""""""""""""""""""""""""""""""""""""""
" 当新建 .h .c .hpp .cpp 等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call AddTitle()" 
" 加入注释 
func SetComment()
	call append(0, "/*================================================================") 
	call append(1, "*   Copyright (C) ".strftime("%Y")." All rights reserved.")
	call append(2, "*   ") 
	call append(3, "*   File name:   ".expand("%:t")) 
	call append(4, "*   Author:      SongChenglin")
	call append(5, "*   E-mail:      xasongchenglin@foxmail.com")
	call append(6, "*   Create time: ".strftime("%Y-%m-%d %H:%M"))
	call append(7, "*   Last modify: ".strftime("%Y-%m-%d %H:%M"))
	call append(8, "*   Description: ") 
	call append(9, "*")
	call append(10,"================================================================*/") 
endfunc
 
" 定义函数SetTitle，自动插入文件头
func AddTitle()
	call SetComment()
	if expand("%:e") == 'h' 
		call append(11, "#ifndef _".toupper(expand("%:t:r"))."_H") 
		call append(12, "#define _".toupper(expand("%:t:r"))."_H")
		call append(line("."), "#endif")
	endif
endfunc

map <F4> :call TitleDet()<cr>'s
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/#*   File name:/s@:.*$@\=":   ".expand("%:t")@'
    normal m'
    execute '/#*   Last modify:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

function TitleDet()
    let n=1
    "默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^\s*\S*   Last modify:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
