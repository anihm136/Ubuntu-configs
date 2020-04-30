call plug#begin('~/.config/nvim/plugged')
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

let g:dont_write = v:false
function! My_Write(timer) abort
  let g:dont_write = v:false
  write
endfunction

function! Delay_My_Write() abort
  if g:dont_write
    return
  end
  let g:dont_write = v:true
  call timer_start(10000, 'My_Write')
endfunction

augroup firenvim
  autocmd!
  autocmd BufEnter localhost_notebooks-* set ft=python | syntax on
  au TextChanged * ++nested call Delay_My_Write()
  au TextChangedI * ++nested call Delay_My_Write()
augroup END

let g:firenvim_config = { 
      \ 'globalSettings': {
      \ 'alt': 'all',
      \  },
      \ 'localSettings': {
      \ '.*': {
      \ 'priority': 0,
      \ 'selector': 'textarea',
      \ 'takeover': 'never',
      \ 'cmdline': 'firenvim'
      \ },
      \ }
      \ }
colorscheme deus

nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
nmap <C-e> ZZ
inoremap fd <Esc>
