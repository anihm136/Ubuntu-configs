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
    nnoremap <silent><buffer> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent><buffer> gD <cmd>lua vim.lsp.buf.references()<CR>
    nmap <silent><buffer> gs <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
    let b:idxmode = 1
    let g:idxmode = 0
    echo "LSP mode"
  elseif b:idxmode == 1
    silent exe 'cs kill -1'
    if !filereadable("cscope.out")
      call inputsave()
      let l:op = input('Cscope file not found. Create?([p]ycscope|[c]scope|[n]one) ')
      call inputrestore()
      redraw
      if op == "c"
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
      nnoremap <silent><buffer><expr> gD ':cs find c ' . expand('<cword>') . '<cr>'
      nnoremap <silent><buffer><expr> gs ':cs find s ' . expand('<cword>') . '<cr>'
      nnoremap <silent><buffer> <Leader>rn :%s///g<Left><Left>
      nnoremap <silent><buffer> <Leader>rc :%s///gc<Left><Left><Left>

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
      nnoremap <silent><buffer> gD :GtagsCursor<cr>
      nnoremap <silent><buffer> gs :Gtags -g<cr>
      nnoremap <silent><buffer> <Leader>rn :%s///g<Left><Left>
      nnoremap <silent><buffer> <Leader>rc :%s///gc<Left><Left><Left>
      echo "gtags mode"
    endif
  endif
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

function! helpers#closeQf() abort
  silent exe "ccl"
  unmap <C-n>
  unmap <C-p>
  unmap q
endfunction

function! RemoveItalicFromHighlightCommand(somestring)
  let cmd=a:somestring
  let cmd=substitute(cmd, "italic",    "", "g") " remove italics
  let cmd=substitute(cmd, ",,",       ",", "g") " when italic occurs in middle of list, delete extraneous comma
  let cmd=substitute(cmd, ", ",       " ", "g") " when italic at end of list, delete extraneous comma
  let cmd=substitute(cmd, "gui\= ",   " ", "g") " when italic is only item in list, delete arg to avoid error
  let cmd=substitute(cmd, "term\= ",  " ", "g") " when italic is only item in list, delete arg to avoid error
  let cmd=substitute(cmd, "cterm\= ", " ", "g") " when italic is only item in list, delete arg to avoid error
  return cmd
endfunction

function! MakeColorChanges()
  redir @a | silent hi | redir END
  let @a=substitute(@a, "xxx", "", "g") " The :hi command displays 'xxx' to show what the groups look like
  let cmdlist = split(@a, "\n")
  call filter(cmdlist, 'v:val =~ "italic"')
  call filter(cmdlist, 'v:val !~ "links to"')
  call map(cmdlist, 'RemoveItalicFromHighlightCommand(v:val)')
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
  call MakeColorChanges()
  highlight Comment gui=italic
endfunction


