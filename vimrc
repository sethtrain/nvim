" -----------------------------------------------------------------------------
" Pathogen
" -----------------------------------------------------------------------------
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

if has("autocmd")
    filetype plugin indent on
endif

" ------------------------------------------------------------------------------
" Visual Settings
" ------------------------------------------------------------------------------
colorscheme brookstream
syntax on
set ruler
set hidden
set guifont=Monaco:h15
set number
set wildmode=list:longest
set smartindent
set autoindent
set laststatus=2
set linespace=3
set splitbelow
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set mousehide
set showcmd
set foldenable
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{fugitive#statusline()}%y%=%-16(\ %l,%c-%v\ %)%P

" ------------------------------------------------------------------------------
" Gui options
" ------------------------------------------------------------------------------
if has('gui_running')
    set go-=T
    set go+=LlRrb
    set go-=LlRrb
endif

" ------------------------------------------------------------------------------
" Source .vimrc when saved
" ------------------------------------------------------------------------------
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" ------------------------------------------------------------------------------
" Automatically change current directory to that of the file in the buffer
" ------------------------------------------------------------------------------
" autocmd BufEnter * cd %:p:h

" ------------------------------------------------------------------------------
" Opens a vertical split and switches over
" ------------------------------------------------------------------------------
nnoremap ,v <C-w>v<C-w>l

" ------------------------------------------------------------------------------
" Saves time
" ------------------------------------------------------------------------------
nmap <space> :

" ------------------------------------------------------------------------------
" Normal mode mappings
" ------------------------------------------------------------------------------
nmap ,nt :NERDTreeToggle<cr>
nmap ,ev :tabedit $MYVIMRC<cr>

" ------------------------------------------------------------------------------
" Insert mode mappings
" ------------------------------------------------------------------------------
imap jj <esc>

" ------------------------------------------------------------------------------
" NERDTree Settings
" ------------------------------------------------------------------------------
let NERDTreeIgnore=['\.pyc']

" ------------------------------------------------------------------------------
" Trailing Space Helpers
" ------------------------------------------------------------------------------
" Highlight Trailing Space
highlight TrailingWhitespace ctermbg=darkgreen guibg=darkgreen
match TrailingWhitespace /\s\+$/
au TabEnter * :match TrailingWhitespace /\s\+$/

" Trailing space removal on save
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction
au BufWritePre * :call StripTrailingSpaces()
