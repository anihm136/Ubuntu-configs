call plug#begin('~/.config/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim'
Plug 'machakann/vim-sandwich'
Plug 'psliwka/vim-smoothie'
Plug 'honza/vim-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'haya14busa/is.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-grepper'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-fugitive'
Plug 'anihm136/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'liuchengxu/vim-clap'
Plug 'fedorenchik/gtags.vim'
Plug 'anihm136/jupyter-vim'
Plug 'szymonmaszke/vimpyter'
call plug#end()

" Airline customization
let g:airline_skip_empty_sections            = 1
let g:airline_section_error                  = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning                = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let airline#extensions#coc#stl_format_err    = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn   = '%W{[%w(#%fw)]}'
let g:airline#extensions#tabline#enabled     = 1
let g:airline#extensions#tabline#formatter   = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline_theme                          = 'onedark'
let g:airline_powerline_fonts                = 1
let g:airline#extensions#tabline#left_sep    = ' '

" NERDCommenter customization
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDCustomDelimiters = { 'htmljinja': { 'left': '{#','right': '#}' } }
let g:NERDSpaceDelims            = 1
let g:NERDCommentEmptyLines      = 0
let g:NERDTrimTrailingWhitespace = 1

" COC customization
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>": 
      \ coc#refresh()

inoremap <silent><expr> <cr>
      \ pumvisible() ? coc#_select_confirm() :
      \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
imap <C-j> <Plug>(coc-snippets-expand-jump)

nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Grepper
let g:grepper       = {}
let g:grepper.tools = ["rg"]

" Sandwich
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> saa <Plug>(operator-sandwich-add)<SID>line
nmap <silent> sdd <Plug>(operator-sandwich-delete)<SID>line
nmap <silent> srr <Plug>(operator-sandwich-replace)<SID>line

" Clap
function! s:ensure_closed() abort
  call clap#floating_win#close()
  silent! autocmd! ClapEnsureAllClosed
endfunction

function! MyClapOnEnter() abort
  augroup ClapEnsureAllClosed
    autocmd!
    autocmd BufEnter,WinEnter,WinLeave * call s:ensure_closed()
  augroup END
endfunction

augroup clapCommands
  autocmd!
  autocmd User ClapOnEnter call MyClapOnEnter()
  autocmd User ClapOnEnter map <silent><buffer> q :call clap#floating_win#close()<cr>
augroup END
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden -g "!.git/"'
let g:clap_provider_dotfiles = {
      \ 'source': ['~/.dotfiles/vim/.vim/.vimrc', '~/.dotfiles/vim/.vim/plugged/plug_vim.vim', '~/.dotfiles/nvim/.config/nvim/plugged/plugins.vim', '~/.dotfiles/nvim/.config/nvim/init.vim',  '~/.dotfiles/vifm/.config/vifm/vifmrc', '~/.zshrc', '~/.profile', '~/.sh_funcs'],
      \ 'sink': 'e',
      \ }

" Vimpyter
function! MyInit() abort
  let b:jupyter_kernel_type = 'python'
  call jupyter#MakeStandardCommands()
endfunction

let mapleader = " "
map s <NOP>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_fastbrowse = 0
nmap <silent> <Leader>0 :call ToggleNetrw()<cr>

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
set updatetime=200
set inccommand=nosplit
set scrolloff=10

nmap <leader>w :wa!<cr>
vmap y ygv<Esc>
nnoremap g= mmgg=G'm
imap fd <Esc>
map <silent> <leader>r :set wrap!<cr>

augroup custom_commands
  autocmd!
  autocmd VimResized * wincmd =
  au FileType * set fo-=c fo-=r fo-=o
  au FocusGained,BufEnter * :checktime
  autocmd FileType netrw setl bufhidden=wipe | nnoremap <silent><buffer> q :bw<cr>
augroup END

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

set nobackup
set nowb
set noswapfile

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set lbr
set tw=500

set autoindent
set nowrap

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

map <silent><leader>bd :Bclose<cr>
map <leader>ba :bufdo bd<cr>

map <silent><leader>l :bnext<cr>
map <silent><leader>h :bprevious<cr>
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

map 0 ^
map Y y$

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
