"  __  __     __     _____ __  __ ____   ____
" |  \/  |_   \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | \ \ / / | || |\/| | |_) | |
" | |  | | |_| |\ V /  | || |  | |  _ <| |___
" |_|  |_|\__, | \_/  |___|_|  |_|_| \_\\____|
"         |___/

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


set nocompatible
"filetype on

syntax on


"  __  __    _    ____
" |  \/  |  / \  |  _ \ 
" | |\/| | / _ \ | |_) |
" | |  | |/ ___ \|  __/
" |_|  |_/_/   \_\_|
"

"快捷键映射
inoremap <Up> <Nop>
nnoremap <Up> <Nop>
inoremap <Down> <Nop>
nnoremap <Down> <Nop>
inoremap <Left> <Nop>
nnoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap <Right> <Nop>

noremap H ^
noremap L $
noremap ,h H
noremap ,l L

map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
inoremap jk <Esc>
snoremap jk <Esc>

nnoremap < <<
nnoremap > >>

map <c-c> :qa<CR>
map <c-a> ggVG

nnoremap <space>w <C-w>

noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" ===
" === Tab Maps
" ===
nnoremap tn :tabnext<CR>
nnoremap tN :tabnew<CR>
nnoremap tp :tabprevious<CR>
nnoremap tc :tabclose<CR>

" ===
" === Buffer Maps
" ===
nnoremap bn :bnext<CR>
nnoremap bp :bprevious<CR>

" ===
" === Terminal
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <Esc> <C-\><C-n>

" ===
" === Command Mode Cursor Movement
" ===
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
"cnoremap <M-b> <S-Left>
"cnoremap <M-w> <S-Right>

"   ____  _____ _____
" / ___|| ____|_   _|
" \___ \|  _|   | |
"  ___) | |___  | |
" |____/|_____| |_|

set tabstop=4
set shiftwidth=4
"显示行号
set nu
"显示相对行号
set relativenumber
"在光标所在行下显示一条线
set cursorline
"自动换行
set wrap
"在右下角显示输入的字符
set showcmd
"在COMMAND模式下，支持<TAB>补全
set wildmenu
set mouse=a
set helplang=cn
set whichwrap+=h,l
set nobackup
"搜索
"忽略大小写
set ignorecase
set hls
exec "nohls"
map <leader><CR> :nohls<CR>
set smartcase

"placeholder in Markdown

map <space><space> <esc>/<++><CR>:nohls<CR>c4l


"set backspace=2
set backspace   =indent,eol,start  " Make backspace work as you would expect.

" 上下保证5行显示
set scrolloff=5

"     _   _   _ _____ ___   ____ __  __ ____
"    / \ | | | |_   _/ _ \ / ___|  \/  |  _ \ 
"   / _ \| | | | | || | | | |   | |\/| | | | |
"  / ___ \ |_| | | || |_| | |___| |  | | |_| |
" /_/   \_\___/  |_| \___/ \____|_|  |_|____/


"设置高亮显示行尾不必要的空格,并适用给文件
highlight Whitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.c,*.h,*.java match Whitespace /\s\+$\ \+/

"恢复到上次关闭⽂件时光标所在的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"au BufWrite *.c,*.h,*.java,*.py exe "normal gg=G"

au VimEnter * execute("XTabMode")

"  _____ _   _ _   _  ____ _____ ___ ___  _   _
" |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | |
" | |_  | | | |  \| | |     | |  | | | | |  \| |
" |  _| | |_| | |\  | |___  | |  | | |_| | |\  |
" |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|


" :if has('nvim') == 1
" : 	nmap <leader>t :term<CR>
" :else
" : 	nmap <leader>t :term<CR><C-w>L
" :endif
nmap <space>t :call OpenTerm()<CR>
function! OpenTerm() abort
	set splitbelow
	:sp
	:res -10
	term
endfunction

" ===
" === 自动注释
" ===

"augroup Start
"	autocmd!
"	autocmd FileType py vmap <C-;> I#<Esc>
"augroup END

" Compile function
noremap <space>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		" :sp
		" :res -5
		" term gcc -ansi -Wall % -o %< && time ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	endif
endfunc

"  ____  _    _   _  ____
" |  _ \| |  | | | |/ ___|
" | |_) | |  | | | | |  _
" |  __/| |__| |_| | |_| |
" |_|   |_____\___/ \____|


