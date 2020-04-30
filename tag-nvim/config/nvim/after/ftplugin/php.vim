let b:AutoPairs = AutoPairs 
call AutoPairsInit() 
let b:AutoPairs = AutoPairsDefine({"<?":"?>", "<?php":"?>", "<":">"}) 
call AutoPairsInit() 

let b:is_php = 1
nnoremap <silent><buffer> <F5> :call helpers#toggleFt()<cr>
