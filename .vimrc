autocmd! bufwritepost .vimrc source %

set nocompatible              " be iMproved, required
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
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Valloric/YouCompleteMe'
Plugin 'benmills/vimux'
Plugin 'scrooloose/nerdtree'
Plugin 'jgdavey/tslime.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'davidhalter/jedi-vim'

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

" paste toggle
set pastetoggle=<f2>

" by default, the indent is 4 spaces. 
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

" for python 2 spaces
autocmd Filetype python setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" ctrl-p cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ctrl-p show hidden
let g:ctrlp_show_hidden = 1

" ctrl-p-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Open Nerdtree when no file specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Nerdtree show hidden files
let NERDTreeShowHidden = 1

" Close Nerdtree on file open
let g:NERDTreeQuitOnOpen = 1

" Use current tmux for tslime
let g:tslime_always_current_session = 1

" youcompleteme close preview window
"let g:ycm_autoclose_preview_window_after_insertion = 1

" Disable preview window
set completeopt-=preview

" Setup YCM and jedi-vim
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0


let mapleader=","

" Run python files
"autocmd FileType python nnoremap<buffer> <F5> :call VimuxRunCommand("python " . bufname("%"))<CR>
autocmd FileType python nnoremap<buffer> <F5> :w<CR>:call VimuxRunCommand("clear")<CR>:call VimuxRunCommand("python " . fnamemodify(@%, ':p'))<CR>

autocmd FileType cpp nnoremap<buffer> <F6> :w<CR>:call VimuxRunCommand("clear")<CR>:call VimuxRunCommand("./make")<CR>
autocmd Filetype cpp nnoremap<buffer> <F5> :call VimuxRunCommand("clear")<CR>:call VimuxRunCommand("./run")<CR>

nnoremap <leader>rr :VimuxPromptCommand<CR>
nnoremap <leader>rl :VimuxRunLastCommand<CR>

" Zoom runner
"map <Leader>z :VimuxZoomRunner<CR>

" Toggle Nerdtree
map <leader>f :NERDTreeToggle<CR>

" buffer list
nnoremap <Leader>b :ls<CR>:b<Space>

" Combine VimuxZoomRunner and VimuxInspectRunner in one function.
function! VimuxZoomInspectRunner()
  if exists("g:VimuxRunnerIndex")
    call _VimuxTmux("select-"._VimuxRunnerType()." -t ".g:VimuxRunnerIndex)
    call _VimuxTmux("resize-pane -Z -t ".g:VimuxRunnerIndex)
    call _VimuxTmux("copy-mode")
  endif
endfunction

"nnoremap <leader>z :call VimuxZoomInspectRunner()<CR>
nnoremap <leader>z :call VimuxZoomInspectRunner()<CR>

