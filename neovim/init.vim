""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Basic                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog='G:/Anaconda3/envs/other-model/python.exe'
let mapleader=","
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PlugList                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~\AppData\Local\nvim\plugged')
""""""""""""""""""""""""""""""""""""""""""""""

"美化
""""""""""""""""""""""""""""""""""""""""""""""
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
"theme color
Plug 'tomasr/molokai'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" 代码段配置
""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 拼写检查
""""""""""""""""""""""""""""""""""""""""""""""
"Syntastic
Plug 'scrooloose/syntastic'

" 便捷操作
""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"comments-auto
Plug 'scrooloose/nerdcommenter'

"Fuzzy file, buffer, mru, tag, etc finder.
Plug 'kien/ctrlp.vim'

"multiple selections
Plug 'terryma/vim-multiple-cursors'

"Highlights trailing whitespace
Plug 'bronson/vim-trailing-whitespace'

"emmet quick-html
Plug 'mattn/emmet-vim'

""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              plugin settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialize plugin system
filetype plugin indent on

"加强版状态栏
set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN.UTF-8
set tenc=utf-8
"设置中文提示
language messages zh_CN.utf-8
set ambiwidth=double
set laststatus=2 "1为关闭底部状态栏 2为开启"

let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
" 打开tabline功能,方便查看Buffer和切换
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

"NerdTree
let NERDTreeQuitOnOpen = 0
let NERDChristmasTree=1
nmap <leader>f :NERDTreeToggle<CR>
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=25

"ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'

"补全相关
" https://github.com/ncm2/ncm2/issues/19"
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent> <expr> <CR> ((pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : (!empty(v:completed_item) ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>" ))
" c-j c-k for moving in snippet
imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
smap <c-u> <Plug>(ultisnips_expand)
let g:UltiSnipsExpandTrigger        = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger   = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"nerdcommenter ####
"<leader>cc         加注释
"<leader>cu         解开注释
"<leader>c<space>   加上/解开注释, 智能判断
"<leader>cy         先复制, 再注解(p可以进行黏贴)
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1

"vim-easy-align ####
xmap <leader>ea <Plug>(EasyAlign)
nmap <leader>ea <Plug>(EasyAlign)

"syntastic
"使用 :SyntasticCheck 来手动检测错误
"使用 :Errors 打开错误位置列表
"使用 :lclose 来关闭。
"使用 :SyntasticReset 可以清除掉错误列表
"使用 :SyntasticToggleMode 来切换激活（在写到 buffer 时检测）和被动（即手动检测）检测错误

"vim-multiple-cursors
" 关闭默认匹配
let g:multi_cursor_use_default_mapping=0
" 自定义匹配
let g:multi_cursor_next_key='<leader>mn'
let g:multi_cursor_prev_key='<leader>mp'
let g:multi_cursor_skip_key='<leader>ms'
let g:multi_cursor_quit_key='<Esc>'

"vim-trailing-whitespace"
nmap <leader>tw :FixWhitespace<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               common setting                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
set t_Co=256
colorscheme molokai

set number
set relativenumber

set autoindent
set smartindent
set showmatch
set ignorecase

set cursorline
set incsearch
set guifont=Noto_Mono_for_Powerline:h11:cANSI
set guifontwide=Microsoft_YaHei:h11:cGB2312

set tabstop=4
set shiftwidth=4
set expandtab

set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]

" set clipboard+=unnamed
set clipboard=unnamed

set winaltkeys=no
set undofile        " keep an undo file (undo changes after closing)
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set cmdheight=1     " 1 screen lines to use for the command-line
set showfulltag     " show tag with function protype.
set guioptions+=b   " present the bottom scrollbar when the longest visible line exceed the window

syntax on
syntax enable
set autoread
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               keyboard-binding                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"默认文件夹
"cd D:\Coding

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>

" 定义退出模式快捷键
inoremap jk <ESC>

" 定义vim设置文件内容相关
nmap <leader>ev :edit $MYVIMRC<CR>
nmap <leader>sv :source $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   autocmd                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AccentDemo()
  let keys = ['L','a','r','t','P','a','n','g']
  for k in keys
    call airline#parts#define_text(k, k)
  endfor
  call airline#parts#define_accent('L', 'red')
  call airline#parts#define_accent('a', 'green')
  call airline#parts#define_accent('r', 'blue')
  call airline#parts#define_accent('t', 'yellow')
  call airline#parts#define_accent('P', 'orange')
  call airline#parts#define_accent('a', 'purple')
  call airline#parts#define_accent('n', 'bold')
  call airline#parts#define_accent('g', 'italic')
  let g:airline_section_a = airline#section#create(keys)
endfunction

" Put these in an autocmd group, so that we can delete them easily.

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " airline
  autocmd VimEnter * call AccentDemo()

  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Disable wrap on some languages
  autocmd BufRead,BufNewFile *.slim setlocal textwidth=0
  autocmd BufRead,BufNewFile *.erb setlocal textwidth=0
  autocmd BufRead,BufNewFile *.html setlocal textwidth=0

  " Automatically wrap at 72 characters
  autocmd FileType gitcommit setlocal textwidth=72

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Autocomplete ids and classes in CSS
  autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255

  " Add the '-' as a keyword in erb files
  autocmd FileType eruby set iskeyword=@,48-57,_,192-255,$,-

  " Auto reload VIM when settings changed
  autocmd BufWritePost .vimrc so $MYVIMRC
  autocmd BufWritePost *.vim so $MYVIMRC
  autocmd BufWritePost vimrc.symlink so $MYVIMRC

  " Make those debugger statements painfully obvious
  au BufEnter *.rb syn match error contained "\<binding.pry\>"
  au BufEnter *.rb syn match error contained "\<debugger\>"
  au BufEnter *.js syn match error contained "\<debugger\>"
  au BufEnter *.coffee syn match error contained "\<debugger\>"
augroup END


 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 "                                   run                                      "
 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
