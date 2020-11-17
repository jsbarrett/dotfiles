" ------------------------------------------------------------------ "
"                           BASIC DEFAULTS                           "
" ------------------------------------------------------------------ "

set autoindent " new line will match previous line
set backspace=indent,eol,start " backspace as you would expect
set breakindent " wrapped lines are indented visually
set cursorline " highlights the line the cursor is on slightly
set foldlevel=100 " all folds are open by default
set foldmethod=indent " allows one to fold the code based on indentation
set hlsearch " highlight all the matches when searching
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

set clipboard^=unnamed,unnamedplus " sets default yank register to the system clipboard
set colorcolumn=80 " signal when writing long lines of text
set grepprg=rg\ -S\ --vimgrep
set list " displays list characters (tabs, spaces, etc)
set listchars=tab:>- " changes tabs to be >- visually
set nonumber " don't show line numbers on the left
set noswapfile " get rid of those pesky .swp files
set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set ttimeoutlen=25 " improve speed from delay after hitting Escape
set undodir=~/.vim/undo// " set undo history folder
set undofile " save undo history for each file
let g:netrw_altfile = 1 " make ctrl-6 go to previous file and not netrw

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

syntax enable " give me pretty colors for syntax
colorscheme codedark " decent colorscheme

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" ------------------------------------------------------------------ "
"                    MAPPINGS/WHICH KEY SETTINGS                     "
" ------------------------------------------------------------------ "

let g:mapleader = "\<SPACE>"
set timeoutlen=300

" the following mapping is a shortcut for a reasonable default grepping method in vim
nnoremap <leader>f :grep! "" \| cwindow<S-left><S-left><left><left>
nnoremap <leader>p :FZF<CR>
nnoremap <leader>e :e .<CR>

nnoremap <silent> <leader> :WhichKey '<SPACE>'<CR>
call which_key#register("<SPACE>", "g:which_key_map")

let g:which_key_map = {}
let g:which_key_map["f"] = "grep"
let g:which_key_map["p"] = "find file"
let g:which_key_map["e"] = "explorer"

let g:which_key_map["*"] = "which_key_ignore"
let g:which_key_map["h"] = { "name": "which_key_ignore" }

" ------------------------------------------------------------------ "
"                       EXTERNAL PREFERENCES                         "
" ------------------------------------------------------------------ "
source $HOME/.vim/custom-preferences.vim