let g:plug_url_format='git://github.com/%s.git'

call plug#begin('$HOME/.vim/plugged')

"界面优化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
"Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
"Plug 'akinsho/bufferline.nvim'
"Plug 'mengelbrecht/lightline-bufferline'

"目录树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' "Shows Git status flags for files and folders in NERDTree.
Plug 'ryanoasis/vim-devicons' "Adds filetype-specific icons to NERDTree files and folders,
"Plug 'ryanoasis/nerd-fonts'
"Plug 'https://gitee.com/keyboardkiller/nerd-fonts.git', {'do': 'sh ./install.sh'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "Adds syntax highlighting to NERDTree based on filetype.
"Plug 'scrooloose/nerdtree-project-plugin', "Saves and restores the state of the NERDTree between sessions.
Plug 'PhilRunninger/nerdtree-buffer-ops' "1) Highlights open files in a different color. 2) Closes a buffer directly from NERDTree.
Plug 'PhilRunninger/nerdtree-visual-selection' "Enables NERDTree to open, delete, move, or copy multiple Visually-selected files at once.

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

"Color Theme
"Plug 'plan9-for-vimspace/acme-colors'
"Plug 'romainl/Apprentice'
"Plug 'chriskempson/base16-vim'
"Plug 'whatyouhide/vim-gotham'
"Plug 'morhetz/gruvbox'
"Plug 'mhinz/vim-janah'
Plug 'nanotech/jellybeans.vim'
"Plug 'jonathanfilip/vim-lucius'
"Plug 'tomasr/molokai'
"Plug 'robertmeta/nofrils'
"Plug 'mhartington/oceanic-next'
"Plug 'owickstrom/vim-colors-paramount'
"Plug 'jpo/vim-railscasts-theme'
"Plug 'junegunn/seoul256.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'tpope/vim-vividchalk'
"Plug 'kabbamine/yowish.vim'
"Plug 'jnurmine/Zenburn'

"浮动终端
Plug 'voldikss/vim-floaterm'

"Coding Part
Plug 'Chiel92/vim-autoformat' "保存后自动格式化

Plug 'tpope/vim-surround'

Plug 'junegunn/goyo.vim'

Plug 'jiangmiao/auto-pairs'

Plug 'w0rp/ale'

Plug 'gcmt/wildfire.vim' "选中大括号

" Undo Tree
Plug 'mbbill/undotree'

"Python
Plug 'vim-scripts/indentpython.vim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': ['python', 'vim-plug']}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug']}
Plug 'tweekmonster/braceless.vim'

" ===
" === Java
" ===
Plug 'NiYanhhhhh/lighttree-java'
Plug 'mfussenegger/nvim-jdtls'
Plug 'artur-shaik/vim-javacomplete2'

"Markdown
" Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'dhruvasagar/vim-table-mode'

" ===
" === HTML
" ===

Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'elzr/vim-json'
Plug 'neoclide/jsonc.vim'
Plug 'alvan/vim-closetag'

" 自动补全单引号，双引号等
Plug 'Raimondi/delimitMate'
" 自动补全html/xml标签
Plug 'docunext/closetag.vim', {'for': ['html', 'xml'] }

" ===
" === Omnisharp
" ===

Plug 'OmniSharp/omnisharp-vim'
Plug 'ctrlpvim/ctrlp.vim' , { 'for': ['cs', 'vim-plug'] } " omnisharp-vim dependency

" quick edit
" 快速注释
Plug 'preservim/nerdcommenter'

"Ranger

Plug 'francoiscabrol/ranger.vim'

"Debug

Plug 'puremourning/vimspector'

"代码补全
"YouCompleteMe
"Plug 'Valloric/YouCompleteMe'

Plug 'wellle/tmux-complete.vim'

"COC

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-git', {'do': 'yarn install'}

Plug 'honza/vim-snippets'



Plug 'fadein/vim-FIGlet'

"缩进高亮
Plug 'nathanaelkane/vim-indent-guides'

Plug 'mg979/vim-xtabline'
Plug 'mg979/tabline.nvim'

" trailingwhitespace
" 快速去行尾空格
Plug 'bronson/vim-trailing-whitespace'

Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

