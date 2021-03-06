"""""""""""""""""""""""""
"Start
""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = "\\"
" vim 自身命令行模式智能补全
set wildmenu
"切换buffer时不被打断
set hidden 
set nowrap
" 开启实时搜索功能
set incsearch
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
" colorscheme solarized
colorscheme molokai
set smartindent "smart indent
set autoindent	"auto indent
set shortmess=atI   "remove the Welcome frame
set nu			"line number
set hlsearch	"highlight the search result
set incsearch	"immediately match
set backspace=2 "enable the backspace
set ruler		"right-bottom will show the postion of the current cursor
set showmode
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
"set list		"show the tab with "|"
"syntax enable	"highlight the syntax
syntax on		"enable the file type detect
set autoread	"refresh the file if it's updated outside
set history=50
set nolinebreak
set backspace=indent,eol,start
set t_Co=256
set cursorline
""""""Indent
"set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set list lcs=tab:\|\ 
"set foldmethod
" set foldmethod=indent
" nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"set foldmethod=syntax
set foldnestmax=2
set nofoldenable
" 搜索时大小写不敏感
set ignorecase smartcase
set cursorline cursorcolumn
"Gui options
" if has('gui_running')
"     set background=light
" else
"     set background=dark
" endif
set guioptions-=L
set guioptions-=r


" Persistent undo
" set undodir=~/.vim/undodir
" set undofile
" set undolevels=1000 "maximum number of changes that can be undone
" set undoreload=10000 "maximum number lines to save for undo on a buffer reload

hi Normal ctermfg=252 ctermbg=none
imap jj <ESC>
" 定义快捷键到行首和行尾
"nmap lb 0
"nmap le $
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>pa %
"%nnoremap <c-j> <c-w>j
"%nnoremap <c-k> <c-w>k
"%nnoremap <c-h> <c-w>h
"%nnoremap <c-l> <c-w>l
nnoremap <c-i> %
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-l> <Right>
imap <c-h> <Left>


"macro
" change the header format
let @i="I\"<80>lxf:i\"<80>wi\"<80>lxA\",<80>j"

" Auto Session Save/Restore
function GetProjectName()
    " Get the current editing file list, Unix only
    let edit_files = split(system("ps -o command= -p " . getpid()))
    if len(edit_files) >= 2
        let project_path = edit_files[1]
        if project_path[0] != '/'
            let project_path = getcwd() . project_path
        endif
    else
        let project_path = getcwd()
    endif

    return shellescape(substitute(project_path, '[/]', '', 'g'))
endfunction

function SaveSession()
    "NERDTree doesn't support session, so close before saving
    execute ':NERDTreeClose' 
    let project_name = GetProjectName()
    execute 'mksession! ~/.vim/sessions/' . project_name
endfunction

function RestoreSession()
    let session_path = expand('~/.vim/sessions/' . GetProjectName())
    if filereadable(session_path)
        execute 'so ' . session_path
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
    "Make sure the syntax is on
    syntax on 
endfunction

function DeleteSession()
    let project_name = GetProjectName()
	let session_path = expand('~/.vim/sessions/' . GetProjectName())
	execute "!rm ". session_path
endfunction

nmap ssa :call SaveSession()
nmap sso :call RestoreSession()
nmap ssd :call DeleteSession()
"autocmd VimLeave * call SaveSession()
"autocmd VimEnter * call RestoreSession()




"""""""""""""""""""""""""""""
"Plugins					"
"""""""""""""""""""""""""""""
"set the runtime path to include Vundle and initialize
filetype plugin indent on    " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'easymotion/vim-easymotion'
"Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tomasr/molokai'
Plugin 'junegunn/vim-easy-align'
Plugin 'mhinz/vim-startify'
Plugin 'airblade/vim-gitgutter'
" ultisnip engine and snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'hail2u/vim-css3-syntax'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" All of your Plugins must be added before the following line
call vundle#end()            " required


"NERDTree Setting
nnoremap <silent> <F5> :NERDTree<CR>
let NERDTreeShowBookmarks=1 
"autocmd VimEnter * NERDTree
set gcr=a:block-blinkon0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"Airline Setting
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" nnoremap <C-N> :bn<CR>
" nnoremap <C-P> :bp<CR>
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#ctrlp#enabled = 1


"Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>

"Ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Colorscheme
let g:molokai_original = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" CSS3 highlight
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END

