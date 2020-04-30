let b:AutoPairs = AutoPairs 
call AutoPairsInit() 
let b:AutoPairs = AutoPairsDefine({"<":">"}) 
call AutoPairsInit() 

nnoremap <silent><buffer> <F5> :call helpers#toggleFt()<cr>
