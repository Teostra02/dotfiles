nnoremap <SPACE> <Nop>
let mapleader=" " 

syntax on
set wrap
set modelines=0
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab
set textwidth=80
set noswapfile
set backspace=indent,eol,start
set showmode
set showcmd
set number
set relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase 
set path+=**
set wildmenu
set hidden
set clipboard+=unnamed
set encoding=utf-8
set mouse=a
set shell=/usr/bin/zsh

"Status Line -----------------------------------------------------------------
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

set laststatus=2
set statusline=
set statusline=%#SLBackground#
set statusline+=%{StatuslineGit()}
set statusline+=\ %{StatuslineMode()}
set statusline+=\ 
set statusline+=%n
set statusline+=\ %#SLFilename#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %#SLEncoding#
set statusline+=\ %{strlen(&fenc)?&fenc:'none'}
set statusline+=\ %#SLLines#
set statusline+=\ %l 
set statusline+=/
set statusline+=%L
set statusline+=\ %#SLPerc#
set statusline+=\ %P

augroup
  "autocmd!
  autocmd VimEnter,ColorScheme * highlight SLBackground ctermbg=58 guibg=#354c2b
  autocmd VimEnter,ColorScheme * highlight SLMode ctermfg=121 gui=bold guifg=Green
  autocmd VimEnter,ColorScheme * highlight SLFilename ctermbg=237 guibg=#373737
  autocmd VimEnter,ColorScheme * highlight SLEncoding ctermbg=10 guibg=Green
  autocmd VimEnter,ColorScheme * highlight SLLines ctermbg=10 guibg=#98971a
  autocmd VimEnter,ColorScheme * highlight SLPerc ctermbg=10 guibg=#3C6A47
"augroup END

" REMAPS ----------------------------------------------------------------------
nnoremap <leader>s :so %<CR>
imap jj <Esc> 

" Save and GET OUT!! ----------------------------------------------------------
nnoremap <leader>w :w<CR>
nnoremap <leader>q :wq!<CR>

" Fuzzy Finder ----------------------------------------------------------------
nnoremap <silent> <C-f> :Files<CR>  

" NERDTree --------------------------------------------------------------------
nnoremap <leader>t :NERDTreeToggle<CR>

" Buffers ---------------------------------------------------------------------
map <leader>n :bp<CR>
map <leader>m :bn<CR>
map <leader>d :bd<CR>

" Split view ------------------------------------------------------------------
set splitright
set splitbelow
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" For spliting windows --------------------------------------------------------
nnoremap <C-s> :vsplit<CR>
nnoremap <C-h> :split<CR>

" Bottom terminal -------------------------------------------------------------
noremap <leader>/ :below 15sp term://zsh<CR>i

set nocompatible 
filetype off

call plug#begin()
Plug 'scrooloose/nerdtree'                          " File sytem explorer
Plug 'scrooloose/nerdcommenter'                     " Easy commenting
Plug 'mattn/emmet-vim'                              " Emmet support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " For your fuzzy searches
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " VSC like intellicense
Plug 'ap/vim-css-color'                             " Colorizer for your css files
Plug 'ryanoasis/vim-devicons'                       " Icons for folders and files
Plug 'SirVer/ultisnips'
Plug 'honza//vim-snippets'
" Colorschemes
Plug 'dylanaraps/wal.vim'
Plug 'TheNiteCoder/mountaineer.vim'
call plug#end()

" Colorscheme settings -------------------------------------------------------
" set termguicolors " enable true colors support
set background=dark
colorscheme wal

" Plugin settings ------------------------------------------------------------
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'variables': {'lang': 'ja'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Coc cmmds ------------------------------------------------------------------
" :CocInstall 'plugin'
 ":CocUninstall 'plugin'
" :CocList extensions
" :CocList marketplace
