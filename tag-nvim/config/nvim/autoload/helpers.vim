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
  silent redrawtabline
endfunction

function! s:CmdLine(str) abort
  call feedkeys(":" . a:str)
endfunction

function! helpers#cleanWhitespace() abort
  let l = line(".")
  let c = col(".")
  keepp %s/\s\+$//e
  call cursor(l, c)
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

fun! helpers#navMap(mode) abort
  silent! nunmap <buffer> <leader>cd
  silent! nunmap <buffer> <leader>cD
  silent! nunmap <buffer> <leader>cr
  silent! nunmap <buffer> <leader>cn
  silent! nunmap <buffer> <leader>ca
  silent! nunmap <buffer> g0
  silent! nunmap <buffer> gW
  if a:mode == 1
    nnoremap <silent><buffer> <leader>cd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent><buffer> <leader>cD <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent><buffer> <leader>cr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent><buffer> <leader>cn <cmd>lua LspRenameFloat()<CR>
    nnoremap <silent><buffer> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
    nnoremap <silent><buffer> g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent><buffer> gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  elseif a:mode == 2
    nnoremap <silent><buffer><expr> <leader>cd ':cs find g ' . expand('<cword>') . '<cr>'
    nnoremap <silent><buffer><expr> <leader>cD ':cs find c ' . expand('<cword>') . '<cr>'
    nnoremap <silent><buffer><expr> <leader>cs ':cs find s ' . expand('<cword>') . '<cr>'
  elseif a:mode == 3
    nnoremap <silent><buffer> <leader>cd :Gtags<cr>
    nnoremap <silent><buffer> <leader>cD :GtagsCursor<cr>
    nnoremap <silent><buffer> <leader>cs :Gtags -g<cr>
    nnoremap <silent><buffer> g0 :Gtags -f %<cr>
  endif
endfunction

fun! helpers#toggleTags() abort
  let l:op = confirm("Choose completion/navigation method:", "&LSP\n&Cscope\nC&tags\n&Skip", 4)
  call helpers#navMap(l:op)

  if l:op == 1
    return 1
  elseif l:op == 2
    silent exe 'cs kill -1'
    if !filereadable("cscope.out")
      redraw
      let l:op2 = confirm("Cscope file not found. Create?", "&pycscope\n&cscope\n&skip", 3)
      if l:op2 == 2
        try
          silent call system("git ls-files > cscope.files && cscope -bcqR && rm -f cscope.files")
        catch
          silent call system("cscope -bcqR")
        endtry
      elseif l:op2 == 1
        try
          silent call system("git ls-files > cscope.files && pycscope -i cscope.files && rm -f cscope.files")
        catch
          silent call system("pycscope -R")
        endtry
      endif
    endif
    if exists("l:skip")
      return -1
    else
      silent exe 'cs add cscope.out'
      return 2
    endif
  elseif l:op == 3
    if !filereadable("GTAGS")
      redraw
      let l:op2 = confirm('Gtags file not found. Create?', "&yes\n&skip", 2)
      if l:op2 == 1
        if match(["c","cpp","java","php"], &filetype) != -1
          silent call system('gtags')
        else
          call system('gtags --gtagslabel=ctags')
        endif
      else
        let l:skip = 1
      endif
    endif
    if exists("l:skip")
      return -1
    else
      return 3
    endif
  endif

  return -1
endfunction

function! helpers#toggleFileExplorer() abort
  let l:flag = 1
  for i in range(1, winnr("$"))
    if getwinvar(i, '&filetype') == "dirvish"
      silent exe 'bwipeout ' . winbufnr(i)
      let flag = 0
      break
    endif
  endfor
  if flag == 1
    silent exe 'Vexplore'
    nmap <buffer> <cr> :call dirvish#open("edit",1)<cr>
    nmap <buffer><silent> q gq:q<CR>
  endif
endfunction

function! s:IsQfWindow(nmbr)
  if getwinvar(a:nmbr, "&filetype") == "qf"
    return getbufvar(winbufnr(a:nmbr), "qf_isLoc") == 1 ? 0 : 1
  endif
  return 0
endfunction

