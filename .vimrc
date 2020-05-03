set number " show line numbers on the left
set list " displays list characters (tabs, spaces, etc)
set listchars=tab:>- " changes tabs to be >--- visually
set colorcolumn=80
set incsearch " while typing search start highlighting matches
set hlsearch " highlight all the matches when searching
set mouse=a " screw the purists, I like the option of using my mouse
set ttymouse=xterm2 " allow mouse to change pane sizes
set cursorline " highlights the line the cursor is on slightly
set foldmethod=indent " allows one to fold the code based on indentation
set foldlevel=100 " all folds are open by default
set wildmenu " command-line completion shows other options
set nocp " no one cares about being compatible with vi
set whichwrap+=<,>,h,l,[,] " allow keys to wrap to prev/next line when navigating
set backspace=indent,eol,start
filetype plugin on " vim should pay attention to filetype for colors/indenting
set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set autoindent " new line will match previous line
set breakindent " wrapped lines are indented visually
set smartindent " syntax cued indenting
set noswapfile " get rid of those pesky .swp files
set clipboard^=unnamed,unnamedplus " sets default yank register to the system clipboard
packadd cfilter

" set grepprg=git\ grep\ -n " git grep has way faster/better defaults than normal grep when in git projects
set grepprg=rg\ -S\ --vimgrep
" if you need to change it (because you're not in a git repo then just :set grepprg=grep\ -rn should do the trick
" the following is a shortcut for a reasonable default grepping method in vim
nnoremap <leader>f :gr! "" \| cw<left><left><left><left><left><left>

set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>

autocmd BufWritePre * %s/\s\+$//e " delete trailing whitespace on save

" gives ability to toggle comments like vs code
nnoremap <C-_> :Commentary<cr>
vnoremap <C-_> :Commentary<cr>

let g:NERDTreeWinSize = 30
nnoremap <C-e> :NERDTreeToggle<CR>
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                     \ exe "normal g'\"" | endif

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

" package manager
execute pathogen#infect()
