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
" set path+=**
set wildmenu " command-line completion shows other options
set wildignore+=node_modules/* " when searching files ignore node_modules
set nocp " no one cares about being compatible with vi
set whichwrap+=<,>,h,l,[,] " allow keys to wrap to prev/next line when navigating
set backspace=indent,eol,start
filetype plugin on " vim should pay attention to filetype for colors/indenting
set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set autoindent " new line will match previous line
set breakindent " wrapped lines are indented visually
set smartindent " syntax cued indenting
set noswapfile " get rid of those pesky .swp files
set clipboard=unnamed " sets default yank register to the system clipboard

set grepprg=git\ grep\ -n " git grep has way faster/better defaults than normal grep when in git projects
" if you need to change it (because you're not in a git repo then just :set grepprg=grep\ -rn should do the trick
" the following is a shortcut for a reasonable default grepping method in vim
nnoremap <leader>f :gr! "" \| cw<left><left><left><left><left><left>

autocmd BufWritePre * %s/\s\+$//e " delete trailing whitespace on save

source ~/.vim/bundle/secure-shell-clipboard/osc52.vim
vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>

" gives ability to toggle comments like vs code
nnoremap <C-_> :Commentary<cr>
vnoremap <C-_> :Commentary<cr>

if has("autocmd")
  " remove trailing white spaces on save
  autocmd BufWritePre * :%s/\s\+$//e
endif

let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = 'i' " when opening multiple files open as hidden buffers

let g:NERDTreeWinSize = 20
nnoremap <C-e> :NERDTreeToggle<CR>
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                     \ exe "normal g'\"" | endif

" this section is detecting the terminal to make sure to use 256 colors in vim
if &term =~ "xterm"
  " change cursor to a line when in insert mode
  let &t_SI = "\<esc>[5 q"
  let &t_EI = "\<esc>[2 q"

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
colorscheme OceanicNext " decent colorscheme

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" package manager
execute pathogen#infect()

