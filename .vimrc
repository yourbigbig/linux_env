"开启shift+Tab 回退Tab
imap <S-Tab> <Esc><<i

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
 set termencoding=utf-8
 set encoding=utf-8
 "set guifont=Courier_New:h10:cANSI   " 设置字体  
 set nu
 "set foldenable      " 允许折叠  
 "set foldmethod=manual   " 手动折叠  
 if 0
 set cursorline
endif
if 0
set mouse=a
set selection=exclusive
set selectmode=mouse,key
endif
" 继承前一行的缩进方式，特别适用于多行注释 
set autoindent
set tabstop=4
"set expandtab "表示Tab自动转换成空格
set autoindent "表示换行后自动缩进
set smartindent "智能对齐
set shiftwidth=4 
" 在搜索的时候忽略大小写 
set ignorecase
" 智能补全
set completeopt=longest,menu
syntax enable
syntax on
"程序提供自动缩进
"set smartindent
" F5编译和运行程序 
" 请注意，下述代码在windows下使用会报错 
" 需要去掉./这两个字符 
" C的编译和运行 
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
      exec "w"
  if &filetype == 'c'
      exec "!gcc % -o %<"
      exec "! ./%<"
  elseif &filetype == 'cpp'
      exec "!g++ % -o %<"
      exec "! ./%<"
  elseif &filetype == 'java'
      exec "!javac %"
      exec "!java %<"
  elseif &filetype == 'sh'
      exec "! bash %"
  elseif &filetype == 'python'
      exec "!python3 %"
  endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
"高亮显示普通txt文件（需要txt.vim脚本） 
au BufRead,BufNewFile * setfiletype txt 
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle()
 if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: yjw")
        call append(line(".")+2, "\# mail: DreamYangJW@outlook.com")
        call append(line(".")+3, "\# Descriptio: This is NULL")
        call append(line(".")+4, "\# Created Time: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, "\#########################################################################") 
        call append(line(".")+6, "\#!/bin/bash")
        call append(line(".")+7, "")
 else
        call setline(1, "/*************************************************************************")
        call append(line("."),   "   > File Name: ".expand("%"))
        call append(line(".")+1, "   > Author: yjw")
        call append(line(".")+2, "   > mail: Dreamyangjw@outlook.com.com")
        call append(line(".")+3, "   > Descriptio: This is NULL")
        call append(line(".")+4, "   > Created Time: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, " ************************************************************************/")
        call append(line(".")+6, "")
 endif
 if &filetype == 'cpp'
        call append(line(".")+7, "#include<iostream>")
        call append(line(".")+8, "using namespace std;")
        call append(line(".")+9, "")
 endif
 if &filetype == 'c'
      call append(line(".")+7, "#include<stdio.h>")
      call append(line(".")+8, "")
 endif
 "新建文件后，自动定位到文件末尾
 autocmd BufNewFile * normal G
endfunc
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>
" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
"map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件  
nnoremap <C-F2> :vert diffsplit
"让vimrc配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

