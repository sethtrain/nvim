" ------------------------------------------------------------------------------
" vim-plug
" ------------------------------------------------------------------------------
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'liuchengxu/vim-better-default'

" Plugins
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'dracula/vim'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" Languages
" ------------------------------------------------------------------------------
Plug 'tpope/vim-rails'

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme jellybeans

" ------------------------------------------------------------------------------
" GENERAL SETTINGS
" ------------------------------------------------------------------------------
set autowrite
set autoread
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start
set clipboard=unnamed
set mouse=a
set undodir=~/.vim/undo
set undofile
set undolevels=500
set undoreload=5000

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,*.pyc,node_modules,repl,uploads,*.log,workspace.xml,vendor,__pycache__

" ------------------------------------------------------------------------------
" airline
" ------------------------------------------------------------------------------
let g:airline_powerline_fonts = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''

" ------------------------------------------------------------------------------
" Better whitespace
" ------------------------------------------------------------------------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" ------------------------------------------------------------------------------
" FZF
" ------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag --ignore "venv" --ignore "vendor" --ignore "*.pyc" --ignore "datadir" --ignore "tmp" --ignore "node_modules" --ignore "build" --ignore "gradle" --ignore "gradlew.bat" --ignore "gradlew" -l -U -g ""'

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$', 'datadir', 'node_modules', '__pycache__']

" ------------------------------------------------------------------------------
" Tagbar
" ------------------------------------------------------------------------------
let g:tagbar_left = 0

" ------------------------------------------------------------------------------
" Tmuxline
" ------------------------------------------------------------------------------
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '
    \}

" ------------------------------------------------------------------------------
" Vimux
" ------------------------------------------------------------------------------
" let g:VimuxOrientation = "h"
let g:VimuxHeight = "30"

" ------------------------------------------------------------------------------
" These will make it so that going to the next one in a
" search will center on the line it's found in.
" ------------------------------------------------------------------------------
map N Nzz
map n nzz

" ------------------------------------------------------------------------------
" Handle j and k better for long lines that are wrapped
" ------------------------------------------------------------------------------
nmap j gj
nmap k gk

" ------------------------------------------------------------------------------
" Fixes strange issue when using vim (terminal) within tmux
" ------------------------------------------------------------------------------
map <Esc>[B <Down>

" ------------------------------------------------------------------------------
" Better file expansion
" ------------------------------------------------------------------------------
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>

" ------------------------------------------------------------------------------
" GENERAL LEADER AND 'OTHER' BINDINGS
" ------------------------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

nmap <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
nmap <F3> :TagbarToggle<CR>
map <C-N> :NERDTreeToggle<cr>
map <C-P> :Files<cr>
map <leader>B :Buffers<cr>
map <leader>D :Dispatch<cr>
map <leader>N :ALENext<cr>
map <leader>P :ALEPrevious<cr>
map <leader>aa :A<cr>
map <leader>a :Ag<cr>
map <leader>bd :bd<cr>
map <leader>ev :e ~/.vim/vimrc<cr>
map <leader>v <C-w>v<C-w>l
map <leader>> :vertical resize +5<cr>
map <leader>< :vertical resize -5<cr>

" Source file in vim (helpful when working with plugin)
map <leader>so :w \| :so %<cr>

" Disable Ex mode
nnoremap Q <Nop>

" ------------------------------------------------------------------------------
" Vimux functions and mappings
" ------------------------------------------------------------------------------
let g:pre_runner_ran = 0
let g:pre_runner = $PRE_RUNNER
let g:test_runner = $TEST_RUNNER
let g:test_location = $TEST_LOCATION
let g:build_runner = $BUILD_RUNNER
let g:runner = $RUNNER

function! OpenRunner()
    let g:pre_runner_ran = 1
    call VimuxRunCommand(g:pre_runner)
endfunction

function! RunCurrentTest()
    if g:pre_runner_ran == 0
        call OpenRunner()
    endif
    let buffer = bufname("%")
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:test_runner . " ". buffer)
endfunction

function! RunLastTest()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunLastCommand()
endfunction

function! RunAllTests()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:test_runner . " " . g:test_location)
endfunction

function! RunBuild()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:build_runner)
endfunction

function! RunRunner()
    if g:pre_runner_ran == "false"
        call OpenRunner()
    endif
    call VimuxSendKeys("C-l")
    call VimuxRunCommand(g:runner)
endfunction

function! VimuxCancel()
    let g:pre_runner_ran = 0
    call VimuxSendKeys("C-l")
    call VimuxSendKeys("C-c")
endfunction

map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rb :call RunBuild()<cr>
map <silent> <leader>rf :call RunCurrentTest()<cr>
map <silent> <leader>rl :call RunLastTest()<cr>
map <silent> <leader>rr :call RunRunner()<cr>
map <silent> <leader>vc :call VimuxCancel()<cr>
map <silent> <leader>vq :call VimuxCloseRunner()<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>


func! s:SetBreakpoint()
    cal append('.', repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import pdb; pdb.set_trace()')
endf

func! s:RemoveBreakpoint()
    exe 'silent! g/^\s*import\spdb\;\?\n*\s*pdb.set_trace()/d'
endf

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*import\spdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf
nnoremap <leader>bp :call <SID>ToggleBreakpoint()<CR>

function! ToggleQuickfix()
    for buffer in tabpagebuflist()
        if bufname(buffer) == ''
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <leader>c :call ToggleQuickfix()<CR>

if filereadable("pelicanconf.py")
    nmap <leader>G :Dispatch pipenv run generate<cr>
    nmap <leader>R :Dispatch pipenv run preview<cr>
endif
