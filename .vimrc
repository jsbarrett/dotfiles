set number " show line numbers on the left
set list " displays list characters (tabs, spaces, etc)
set listchars=tab:>- " changes tabs to be >--- visually
set colorcolumn=80
set incsearch " while typing search start highlighting matches
set hlsearch " highlight all the matches when searching
set mouse=a " screw the purists, I like the option of using my mouse
set cursorline " highlights the line the cursor is on slightly
set foldmethod=indent " allows one to fold the code based on indentation
set foldlevel=100 " all folds are open by default
" set path+=**
set wildmenu " command-line completion shows other options
set wildignore+=node_modules/* " when searching files ignore node_modules
set autoindent " new line will match previous line
set smartindent " syntax cued indenting
set breakindent " wrapped lines are indented visually
set tabstop=2 shiftwidth=2 smarttab expandtab " spaces > tabs
set nocp " no one cares about being compatible with vi
set whichwrap+=<,>,h,l,[,] " allow keys to wrap to prev/next line when navigating
set backspace=indent,eol,start
filetype plugin on

source ~/.vim/bundle/secure-shell-clipboard/osc52.vim
vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>

let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_open_multiple_files = 'i' " when opening multiple files open as hidden buffers

let g:NERDTreeWinSize = 20
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
colorscheme monokai " decent colorscheme

" package manager
execute pathogen#infect()

