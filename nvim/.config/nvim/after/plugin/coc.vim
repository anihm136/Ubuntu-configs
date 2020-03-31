if !exists("g:started_by_firenvim")
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  function! s:show_documentation() abort
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  autocmd custom_commands CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd custom_commands User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd custom_commands CursorHold * silent call CocActionAsync('highlight')

  if has('patch8.1.1068')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>": 
	\ coc#refresh()

  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  imap <C-z> <Plug>(coc-snippets-expand-jump)
  nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>
  nnoremap <silent> <F7> :call CocAction('format')<cr>
  nnoremap <silent> <F8> :CocCommand prettier.formatFile<cr>
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
endif
