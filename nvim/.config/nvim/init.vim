"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Credits to Amir Salihefendic — @amix3k
"
"
"              _ _               __   _____  ____ _             _
"             (_) |             /  | |____ |/ ___( )           (_)
"   __ _ _ __  _| |__  _ __ ___ `| |     / / /___|/ ___  __   ___ _ __ ___  _ __ ___
"  / _` | '_ \| | '_ \| '_ ` _ \ | |     \ \ ___ \ / __| \ \ / / | '_ ` _ \| '__/ __|
" | (_| | | | | | | | | | | | | || |_.___/ / \_/ | \__ \  \ V /| | | | | | | | | (__
"  \__,_|_| |_|_|_| |_|_| |_| |_\___/\____/\_____/ |___/   \_/ |_|_| |_| |_|_|  \___|
"
"
" Sections:
"    -> Plugin mappings
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Goyo
nmap <leader>g :Goyo<cr>

" FZF
nmap <leader>ff :FzfFiles<cr>
nmap <leader>bb :FzfBuffers<cr>
nmap <leader>rg :FzfRg<space>

" coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references) 

command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

so ~/.config/nvim/plugged/plugins.vim

set splitbelow splitright   

set confirm

set hidden

set mouse=a

imap fd <Esc>

map <leader>r :set wrap!<cr>

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

set noshowmode

set clipboard=unnamedplus

set completeopt=menuone,preview

set signcolumn=yes

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
nmap <leader>W :SudoWrite<cr>

map [<Space> O<Esc>j
map ]<Space> o<Esc>k

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

augroup custom_commands
  autocmd!
  " Auto-resize splits when Vim gets resized.
  autocmd VimResized * wincmd =
  " Prevent automatic commentingof next line in insert mode
  au FileType * set fo-=c fo-=r fo-=o
  " Update a buffer's contents on focus if it changed outside of Vim.
  au FocusGained,BufEnter * :checktime
  autocmd FileType qf,help,plugins nnoremap q :q<cr>
  au BufWritePost init.vim,plugins.vim nested source %
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu
set wildmode=full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

"Show line numbers
set rnu nu

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme onedark
catch
endtry

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set wrap! "Unwrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <C-space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><leader> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tp :tabp<cr>
map <leader>to :tab sp<cr>
map <leader>tc :Bclose<cr> :tabclose<cr>
map <leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>e :edit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
augroup edit_save
  autocmd!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^
map Y y$

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap J mz:m+<cr>`z
nmap K mz:m-2<cr>`z
vmap J :m'>+<cr>`<my`>mzgv`yo`z
vmap K :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

augroup clean_spaces
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.c,*.cpp,*.java :call CleanExtraSpaces()
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't close window, when deleting a buffer
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