" 函数列表
" Plug 'majutsushi/tagbar', {'on': 'Tagbar'}
Plug 'liuchengxu/vista.vim'

"自动生成代码
Plug 'github/copilot.vim', {'do': ':Copilot setup'}


" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" API 调试
Plug 'diepm/vim-rest-console'
call plug#end()



" ===================== Start of Plugin Settings =====================

" ===
" === colorscheme
" ===
"colorscheme zenburn
colorscheme jellybeans
"colorscheme Tomorrow-Night-Blue

" https://zhuanlan.zhihu.com/p/25571232
" ===
" === airline
" ===

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1

" ===
" === bufferline
" ===

let g:bufferline_show_bufnr = 0

" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
" noremap to :XTabCycleMode<CR>
" noremap \p :echo expand('%:p')<CR>

" ===
" === Semshi
" ===
if !exists('g:loaded_remote_plugins')
	runtime! ~/.local/share/nvim/rplugin.vim
endif

" trailingwhitespace {{{
nmap <leader><leader> :FixWhitespace<cr>
" }}}

" ===
" === emmet
" ===

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

let g:user_emmet_leader_key = '<C-x>'

" ===
" === nerdcommenter
" ===

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" [count]<leader>cc |NERDCommenterComment|
"
" Comment out the current line or text selected in visual mode.
"
" [count]<leader>cn |NERDCommenterNested|
"
" Same as cc but forces nesting.
"
" [count]<leader>c<space> |NERDCommenterToggle|
"
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
"
" [count]<leader>cu |NERDCommenterUncomment|
"
" Uncomments the selected line(s).

nmap <space>cc <Plug>NERDCommenterComment
nmap <space>cn <Plug>NERDCommenterNested
nmap <space>cu <Plug>NERDCommenterUncomment
nmap <M-/> <Plug>NERDCommenterToggle

vmap <space>cc <Plug>NERDCommenterComment
vmap <space>cn <Plug>NERDCommenterNested
vmap <space>cu <Plug>NERDCommenterUncomment
vmap <M-/> <Plug>NERDCommenterToggle

" ===
" === NERDTree
" ===
let NERDTreeShowHidden=1
map <space>nt :NERDTreeToggle<CR><C-w>p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd VimEnter * execute("NERDTree")
"Show line number.
let g:NERDTreeShowlineNumber=1

"Show Node model.
let NERDTreeDirArrows=1

"Delete help information at the top
let NERDTreeMinimalUI=1

let g:NERDTreeDirArrowExpandable = '|'
let g:NERDTreeDirArrowCollapsible = '/'

" ===
" NERDTree-git
" ===
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }

" ===
" === vim-devicons
" ===

let g:airline_power_line = 1

"Can be enabled or disabled
let g:webdevicons_enable_nerdtree = 1

"whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

"adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

"adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1


""""""""""""""""""""""""""""""
"vim-nerdtree-syntax-highlight settings
""""""""""""""""""""""""""""""
"Highlight full name (not only icons). You need to add this if you don't have vim-devicons and want highlight.
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

"Highlight full name (not only icons). You need to add this if you don't have vim-devicons and want highlight.
let g:NERDTreeHighlightFolders = 1

"highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1

"you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:Turquoise = "40E0D0"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = "FE405F"
let s:git_orange = "F54D27"
let s:gray = "808A87"

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['o'] = s:gray " sets the color of o files to blue
let g:NERDTreeExtensionHighlightColor['h'] = s:blue " sets the color of h files to blue
let g:NERDTreeExtensionHighlightColor['c'] = s:green " sets the color of c files to blue
let g:NERDTreeExtensionHighlightColor['cpp'] = s:green " sets the color of cpp files to blue
let g:NERDTreeExtensionHighlightColor['c++'] = s:green " sets the color of c++ files to blue



" ===
" === ale
" ===
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
			\   'c++': ['clang'],
			\   'c': ['clang'],
			\   'python': ['pylint'],
			\}
let b:ale_fixers = ['autopep8', 'yapf']


" ===
" === GoYo
" ===
map <space>gy :Goyo<CR>


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1,
			\ 'sequence_diagrams': {},
			\ 'flowchart_diagrams': {},
			\ 'content_editable': v:false,
			\ 'disable_filename': 0
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = '8500'
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

map <leader>p <Plug>MarkdownPreviewToggle

