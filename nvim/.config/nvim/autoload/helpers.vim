function! helpers#bufcloseCloseIt() abort
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! s:CmdLine(str) abort
  call feedkeys(":" . a:str)
endfunction

function! helpers#cleanWhitespace() abort
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//ge
  silent! %s/\n/<0s0>/ge
  silent! s/\(<0s0>\)\+$//ge
  silent! s/<0s0>/\r/ge
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

function! helpers#visualSelection(direction, extra_filter) range abort
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

fun! helpers#toggleFt() abort
  if exists("b:is_php")
    if &filetype == 'php'
      set ft=html
      echo "HTML mode"
    else
      set ft=php
      echo "PHP mode"
    endif
  else
    if &filetype == 'htmljinja'
      set ft=htmldjango
      echo "Django mode"
    elseif &filetype == 'htmldjango'
      set ft=html
      echo "HTML mode"
    else
      set ft=htmljinja
      echo "Jinja mode"
    endif
  endif
endfunction

fun! helpers#djangoFt() abort
  if exists("b:is_django") && b:is_django
    set ft=htmldjango
  endif
endfunction

fun! helpers#toggleTags() abort
  if !exists("b:idxmode")
    if exists("g:idxmode")
      let b:idxmode = g:idxmode
    else
      let b:idxmode = 0
      let g:idxmode = 0
    endif
  endif
  if b:idxmode == 0
    nmap <silent><buffer> gd <Plug>(coc-definition)
    nmap <silent><buffer> gr <Plug>(coc-references)
    nmap <silent><buffer> gs <Plug>(coc-implementation)
    let b:idxmode = 1
    let g:idxmode = 0
    echo "LSP mode"
  elseif b:idxmode == 1
    silent exe 'cs kill -1'
    if !filereadable("cscope.out")
      call inputsave()
      let l:op = input('Cscope file not found. Create?([s]tarscope|[p]ycscope|[c]scope|[n]one) ')
      call inputrestore()
      redraw
      if op == "s"
        silent call system('starscope -e cscope')
      elseif op == "c"
      try
        silent call system("git ls-files > cscope.files && cscope -bcqR && rm -f cscope.files")
      catch
        silent call system("cscope -bcqR")
      endtry
      elseif op == "p"
        try
          silent call system("git ls-files > cscope.files && pycscope -i cscope.files && rm -f cscope.files")
        catch
          silent call system("pycscope -R")
        endtry
      else
        let l:skip = 1
      endif
    endif
    let b:idxmode = 2
    let g:idxmode = 1
    if exists("l:skip")
      call helpers#toggleTags()
    else
      silent exe 'cs add cscope.out'
      nnoremap <silent><buffer><expr> gd ':cs find g ' . expand('<cword>') . '<cr>'
      nnoremap <silent><buffer><expr> gr ':cs find c ' . expand('<cword>') . '<cr>'
      nnoremap <silent><buffer><expr> gs ':cs find s ' . expand('<cword>') . '<cr>'
      echo "cscope mode"
    endif
  else
    if !filereadable("GTAGS")
      call inputsave()
      let l:op = input('Gtags file not found. Create?([y]es|[n]o) ')
      call inputrestore()
      redraw
      if op == "y"
        if match(["c","cpp","java","php"], &filetype) != -1
          silent call system('gtags')
        else
          silent call system('gtags --gtagslabel=ctags')
        endif
      else
        let l:skip = 1
      endif
    endif
    let b:idxmode = 0
    let g:idxmode = 2
    if exists("l:skip")
      call helpers#toggleTags()
    else
      nnoremap <silent><buffer> gd :Gtags<cr>
      nnoremap <silent><buffer> gr :GtagsCursor<cr>
      nnoremap <silent><buffer> gs :Gtags -g<cr>
      echo "gtags mode"
    endif
  endif
endfunction

function! helpers#toggleNetrw() abort
  let l:flag = 1
  for i in range(1, winnr("$"))
    if getwinvar(i, '&filetype') == "netrw"
      silent exe 'bwipeout ' . winbufnr(i)
      let flag = 0
      break
    endif
  endfor
  if flag == 1
    silent exe 'Vex'
  endif
endfunction

function! helpers#closeQf() abort
  silent exe "ccl"
  unmap <C-n>
  unmap <C-p>
  unmap q
endfunction

