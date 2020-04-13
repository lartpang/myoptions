" By Lart Pang, 2020年4月9日
" https://github.com/lartpang/myoptions/edit/master/Vim/server_vimrc.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Predefined Variation and Create needed documents
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:PATH_LIST = [
            \ "$HOME/.HappyVim",
            \ "$HOME/.HappyVim/swp",
            \ "$HOME/.HappyVim/undodir",
            \ "$HOME/.HappyVim/MRU"
            \ ]
let &runtimepath = &runtimepath .. ',' .. s:PATH_LIST[0]

function! MkdirIfNotExist(path)
    if !isdirectory(expand(a:path))
        try
            call mkdir(expand(a:path), "p", 0700)
        catch
            echom "Sorry, I can't create the path " .. expand(a:path)
        endtry
    endif
endfunction

for path in s:PATH_LIST
    call MkdirIfNotExist(path)
endfor


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Encoding
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B
" 解决consle输出乱码
language messages zh_CN.utf-8

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

set nocompatible
set history=1024

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
set nowb

"set noswapfile
set hidden
set directory=$HOME/HappyVim/swp
set updatetime=300

set viminfo='100,f1,<500
set undodir=$HOME/HappyVim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Enable filetype plugins
filetype plugin on
filetype indent on

"自动设置当前目录为正在编辑的目录
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
set clipboard=unnamed
set winaltkeys=no

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"https://xbeta.info/vim73b.htm
" conceallevel(简称cole)选项值: 具备conceal属性的字符串，并不一定是隐藏的。其具体表现取决于conceallevel的值。
" 0：默认值，显示。 因此，只设定conceal，并没有任何隐藏效果。
" 1：短线高亮。 匹配的字符串缩略显示为一个“-”符号（取决于listchars设定），并采用conceal组的高亮方案。
" 2：不显示
" 3：完全不显示。
"更多参见：:h cole
set conceallevel=2

" font
" set guifont=JetBrains_Mono:h12:cANSI
" set guifontwide=楷体:h14:cGB2312
" 字体测试
" I Love You !
" 我爱你中国！

" gui
" 设定命令行的行数为 2
set cmdheight=1
"set noshowmode

" 设置 laststatus = 0 ，不显式状态行
" 设置 laststatus = 1 ，仅当窗口多于一个时，显示状态行
" 设置 laststatus = 2 ，总是显式状态行
set laststatus=2

" 使用指令变大变小
command! FontBigger :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! FontSmaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

set cursorline
set cursorcolumn

" Switch on highlighting the last used search pattern.
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase

set number

" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright

" 监视文件改动
set autoread

" 命令模式下，底部操作指令按下 Tab 键自动补全。
" 第一次按下 Tab，会显示所有匹配的操作指令的清单；
" 第二次按下 Tab，会依次选择各个指令
set wildmenu
set wildmode=longest:list,full
" Ignore compiled files
set wildignore=*.o,*~,
set wildignore+=*\\node_modules\\*,*.git*,*.svn*,*.zip*,*.exe*,*.pyc*,*.bin*,*.7z*,*.rar*,*/.DS_Store

" Format
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" zc     折叠
" zC     对所在范围内所有嵌套的折叠点进行折叠
" zo     展开折叠
" zO     对所在范围内所有嵌套的折叠点展开
" [z     到当前打开的折叠的开始处。
" ]z     到当前打开的折叠的末尾处。
" zj     向下移动。到达下一个折叠的开始处。关闭的折叠也被计入。
" zk     向上移动到前一折叠的结束处。关闭的折叠也被计入。
" manual          手工定义折叠
" indent          更多的缩进表示更高级别的折叠
" expr            用表达式来定义折叠
" syntax          用语法高亮来定义折叠
" diff            对没有更改的文本进行折叠
" marker          对文中的标志折叠
" set foldmethod=marker
"关闭自动折叠
set nofoldenable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set t_Co=256
colorscheme desert
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    "不显示工具/菜单栏
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=r
    set guioptions-=b
    " 终端窗口会自动弹到vim内部下侧窗口中
    set guioptions+=!
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Command
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set my leader
let mapleader=' '

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>

" 定义退出模式快捷键
inoremap kj <ESC>

" 定义vim设置文件内容相关
command! Modifymyconfig :e $MYVIMRC
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

if has('win32')
    " 打开当前目录 explorer/cmd
    " nmap <silent> <leader>exp :!start explorer %:p:h<CR>
    " nmap <silent> <leader>cmd :!start cmd /k cd %:p:h<cr>
    command! Winexp :!start explorer %:p:h<CR>
    command! Wincmd :!start cmd /k cd %:p:h<CR>
"elseif has('unix')
"elseif has('mac')
endif

" 复制当前文件/路径到剪贴板
" 第一个命令拷贝我们正在编辑的文件的相对路径。
"   %表示"当前文件"。 Vim也支持其他一些字符串作为expand()的参数。
" 第二个命令拷贝当前文件的完整的绝对路径名。
"   字符串中的:p告诉Vim你需要绝对路径。
" 这里也有许多别的修饰符可以用到。
command! Copyrelpath :let @* = expand('%')
command! Copyabspath :let @* = expand('%:p')

" 快速交换当前行位置
" 实际上交换本行和下面的行最简单可以使用 ddp
" 删除本行,下行补上,粘贴后贴到了下行

" 快速添加空行
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" 设定n始终为向后，N始终为向前
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" 如果你选中了一行或多行，那么你可以用 < 或 > 来调整他们的缩进。但在调整之后就不会保持选中状态了。
" 你可以连续按下 g v 来重新选中他们，请参考 :h gv。因此，你可以这样来配置映射：
xnoremap < <gv
xnoremap > >gv

" 高级版本的重新绘制屏幕
" 这个映射就是执行重新绘制，并且取消通过 / 和 ? 匹配字符的高亮，而且还可以修复代码高亮问题
"（有时候，由于多个代码高亮的脚本重叠，或者规则过于复杂，Vim 的代码高亮显示会出现问题）。
" 不仅如此，还可以刷新「比较模式」
nnoremap <leader>rd :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Motions about tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=1
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! %<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! %<"
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'sh'
        :!%
    endif
endfunc

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" 针对python文件自动添加头部信息
func! SetTitle()
    call setline(1, "\# -*- coding=utf8 -*-")
    call setline(2, "\"\"\"")
    call setline(3, "\# @Author : lart")
    call setline(4, "\# @GitHub : github.com/lartpang")
    call setline(5, "\# @Created Time : ".strftime("%Y-%m-%d %H:%M:%S"))
    call setline(6, "\# @Description :")
    call setline(7, "\"\"\"")
    normal G
    normal o
    normal o
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Call
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F5> :call CompileRunGcc()<CR>

augroup ft_vim
    autocmd!

    autocmd BufNewFile *.py call SetTitle()

    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

    " 打开文件总是定位到上次编辑的位置
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END
