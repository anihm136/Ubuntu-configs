let b:AutoPairs = AutoPairs 
call AutoPairsInit() 
let b:AutoPairs = AutoPairsDefine({"<":">"}) 
call AutoPairsInit() 

imap <C-l> <C-y>,
imap <C-k> <C-y>n
nnoremap <silent><buffer> <F5> :call helpers#toggleFt()<cr>