let g:vimspector_enable_mappings = 'HUMAN'

"nmap <F5>         <Plug>VimspectorContinue
"nmap <leader><F5> <Plug>VimspectorLaunch
"nmap <F3>         <Plug>VimspectorStop
"nmap <F4>         <Plug>VimspectorRestart
"nmap <F6>         <Plug>VimspectorPause
"nmap <F9>         <Plug>VimspectorToggleBreakpoint
"nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
"nmap <F8>         <Plug>VimspectorAddFunctionBreakpoint
"nmap <leader><F8> <Plug>VimspectorRunToCursor
"nmap <F10>        <Plug>VimspectorStepOver
"nmap <F11>        <Plug>VimspectorStepInto
"nmap <F12>        <Plug>VimspectorStepOut

autocmd FileType java silent! nmap <leader><F5> :CocCommand java.debug.vimspector.start<CR>

map tm :TableModeToggle<CR>

" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1


" ===
" === vim-indent-guide
" ===
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig

" ===
" === Undotree
" ===
nnoremap U :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
" function g:Undotree_CustomMap()
"     nmap <buffer> j <plug>UndotreeNextState
"     nmap <buffer> k <plug>UndotreePreviousState
" endfunc

" ===
" === Tagbar
" ===

" map tb :Tagbar<CR><C-w>p
" let g:tagbar_autofocus = 1
" let g:tagbar_autoshowtag = 1

" ===
" === coc-nvim
" ===
imap <C-z> <Plug>(coc-snippets-expand-jump)

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

nmap tt :CocCommand explorer<CR>
nmap ts <Plug>(coc-translator-p)

let g:coc_global_extensions = [
			\ 'coc-actions',
			\ 'coc-clangd',
			\ 'coc-cmake',
			\ 'coc-css',
			\ 'coc-diagnostic',
			\ 'coc-docker',
			\ 'coc-emmet',
			\ 'coc-eslint',
			\ 'coc-explorer',
			\ 'coc-flutter-tools',
			\ 'coc-gitignore',
			\ 'coc-html',
			\ 'coc-htmldjango',
			\ 'coc-htmlhint',
			\ 'coc-html-css-support',
			\ 'coc-import-cost',
			\ 'coc-java',
			\ 'coc-java-debug',
			\ 'coc-jest',
			\ 'coc-json',
			\ 'coc-lists',
			\ 'coc-omnisharp',
			\ 'coc-prettier',
			\ 'coc-prisma',
			\ 'coc-pyright',
			\ 'coc-python',
			\ 'coc-sh',
			\ 'coc-snippets',
			\ 'coc-sourcekit',
			\ 'coc-stylelint',
			\ 'coc-sql',
			\ 'coc-syntax',
			\ 'coc-tailwindcss',
			\ 'coc-tasks',
			\ 'coc-translator',
			\ 'coc-tsserver',
			\ 'coc-vetur',
			\ 'coc-vimlsp',
			\ 'coc-yaml',
			\ 'coc-yank']

" ===
" === Omnisharp.vim
" ===
let g:OmniSharp_server_stdio = 1

" ===
" === FZF
" ===
"nnoremap <c-p> :Leaderf file<CR>
noremap <silent> <C-p> :Files<CR>
"noremap <silent> <C-f> :Rg<CR>
"noremap <silent> <C-h> :History<CR>
"noremap <C-t> :BTags<CR>
" noremap <silent> <C-l> :Lines<CR>
"noremap <silent> <C-w> :Buffers<CR>
"noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
	redir => list
	silent ls
	redir END
	return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
	execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
			\ 'source': s:list_buffers(),
			\ 'sink*': { lines -> s:delete_buffers(lines) },
			\ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
			\ }))

"noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" ===
" === Vista.vim
" ===
noremap <LEADER>v :Vista!!<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
			\   "function": "\uf794",
			\   "variable": "\uf71b",
			\  }
" function! NearestMethodOrFunction() abort
" 	return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:scrollstatus_size = 15

" ===
" === Floaterm
" ===

nnoremap <space>tn :FloatermNext<CR>
nnoremap <space>tN :FloatermNew<CR>
nnoremap <space>tp :FloatermPrev<CR>
nnoremap <space>th :FloatermHide<CR>
nnoremap <space>tk :FloatermKill<CR>
nnoremap <space>ts :FloatermSend<CR>



