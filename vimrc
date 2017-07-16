" ------------------------------------------------------------------------------
" VUNDLE
" ------------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

" Let Vundle manage Vundle (required)!
Plugin 'VundleVim/Vundle.vim'

" General Plugins
Plugin 'Lokaltog/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'diepm/vim-rest-console'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf.vim'
Plugin 'luochen1990/rainbow'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'rizzatti/dash.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'wellle/targets.vim'

" tpope plugins
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'

" Colors
Plugin 'flazz/vim-colorschemes'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'vim-scripts/paredit.vim'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'

" Ruby/Rails
Plugin 'tpope/vim-rails'


call vundle#end()
filetype plugin indent on

" ------------------------------------------------------------------------------
" GENERAL SETTINGS
" ------------------------------------------------------------------------------
set backup
set backupdir=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set clipboard=unnamed
set cmdheight=1
set directory=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set expandtab
set hidden
set mouse=a
set noerrorbells
set nofoldenable
set noshowmode
set number
set relativenumber
set numberwidth=5
set shiftwidth=2
set showcmd
set showmatch
set smartindent
set splitbelow
set splitright
set tabstop=2
set termencoding=utf-8
set undodir=~/.config/nvim/undo
set undofile
set undolevels=500
set undoreload=5000
set wildmode=list:longest,full

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=500

" ------------------------------------------------------------------------------
" VISUAL SETTINGS
" ------------------------------------------------------------------------------
colorscheme jellybeans

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Droid\ Sans\ Mono:h12
   endif
   set guioptions=m
endif

" ------------------------------------------------------------------------------
" wildignore settings
" ------------------------------------------------------------------------------
set wildignore+=out,.lein-cljsbuild-compiler*,*.pyc,node_modules,repl,uploads,*.log,workspace.xml

" ------------------------------------------------------------------------------
" FUN STUFF
" ------------------------------------------------------------------------------
source ~/.vim/say.vim

" ------------------------------------------------------------------------------
" GENERAL AND BUNDLE CONFIGURATION
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Airline
" ------------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='bubblegum'

" ------------------------------------------------------------------------------
" Fzf
" ------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf

" ------------------------------------------------------------------------------
" Gist
" ------------------------------------------------------------------------------
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$']

" ------------------------------------------------------------------------------
" Projectionist
" ------------------------------------------------------------------------------
let g:rails_projections = {
      \ "spec/factories/*.rb": {
      \   "command":   "factory",
      \   "affinity":  "collection",
      \   "alternate": "app/models/{singular}.rb",
      \   "related":   "db/schema.rb#{}",
      \   "test":      "spec/models/{singular}_test.rb",
      \   "template":  "FactoryGirl.define do\n  factory :{singular} do\n  end\nend",
      \   "keywords":  "factory sequence" },
      \ "app/uploaders/*.rb": {
      \   "command":   "uploader",
      \   "affinity":  "collection",
      \   "alternate": "app/models/{singular}.rb",
      \   "related":   "db/schema.rb#{}",
      \   "test":      "spec/uploaders/{singular}_test.rb" } }

" ------------------------------------------------------------------------------
" Vim REST Console
" ------------------------------------------------------------------------------
let g:vrc_set_default_mapping = 0
let g:vrc_include_response_header = 0
autocmd BufWritePre,BufRead es.rest :let $http_proxy = "socks5://localhost:1337"
autocmd BufWritePre,BufRead es.rest :let g:vrc_header_content_type = 'application/x-www-form-urlencoded'

" ------------------------------------------------------------------------------
" Vimux
" ------------------------------------------------------------------------------
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

" ------------------------------------------------------------------------------
" Highlight Trailing Space
" ------------------------------------------------------------------------------
highlight TrailingWhitespace ctermbg=darkgreen guibg=darkgreen
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/

" ------------------------------------------------------------------------------
" Trailing space removal on save
" ------------------------------------------------------------------------------
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction
au BufWritePre * :call StripTrailingSpaces()

" ------------------------------------------------------------------------------
" MAPPINGS
" ------------------------------------------------------------------------------

nnoremap <C-h> <C-w-h>
nnoremap <C-j> <C-w-j>
nnoremap <C-k> <C-w-k>
nnoremap <C-l> <C-w-l>

" ------------------------------------------------------------------------------
" Hack to get C-h working in NeoVim
" ------------------------------------------------------------------------------
nmap <BS> <C-W>h

" ------------------------------------------------------------------------------
" These will make it so that going to the next one in a
" search will center on the line it's found in.
" ------------------------------------------------------------------------------
map N Nzz
map n nzz

" ------------------------------------------------------------------------------
" Handle j and k better for long lines
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

" Thanks Apple touch bar
imap jj <Esc>
map <F4> :set paste<cr>:r !pbpaste<cr>:set nopaste<cr>
map <F5> :!ctags -R --exclude=.git --exclude=logs --exclude=doc --exclude=node_modules .<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-P> :Files<CR>
map <leader>B :Buffers<CR>
map <leader>G :Gist<cr>
map <leader>a :Ag!<space>--vimgrep<space>
map <leader>bd :bd<cr>
map <leader>cd :cd %%
map <leader>cn :e ~/Dropbox/notes/coding-notes.txt<cr>
map <leader>cs :let @/ = "" \| nohlsearch<cr>
map <leader>e :edit %%
map <leader>ev :e ~/.vim/vimrc<cr>
map <leader>fef gg=G<cr>``zz
map <leader>gc :Gcommit -m ""<left>
map <leader>gca :Gcommit -m -a ""<left>
map <leader>gs :Gstatus<cr>
map <leader>l :set list!<cr>
map <leader>te :tabe %%
map <leader>v <C-w>v<C-w>l
map <leader>> :vertical resize +5<cr>
map <leader>< :vertical resize -5<cr>

" Source file in vim (helpful when working with plugin)
map <leader>so :w \| :so %<cr>

" Disable Ex mode
nnoremap Q <Nop>

" ------------------------------------------------------------------------------
" RENAME CURRENT FILE (thanks Gary Bernhardt)
" ------------------------------------------------------------------------------
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
      exec ':saveas ' . new_name
      exec ':silent !rm ' . old_name
      redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

function! RelNumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>trn :call RelNumberToggle()<cr>

function! FormatJson()
  exec '%!python -m json.tool'
endfunction

nnoremap <leader>fj :call FormatJson()<cr>

" ------------------------------------------------------------------------------
" Vimux functions and mappings
" ------------------------------------------------------------------------------
let g:test_runner = "bin/rspec"
let g:test_location = "spec"

function! RunCurrentTest()
  let buffer = bufname("%")
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " ". buffer)
endfunction

function! RunAllTests()
  call VimuxSendKeys("C-l")
  call VimuxRunCommand(g:test_runner . " " . g:test_location)
endfunction

function! RunTut()
  call VimuxSendKeys("C-l")
  call VimuxRunCommand("sbt tut")
endfunction

map <silent> <leader>r :call RunCurrentTest()<cr>
map <silent> <leader>ra :call RunAllTests()<cr>
map <silent> <leader>rt :call RunTut()<cr>
map <silent> <leader>vl :VimuxRunLastCommand<cr>
map <silent> <leader>vq :VimuxCloseRunner<cr>
map <silent> <leader>vx :VimuxInterruptRunner<cr>
