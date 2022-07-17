" Vim way
nmap <buffer> t :let @f=@%<CR>:terminal<CR>cd <C-w>"f<CR>

" Neovim way
" tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" nmap <buffer> t :let @f=@%<CR>:sp<CR>:terminal<CR>icd <C-R>f<CR>
" au TermClose * silent
