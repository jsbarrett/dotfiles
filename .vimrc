" ------------------------------------------------------------------ "
"                           BASIC DEFAULTS                           "
" ------------------------------------------------------------------ "

set autoindent " new line will match previous line
set backspace=indent,eol,start " backspace as you would expect
set incsearch " while typing search start highlighting matches
set mouse=a " I like the option of using my mouse
set nocp " don't try to be compatible with vi
set smartindent " syntax cued indenting
set whichwrap+=<,>,h,l,[,] " allow keys to wrap to prev/next line when navigating
set wildmenu " command-line completion shows other options
filetype plugin on " vim should pay attention to filetype for colors/indenting
packadd cfilter " allows you to filter through the quickfix list
if !has('nvim')
  set ttymouse=xterm2 " allow mouse to change pane sizes in vim
endif

" ------------------------------------------------------------------ "
"                       PERSONAL PREFERENCES                         "
" ------------------------------------------------------------------ "

set breakindent " wrapped lines are indented visually
set clipboard^=unnamed,unnamedplus " sets default yank register to the system clipboard
" set colorcolumn=80 " signal when writing long lines of text
set foldlevel=100 " all folds are open by default
set foldmethod=indent " allows one to fold the code based on indentation
set grepprg=rg\ -S\ --vimgrep
" set list " displays list characters (tabs, spaces, etc)
set listchars=tab:>- " changes tabs to be >- visually
set noswapfile " get rid of those pesky .swp files
set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set ttimeoutlen=25 " improve speed from delay after hitting Escape
if has('nvim')
  set undodir=~/.vim/undo-nvim// " set undo history folder
else
  set undodir=~/.vim/undo-vim// " set undo history folder
endif
set undofile " save undo history for each file
let g:netrw_altfile = 1 " make ctrl-6 go to previous file and not netrw

" ------------------------------------------------------------------ "
"                           AUTOCOMMANDS                             "
" ------------------------------------------------------------------ "

" if has("autocmd")
"   " remove trailing white spaces on save
"   autocmd BufWritePre * :%s/\s\+$//e
" endif

" remember last line/position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" ------------------------------------------------------------------ "
"                           FZF SETTINGS                             "
" ------------------------------------------------------------------ "

set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>

" ------------------------------------------------------------------ "
"                           PATHOGEN                                 "
" ------------------------------------------------------------------ "

execute pathogen#infect()

" ------------------------------------------------------------------ "
"                           COLOR SETTINGS                           "
" ------------------------------------------------------------------ "

" this section is detecting the terminal to make sure to use 256 colors in vim
if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

" (I think) these two lines make sure screen clears after closing vim
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" italic codes
set t_ZH=[3m
set t_ZR=[23m

set termguicolors
syntax enable " give me pretty colors for syntax
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" ------------------------------------------------------------------ "
"                             MAPPINGS                               "
" ------------------------------------------------------------------ "

let g:mapleader = "\<SPACE>"
set timeoutlen=300

nnoremap K :silent grep! "<C-r><C-w>" \| cwindow \| redraw!<CR>
nnoremap <leader>f :silent grep! "" \| cwindow \| redraw!<S-left><S-left><S-left><S-left><left><left>
nnoremap <leader>h :set hlsearch!<cr>
nnoremap <leader>d :call fzf#run({ 'source': 'ls', 'sink': 'read', 'dir': '~/Downloads' })<cr>
nnoremap <leader><space> :Buffers<cr>
nnoremap <leader>i :CocCommand document.toggleInlayHint<cr>
nnoremap <leader>t :!tmux neww -c "%:p:h"<cr>

nnoremap <leader>us oconst [abc, setAbc] = useState(''):S/abc//g<left><left>

nnoremap <leader>df :read ~/.vim/javascript-function.js<CR>wcw
nnoremap <leader>dt :read ~/.vim/javascript-test.js<cr>0f'a
nnoremap <leader>h5 :read ~/.vim/html5.html<cr>kdd

nnoremap <A-j> j
nnoremap <A-k> k
nnoremap <A-l> l
nnoremap <A-h> h

" ------------------------------------------------------------------ "
"                       EXTERNAL PREFERENCES                         "
" ------------------------------------------------------------------ "

source $HOME/.vim/custom-preferences.vim

