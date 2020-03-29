map s <NOP>

onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> saa <Plug>(operator-sandwich-add)<SID>line
nmap <silent> sdd <Plug>(operator-sandwich-delete)<SID>line
nmap <silent> srr <Plug>(operator-sandwich-replace)<SID>line

