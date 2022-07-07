set nocompatible
" filetype plugin on
syntax on
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
Plugin 'Luxed/ayu-vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-unimpaired'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/vim-peekaboo'
Plugin 'tomtom/tinykeymap_vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
Plugin 'dense-analysis/ale'
Plugin 'davidhalter/jedi'
Plugin 'airblade/vim-gitgutter'
Plugin 'simnalamburt/vim-mundo'

" Coding
Plugin 'vim-syntastic/syntastic'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'preservim/tagbar'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" Go
Plugin 'fatih/vim-go'

" Python
Plugin 'jeetsukumaran/vim-pythonsense'
Plugin 'vim-python/python-syntax'
" Plugin 'numirias/semshi'  " neovim
Plugin 'Vimjas/vim-python-pep8-indent'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
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

" Set color scheme
if exists('+termguicolors')
    " enable true colors support
    "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set background=dark    " for either mirage or dark version.
let g:ayucolor="dark"  " for dark version of theme
colorscheme ayu


" Remap leader
let mapleader = ","

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Edit vimr configuration file
nnoremap <Leader><C-e> :e $MYVIMRC<CR>

" Reload vims configuration file
nnoremap <Leader><C-r> :source $MYVIMRC<CR>

" Fix backspace
set bs=2

" Disable error
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" No tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse for all modes
set mouse=a

" Line numbering on
set number

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Easier pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Sensible pane opening
set splitbelow
set splitright

" Insert mode movement bindings
nnoremap <A-h> <C-O>h
nnoremap <A-j> <C-O>j
nnoremap <A-k> <C-O>k
nnoremap <A-l> <C-O>l

" ##### Plugins ######

" ### Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 8
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python', 'flake8']

" ### Gutentag
let g:gutentags_ctags_tagfile = '.ctags'
nmap <F8> :TagbarToggle<CR>

" ### incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ### Easy motion
map <Leader> <Plug>(easymotion-prefix)
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" ### gitgutter
highlight! link SignColumn LineNr
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ### tinykeymap
" Split resizing
call tinykeymap#EnterMap('winsize', '<C-W>+', {'name': 'Resize window'})
call tinykeymap#EnterMap('winsize', '<C-W>-', {'name': 'Resize window'})
call tinykeymap#EnterMap('winsize', '<C-W><', {'name': 'Resize window'})
call tinykeymap#EnterMap('winsize', '<C-W>>', {'name': 'Resize window'})
call tinykeymap#Map('winsize', '+', 'wincmd +')
call tinykeymap#Map('winsize', '-', 'wincmd -')
call tinykeymap#Map('winsize', '<', 'wincmd <')
call tinykeymap#Map('winsize', '>', 'wincmd >')

" ### vim-mundo
" Enable persistent undo so that undo history persists across vim sessions
 set undofile
 set undodir=~/.vim/undo
nmap <F5> :MundoToggle<CR>

" Ansible Vault: securing your editor
if expand('%:h') =~ '\~/.ansible/tmp'
    " Disable swapfiles that act like an autosave in case of crash or interruption.
    set noswapfile
    " Disable creation of backup files.
    set nobackup
    set nowritebackup
    " Disable the viminfo file from copying data from your current session.
    set viminfo=
    " Disable copying to the system clipboard.
    set clipboard=
endif

" Custom Python functions
function! PythonMain()
    -1r~/.vim/templates/python/main.py
    normal! 6gg
endfunction

:command! PythonMain :call PythonMain()