" returns bool: Is quickfix window open?
function! s:IsQfWindowOpen() abort
  for winnum in range(1, winnr('$'))
    if s:IsQfWindow(winnum)
      return 1
    endif
  endfor
  return 0
endfunction

function! helpers#mapQf() abort
  let b:qf_isLoc = !empty(getloclist(0))
  if s:IsQfWindowOpen()
    nnoremap <silent> <C-n> :cnext<cr>
    nnoremap <silent> <C-p> :cprevious<cr>
    nnoremap <silent> q :call helpers#closeQf()<cr>
  else
    nnoremap <silent> <C-n> :lnext<cr>
    nnoremap <silent> <C-p> :lprevious<cr>
    nnoremap <silent> q :call helpers#closeQf()<cr>
  endif
endfunction

function! helpers#closeQf() abort
  silent exe "ccl"
  silent exe "lcl"
  unmap <C-n>
  unmap <C-p>
  unmap q
endfunction

function! s:RemoveItalicFromHighlightCommand(somestring)
  let cmd=a:somestring
  let cmd=substitute(cmd, "italic",    "", "g") " remove italics
  let cmd=substitute(cmd, ",,",       ",", "g") " when italic occurs in middle of list, delete extraneous comma
  let cmd=substitute(cmd, ", ",       " ", "g") " when italic at end of list, delete extraneous comma
  let cmd=substitute(cmd, "gui\= ",   " ", "g") " when italic is only item in list, delete arg to avoid error
  let cmd=substitute(cmd, "term\= ",  " ", "g") " when italic is only item in list, delete arg to avoid error
  let cmd=substitute(cmd, "cterm\= ", " ", "g") " when italic is only item in list, delete arg to avoid error
  return cmd
endfunction

let s:sid = expand('<SID>')
function! s:MakeColorChanges()
  redir @a | silent hi | redir END
  let @a=substitute(@a, "xxx", "", "g") " The :hi command displays 'xxx' to show what the groups look like
  let cmdlist = split(@a, "\n")
  call filter(cmdlist, 'v:val =~ "italic"')
  call filter(cmdlist, 'v:val !~ "links to"')
  let l:fun = s:sid . 'RemoveItalicFromHighlightCommand(v:val)' 
  call map(cmdlist, l:fun)
  for cmd in cmdlist
    let test = split(cmd, " ")
    if index(test, "c") != -1 || index(test, "cleared") != -1
      continue
    endif
    let groupname=split(cmd, " ")[0]
    try
      execute "hi clear ".groupname
      execute "hi default ".cmd
    catch
      echo groupname
      echo cmd
    endtry
  endfor
endfunction

function! helpers#setColorscheme(...) abort
  if a:0 == 0
    let l:color = 'dark'
  else
    let l:color = a:1
  endif

  let l:dark_themes = ["spacegray", "equinusocio_material", "sonokai", "tender", "solarized8_flat", "gruvbox", "gruvbit"]

  let l:light_themes = ["solarized8_flat", "gruvbox"]

  let l:all_themes = extend(copy(dark_themes), light_themes)

  let l:select = [dark_themes, light_themes]

  if l:color == 'dark' || l:color == 'light'
    let g:spacegray_low_contrast = 1
    let g:solarized_italics = 0
    let g:solarized_extra_hi_groups = 1
    let g:equinusocio_material_style = 'darker'
    let g:equinusocio_material_hide_vertsplit = 1
    let g:sonokai_sign_column_background = 'none'
    let g:sonokai_diagnostic_line_highlight = 1
    silent exec "set background=" . l:color
    let l:theme_set = select[(l:color == 'dark' ? 0 : 1)]
    let l:themeIndex = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]) % len(l:theme_set)
    let l:colorscheme = l:theme_set[l:themeIndex]
    exec "colorscheme " . l:colorscheme
    echo l:colorscheme
  else
    exec "colorscheme " . l:color
    echo l:color
  endif
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight FoldColumn ctermbg=NONE guibg=NONE
  call s:MakeColorChanges()
  highlight Comment gui=italic
endfunction

function! helpers#vim_reload() abort
    silent! update
    SSave! reload
    call system('kill -USR1 $(ps -p $(ps -p $$ -o ppid=) -o ppid=)')
    qa!
endfu
