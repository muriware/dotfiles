" be iMproved
set nocompatible

" mac clipboard integration
set clipboard=unnamed

" encoding
set encoding=utf-8
scriptencoding utf-8

" file type configs
autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType rust setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType make setlocal ts=8 sts=4 sw=4 noexpandtab
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab

" file buffer configs
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd BufRead,BufNewFile *.http setfiletype rest

" cursor shape in different modes
let &t_SI.="\e[6 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[2 q"

" truecolor hack to make vim work well inside tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" color
syntax on
set termguicolors
set background=light
colorscheme solarized8

" highlights
highlight Comment cterm=italic gui=italic
let &colorcolumn=join(range(81,999),",")

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" misc
set listchars=tab:>\ ,eol:¬,trail:·

" space & tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" ui
set number
set noshowmode
set scrolloff=2
set laststatus=2
set backspace=indent,eol,start

" buffers
set hidden
set splitright
set splitbelow

" buffers navigation shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" maximize window and preserve splits
nmap tt :call Preserve("tabedit %")<CR>
nmap td :call Preserve("tabclose")<CR>

" disable arrow keys
nnoremap <up> :echoe "Use k"<CR>
nnoremap <down> :echoe "Use j"<CR>
nnoremap <left> :echoe "Use h"<CR>
nnoremap <right> :echoe "Use l"<CR>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" search
set ignorecase
set incsearch
set hlsearch

" searching shortcuts
nmap n nzz
nmap N Nzz

" line shortcuts
nnoremap j gj
nnoremap k gk

" esc shortcut
inoremap jk <esc>
inoremap <esc> <nop>

" remove trailing whitespace
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" indent everything
nmap _= :call Preserve("normal gg=G")<CR>
