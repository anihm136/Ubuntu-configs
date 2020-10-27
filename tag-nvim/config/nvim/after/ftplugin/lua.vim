let &l:include = '\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+'
let s:sid = expand('<SID>')
let &l:includeexpr = s:sid . 'LuaInclude(v:fname)'

function! s:LuaInclude(fname) abort
	let module = substitute(a:fname, '\.', '/', 'g')
	for template in s:GetSearchPath('package.path')
		let expanded = substitute(template, '?', module, 'g')
		if filereadable(expanded)
			return expanded
		endif
	endfor
	return a:fname
endfunction

function! s:GetSearchPath(luavar)
  let path = printf("%s", execute('lua print(' . a:luavar . ')'))
  return split(path, ';')
endfunction
