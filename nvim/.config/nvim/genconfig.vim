""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
nmap <silent> <F8> :CocCommand prettier.formatFile<cr>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Gtags
nmap <silent> <F6> :call helpers#toggleTags()<cr>

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
nmap <silent> <Leader>0 :call helpers#toggleNetrw()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
so ~/.config/nvim/plugged/plugins.vim

set splitbelow splitright
set confirm
set mouse=a
set cscopeprg=cscope
set history=500
filetype plugin indent on
set autoread
set noshowmode
set clipboard=unnamedplus
set completeopt=menuone,preview
set signcolumn=yes
set updatetime=200
set inccommand=nosplit
set scrolloff=10

nnoremap <leader>w :wa!<cr>
nnoremap <leader>W :w !sudo tee %<cr>
vnoremap y ygv<Esc>
nnoremap g= mmgg=G'm
inoremap fd <Esc>
nnoremap <silent> <leader>r :set wrap!<cr>

augroup custom_commands
  autocmd!
augroup END

autocmd custom_commands VimResized * wincmd =
autocmd custom_commands FileType * set fo-=c fo-=r fo-=o
autocmd custom_commands FocusGained,BufEnter * :checktime
autocmd custom_commands FileType help,plugins,fugitive nnoremap <silent><buffer> q :q<cr>
autocmd custom_commands FileType qf nnoremap <silent> <C-n> :cn<cr> | nnoremap <silent> <C-p> :cp<cr> | nnoremap <silent> q :call helpers#closeQf()<cr>
autocmd custom_commands BufWritePost init.vim,plugins.vim nested source %
autocmd custom_commands FileType netrw setl bufhidden=wipe | nnoremap <silent><buffer> q :bw<cr>

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
set relativenumber number
set cmdheight=1
set hidden
set backspace=indent,eol,start
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

set lbr
set tw=500

set autoindent
set nowrap

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

vnoremap <silent> * :<C-u>call helpers#visualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call helpers#visualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader><leader> :noh<cr>

nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

map <silent><leader>bd :call helpers#bufcloseCloseIt()<cr>
map <leader>ba :bufdo bd<cr>

map <silent><leader>l :bnext<cr>
map <silent><leader>h :bprevious<cr>

map <leader>tn :tabnew<cr>
map <leader>tp :tabp<cr>
map <leader>to :tab sp<cr>
map <leader>tc :call helpers#bufcloseCloseIt() <bar> tabclose<cr>

map <leader>e :edit <c-r>=expand("%:p:h")<cr>/
map <leader>cd :cd %:p:h <bar> pwd<cr>

try
  set switchbuf=useopen,usetab
  set stal=2
catch
endtry


autocmd custom_commands BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map 0 ^
map Y y$


autocmd custom_commands BufWritePre *.txt,*.js,*.jsx,*.ts,*.tsx,*.py,*.wiki,*.sh,*.coffee,*.c,*.cpp,*.java call helpers#cleanWhitespace()
autocmd custom_commands BufRead,BufNewFile,VimEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.coffee,*.c,*.cpp,*.java if !exists("b:cscope") | call helpers#toggleTags() | endif

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

