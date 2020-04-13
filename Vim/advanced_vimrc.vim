"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Predefined Variation and Create needed documents
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:HV_PATH = "$HOME/.HappyVim"
let s:PLUGINDir = s:HV_PATH .. "/my_plugins"
let s:SWPDir = s:HV_PATH .. "/swp"
let s:UltiSNIPSDir = s:HV_PATH .. "/UltiSnips"
let s:UNDODir = s:HV_PATH .. "/undodir"

let s:CUS_PATH = "D:/缓存/MyVimFiles"
let s:SNIPSDir = s:CUS_PATH .. "/Snippets"
let s:MRUDir = s:CUS_PATH .. "/MRU"

let &runtimepath = &runtimepath .. ',' .. s:HV_PATH

let s:PATH_LIST = [
            \ s:HV_PATH,
            \ s:PLUGINDir,
            \ s:SWPDir,
            \ s:UltiSNIPSDir,
            \ s:UNDODir,
            \ s:CUS_PATH,
            \ s:SNIPSDir,
            \ s:MRUDir,
            \ ]

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

if empty(glob(expand(s:HV_PATH .. '/autoload/plug.vim')))
    silent execute "!curl -fLo " .. expand(s:HV_PATH .. '/autoload/plug.vim')
                \ .. " --create-dirs "
                \ .. "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


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
set directory=s:SWPDir
set updatetime=300

set viminfo='100,f1,<500
try
    " vim退出并在下次打开后仍然保留上次的undo历史
    set undodir=s:UNDODir
    set undofile
    set undolevels=1000
    set undoreload=10000
catch
endtry

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set guifont=JetBrains_Mono:h12:cANSI
" 字体测试
" |---------|----|
" |iI1lL    |oO0a||
" 测试中文字体等宽|
" Set font according to system
if has("gui_running")
    if has("gui_win32")
        set guifont=Sarasa_Mono_Slab_SC:h13,JetBrains_Mono:h12,IBM_Plex_Mono:h14,Source_Code_Pro:h12
        set guifontwide=Sarasa_UI_SC:h13,Microsoft_YaHei_Mono:h12.5
    elseif has("gui_gtk2")
        set guifont=JetBrains_Mono:h12,IBM_Plex_Mono_14,:Hack_14,Source_Code_Pro_12
    elseif has("x11")
        set guifont=JetBrains_Mono:h12,IBM_Plex_Mono_14,:Hack_14,Source_Code_Pro_12
    endif
endif

set t_Co=256

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
    set guiheadroom=0
endif

" 设定命令行的行数为 2
set cmdheight=2
set noshowmode

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
set wildignore=*.o,*~,*.pyc
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
command! Modifymyconfig :edit $MYVIMRC
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" 打开当前目录 explorer/cmd
" nmap <silent> <leader>exp :!start explorer %:p:h<CR>
" nmap <silent> <leader>cmd :!start cmd /k cd %:p:h<cr>
if has("win32")
    command! Winexp :!start explorer %:p:h<CR>
    command! Wincmd :!start cmd /k cd %:p:h<CR>
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
" => Custom Call
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CompileRunGcc()
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
endfunction

" Delete trailing white space on save, useful for some filetypes ;)
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

map <F5> :call CompileRunGcc()<CR>

augroup ft_vim
    autocmd!

    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

    " 打开文件总是定位到上次编辑的位置
    autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin(expand(s:PLUGINDir))
"You can remove filetype off, filetype plugin indent on and syntax on from your .vimrc as they are automatically handled by plug#begin() and plug#end().

Plug 'dracula/vim', { 'as': 'dracula' }
"we can use the `:Explore` to use a more flexible explore.
Plug 'itchyny/lightline.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'
Plug 'godlygeek/tabular'

Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'yegappan/mru'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"Plug 'dracula/vim', { 'as': 'dracula' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme dracula
set background=dark

"Plug 'itchyny/lightline.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? &fileencoding : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'fileformat': 'LightlineFileformat',
      \   'fileencoding': 'LightlineFileencoding',
      \   'filetype': 'LightlineFiletype',
      \ },
      \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"Plug 'tpope/vim-surround'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 光标在
" “Hello world!”
" 中时按下cs"'，则会替换双引号为单引号：
" ‘Hello world!’
" 继续按下cs'<q>，则会替换单引号为 “标签”
" 'Hello world!'
" 按下cst"，则回到初始的双引号：
" “Hello world!”
" 要删除符号，则按下ds"
" Hello world!
" 当光标在hello上时，按下ysiw]，则会变为
" [Hello] world!
" 添加包围符号的命令是ys(ys可以记为you surround)，命令后同样跟两个参数，第一
" 个是一个vim“动作”（motion）或者是一个文本对象,其中motion即vim动作，比如说w
" 向后一个单词。文本对象简单的来说主要是来通过一些分隔符来标识一段文本，比如
" iw就是一个文本对象，即光标下的单词。
" 另外： yss 命令可以用于整行操作，忽略中间的空格,
" yS 和 ySS 还能让包围内容单独一行并且加上缩进。
" 加包围符号还有个非常好用的方式：在可视模式v下，按下S后即可添加想要添加的包围符号了。
" 再说一个小技巧：在包围符号为括时，输入左括号 (或者{ ,则会留一个空格

"Plug 'ctrlpvim/ctrlp.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

"Plug 'yegappan/mru'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let MRU_File = s:MRUDir .. '/vim_mru_files'
let MRU_Max_Entries = 1000
let MRU_Exclude_Files = '^D:/缓存/.*'           " For MS-Windows
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 1
let MRU_Auto_Close = 1
let MRU_Add_Menu = 0
let MRU_Max_Menu_Entries = 15
let MRU_Max_Submenu_Entries = 15
let MRU_Open_File_Use_Tabs = 0

"Plug 'easymotion/vim-easymotion'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader><leader>w                       从光标位置起，往前（往下）在单词之间移动光标
" <leader><leader>b                       从光标位置起，往后（往上）在单词之间移动光标
" <leader><leader>s                       从光标位置起，同时往前往后，在单词之间移动光标
" <leader><leader>f｛char｝               从光标位置起，往前（往下）在单个字符之间移动光标

"Plug 'terryma/vim-expand-region'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map = <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)

"Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_edit_url_in = 'tab'  " tab, vsplit, hsplit, current
let g:markdown_fenced_languages = ['css', 'js=javascript']

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess+=c
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Coc-ci
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> w <Plug>(coc-ci-w)
nmap <silent> b <Plug>(coc-ci-b)

" Coc-snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
