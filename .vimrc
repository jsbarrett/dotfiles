" ------------------------------------------------------------------ "
"                           BASIC DEFAULTS                           "
" ------------------------------------------------------------------ "

set number " show line numbers on the left
set incsearch " while typing search start highlighting matches
set hlsearch " highlight all the matches when searching
set mouse=a " screw the purists, I like the option of using my mouse
set ttymouse=xterm2 " allow mouse to change pane sizes
set foldmethod=indent " allows one to fold the code based on indentation
set foldlevel=100 " all folds are open by default
set wildmenu " command-line completion shows other options
set nocp " no one cares about being compatible with vi
set whichwrap+=<,>,h,l,[,] " allow keys to wrap to prev/next line when navigating
set backspace=indent,eol,start
filetype plugin on " vim should pay attention to filetype for colors/indenting
set autoindent " new line will match previous line
set breakindent " wrapped lines are indented visually
set smartindent " syntax cued indenting
packadd cfilter " allows you to filter through the quickfix list

" ------------------------------------------------------------------ "
"                       PERSONAL PREFERENCES                         "
" ------------------------------------------------------------------ "

set colorcolumn=80
set cursorline " highlights the line the cursor is on slightly
set list " displays list characters (tabs, spaces, etc)
set listchars=tab:>- " changes tabs to be >--- visually

set undodir=~/.vim/undo//
set undofile
set noswapfile " get rid of those pesky .swp files

set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set clipboard^=unnamed,unnamedplus " sets default yank register to the system clipboard

" reset to default with :set grepprg=grep\ -rn
" ripgrep is much faster; can use git grep if rg is not installed
set grepprg=rg\ -S\ --vimgrep

" ------------------------------------------------------------------ "
"                             MAPPINGS                               "
" ------------------------------------------------------------------ "

" the following is a shortcut for a reasonable default grepping method in vim
nnoremap <leader>f :grep! "" \| cwindow<left><left><left><left><left><left><left><left><left><left><left>

" ------------------------------------------------------------------ "
"                           AUTOCOMMANDS                             "
" ------------------------------------------------------------------ "

if has("autocmd")
  " remove trailing white spaces on save
  autocmd BufWritePre * :%s/\s\+$//e
endif

" remember last line/position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" ------------------------------------------------------------------ "
"                        NERDTREE SETTINGS                           "
" ------------------------------------------------------------------ "

let g:NERDTreeWinSize = 30
let NERDTreeMinimalUI = 1
let NERDTreeMouseMode = 3
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
nnoremap <C-e> :NERDTreeToggle<CR>
command NF NERDTreeFind

" ------------------------------------------------------------------ "
"                           FZF SETTINGS                             "
" ------------------------------------------------------------------ "

set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :FZF<CR>

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

syntax enable " give me pretty colors for syntax
colorscheme codedark " decent colorscheme

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" ------------------------------------------------------------------ "
"                           PATHOGEN                                 "
" ------------------------------------------------------------------ "

execute pathogen#infect()