" ===
" === vim-bookmarks
" ===
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
"nmap ma <Plug>BookmarkAnnotate
"nmap ml <Plug>BookmarkShowAll
nmap mh <Plug>BookmarkNext
nmap ml <Plug>BookmarkPrev
nmap mc <Plug>BookmarkClear
"nmap mx <Plug>BookmarkClearAll
"nmap mu <Plug>BookmarkMoveUp
"nmap me <Plug>BookmarkMoveDown
"nmap <Leader>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1

" ===
" === nvim-treesitter
" ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = {"c", "python", "bash", "java", "c_sharp"},
highlight = {
enable = true,              -- false will disable the whole extension
disable = { "rust" },  -- list of language that will be disabled
},
}
EOF

" ===
" === lighttree_java
" ===

" --- example when using nvim-jdtls
" local config = {}
" local bundles = vim.fn.glob("/path/to/jar/com.microsoft.jdtls.ext.core-*.jar")
" config['init_options']
" ---
" --- your settings
" ---
" require('jdtls').start_or_attach(config)

"-- variables and its default value:
" lighttree window position (available: 'topleft', 'botright')
let g:lighttree_win_pos = 'topleft'
" lighttree window size ([width, height])
let g:lighttree_win_size = [30, 25]
" this setting makes the window appear below the opening nerdtree window, set to empty dict to disable it
let g:lighttree_win_args = {'follow': 'nerdtree'}
" indicator show before the directory node (when opening)
" nerdtree usually using '▾'
let g:lighttree_sign_open = '-'
" indicator show before the directory node (when closing)
" nerdtree usually using '▸'
let g:lighttree_sign_close = '+'

" decide the appearance of java package in explorer (reference to eclipse project explorer)
let g:lighttree_java_ishierarchical = v:true
" this plugin uses sync request, this option decides the timeout the client waits
let g:lighttree_java_request_timeout = 500
" you java language server name (which is 'jdt.ls in nvim-jdtls')
let g:lighttree_java_server_name = 'jdt.ls'

"-- default maps
" lighttree buffer:
"close node
" nnoremap <buffer> q <cmd>call lighttree#view#close_win()<cr>
" "toggle node
" nnoremap <buffer> <cr> <cmd>call b:lighttree_ui.toggle(line('.'))<cr>
" nnoremap <buffer> o <cmd>call b:lighttree_ui.toggle(line('.'))<cr>
" "open leaf node using vsplit
" nnoremap <buffer> s <cmd>call b:lighttree_ui.open(line('.'), {'flag': 'v'})<cr>
" "open leaf node using split
" nnoremap <buffer> i <cmd>call b:lighttree_ui.open(line('.'), {'flag': 'h'})<cr>
" "open leaf node in new tab
" nnoremap <buffer> t <cmd>call b:lighttree_ui.open(line('.'), {'flag': 't'})<cr>
" "[WIP] refresh node
" nnoremap <buffer> r <cmd>call b:lighttree_ui.refresh_node0(line('.'))<cr>
"
" "" navigation actions
" "focus on parent node
" nnoremap <buffer> p <cmd>call b:lighttree_ui.focus_node_parent(line('.'))<cr>
" "focus on root node
" nnoremap <buffer> P <cmd>call b:lighttree_ui.focus_node_root(line('.'))<cr>
" "focus on last node in its brother nodes
" nnoremap <buffer> J <cmd>call b:lighttree_ui.focus_node_last(line('.'))<cr>
" "focus on first node in its brother nodes
" nnoremap <buffer> K <cmd>call b:lighttree_ui.focus_node_first(line('.'))<cr>
" "focus on about middle position in its brother nodes
" nnoremap <buffer> <c-n> <cmd>call b:lighttree_ui.focus_node_middle(line('.'))<cr>
" "focus on next node in its brother nodes
" nnoremap <buffer> <c-j> <cmd>call b:lighttree_ui.focus_node_next(line('.'))<cr>
" "focus on previous node in its brother nodes
" nnoremap <buffer> <c-k> <cmd>call b:lighttree_ui.focus_node_prev(line('.'))<cr>


" map a function to start (not do in the plugin):
autocmd FileType java nnoremap <silent> <space>l <cmd>call lighttree#plugin#jdt#toggle_win()<cr>
