nmap <buffer> t :let @f=@%<CR>:terminal<CR>cd <C-w>"f<CR>
nmap <buffer> D :!rm -rf <C-r>=expand("%") . "/" . "<C-r><C-l>"<CR>

