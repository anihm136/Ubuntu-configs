"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Credits to Amir Salihefendic — @amix3k
"
"              _ _               __   _____  ____ _             _
"             (_) |             /  | |____ |/ ___( )           (_)
"   __ _ _ __  _| |__  _ __ ___ `| |     / / /___|/ ___  __   ___ _ __ ___  _ __ ___
"  / _` | '_ \| | '_ \| '_ ` _ \ | |     \ \ ___ \ / __| \ \ / / | '_ ` _ \| '__/ __|
" | (_| | | | | | | | | | | | | || |_.___/ / \_/ | \__ \  \ V /| | | | | | | | | (__
"  \__,_|_| |_|_|_| |_|_| |_| |_\___/\____/\_____/ |___/   \_/ |_|_| |_| |_|_|  \___|
"
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Goyo
nmap <silent> <leader>g :Goyo<cr>

" Clap
nmap <silent> <leader>ff :Clap filer<cr>
nmap <silent> <leader>bb :Clap buffers<cr>
nmap <silent> <leader>rg :Clap grep<cr>
nmap <silent> <leader>bl :Clap blines<cr>
nmap <silent> <leader>fd :Clap dotfiles<cr>

" coc.nvim
nmap <silent> <F7> :call CocAction('format')<cr>
nmap <silent> <F8> :CocCommand prettier.formatFile

" Gtags
nmap <silent> <F6> :call ToggleGtagsCscope()<cr>

" Fugitive
nmap <silent> <leader>gs :G<cr>
nmap <silent> <leader>gp :Gpush<cr>

" Sandwich
map s <NOP>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_fastbrowse = 0
nmap <silent> <Leader>0 :call ToggleNetrw()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

so ~/.config/nvim/plugged/plugins.vim

set splitbelow splitright   
set confirm
set mouse=a
set cscopeprg=cscope
set history=500
filetype plugin on
filetype indent on
set autoread
set noshowmode
set clipboard=unnamedplus
set completeopt=menuone,preview
set signcolumn=yes
set updatetime=100
set inccommand=nosplit
set scrolloff=10

nmap <leader>w :wa!<cr>
nmap <leader>W :w !sudo tee %<cr>
vmap y ygv<Esc> 
nnoremap g= mmgg=G'm
imap fd <Esc>
map <silent> <leader>r :set wrap!<cr>

augroup custom_commands
  autocmd!
  autocmd VimResized * wincmd =
  au FileType * set fo-=c fo-=r fo-=o
  au FocusGained,BufEnter * :checktime
  autocmd FileType help,plugins,fugitive nnoremap <silent><buffer> q :q<cr>
  autocmd FileType qf nnoremap <silent> <C-n> :cn<cr> | nnoremap <silent> <C-p> :cp<cr> | nnoremap <silent> q :call CloseQf()<cr>
  au BufWritePost init.vim,plugins.vim nested source %
  au FileType html,htmljinja,htmldjango,php nmap <silent><buffer> <F5> :call ToggleFt()<cr>
  au FileType php let b:is_php = 1
  autocmd FileType netrw setl bufhidden=wipe | nnoremap <silent><buffer> q :bw<cr>
augroup END

augroup ftdetect
  autocmd!
  autocmd BufRead,BufNewFile *.m,*.oct setlocal filetype=octave
  autocmd Filetype htmljinja exe "silent call DjangoFt()"
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu
set wildmode=full
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ruler
set rnu nu
set cmdheight=1
set hidden
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch 
set lazyredraw 
set magic
set showmatch 
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable 

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

try
  colorscheme onedark
catch
endtry
set background=dark

set encoding=utf8
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set lbr
set tw=500

set autoindent
set nowrap

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader><leader> :noh<cr>

nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

map <leader>bd :Bclose<cr>
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

map <leader>tn :tabnew<cr>
map <leader>tp :tabp<cr>
map <leader>to :tab sp<cr>
map <leader>tc :Bclose<cr> :tabclose<cr>

map <leader>e :edit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h<cr>:pwd<cr>

try
  set switchbuf=useopen,usetab
  set stal=2
catch
endtry

augroup edit_save
  autocmd!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map 0 ^
map Y y$

fun! CleanWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

augroup clean_spaces
  autocmd!
  autocmd BufWritePre *.txt,*.js,*.jsx,*.ts,*.tsx,*.py,*.wiki,*.sh,*.coffee,*.c,*.cpp,*.java call CleanWhitespace()
  autocmd VimEnter, BufRead, BufNewFile *.js,*.jsx,*.ts,*.tsx,*.py,*.coffee,*.c,*.cpp,*.java if !exists("b:cscope") | call ToggleGtagsCscope() | endif 
augroup END

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>rn :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>rn :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> rn :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> rn "sy:let @/=@s<CR>cgn

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <F2>
      \ :let @s='\<'.expand('<cword>').'\>'<CR>
      \ :Grepper -cword -noprompt<CR>
      \ :cfdo %s/<C-r>s//g \| update
      \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <F2>
      \ "sy
      \ gvgr
      \ :cfdo %s/<C-r>s//g \| update
      \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>q :e ~/buffer<cr>
map <leader>x :e ~/buffer.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
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

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
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

fun! ToggleFt()
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

fun! DjangoFt()
  if exists("b:is_django")
    set ft=htmldjango
  endif
endfunction

fun! ToggleGtagsCscope()
  if !exists("b:cscope")
    let b:cscope = 1
  endif
  if b:cscope == 1 && (filereadable("GTAGS") || filereadable("cscope.out"))
    execute 'silent cs kill -1'
    execute filereadable("cscope.out") ? 'silent cs add cscope.out' : 'silent cs add GTAGS'
    nnoremap <buffer><expr> gd ':cs find g ' . expand('<cword>') . '<cr>'
    nnoremap <buffer><expr> gr ':cs find c ' . expand('<cword>') . '<cr>'
    nnoremap <buffer><expr> gs ':cs find s ' . expand('<cword>') . '<cr>'
    let b:cscope = 0
    echo "cscope mode"
  else
    nnoremap <buffer> gd :Gtags<cr> 
    nnoremap <buffer> gr :Gtags -r<cr>
    nnoremap <buffer> gs :Gtags -g<cr>
    let b:cscope = 1
    echo "gtags mode"
  endif
endfunction

function! ToggleNetrw()
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

function! CloseQf()
  exe "ccl"
  unmap <C-n>
  unmap <C-p>
  unmap q
endfunction
