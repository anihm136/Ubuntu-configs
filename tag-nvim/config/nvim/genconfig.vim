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

let g:mapleader = "\<Space>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Goyo
nmap <silent> <leader>g :Goyo<cr>

" Dirvish

" DB
nnoremap <buffer> <leader>sd :DB b:db =<Space>
vnoremap <buffer><silent> <leader>se :DB<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = "/usr/bin/python3"
" let g:perl_host_prog = '/usr/bin/perl'

set splitbelow splitright
set confirm
set smarttab
set shiftround
set termguicolors
set mouse=a
set cscopeprg=cscope
set history=500
filetype plugin indent on
set autoread
set noshowcmd
set noshowmode
set undofile
set nrformats-=octal
set clipboard=unnamedplus
set signcolumn=yes
set updatetime=200
set inccommand=nosplit
set scrolloff=10
set shortmess=actI
set fillchars+=vert:│
set cursorline

nnoremap <silent> <leader>fs :wa!<cr>
" nnoremap <silent> <leader>Fs exe 'silent! write !sudo tee % >/dev/null | edit!'
vnoremap <silent> y ygv<Esc>
inoremap <silent> fd <Esc>
inoremap <silent> <C-v> <C-r>+
nnoremap <silent> <leader>r :set wrap!<cr>

augroup custom_commands
	autocmd!
augroup END

autocmd custom_commands VimResized * wincmd =
autocmd custom_commands FocusGained,BufEnter * checktime
autocmd custom_commands FileType * set fo=lcqnrj
autocmd custom_commands FileType help,plugins,fugitive nnoremap <silent><buffer> q :q<cr>
autocmd custom_commands FileType qf call helpers#mapQf()
autocmd custom_commands BufWritePost init.vim,plugins.vim,genconfig.vim nested silent source %
autocmd custom_commands BufReadPost,BufNewFile * :DetectIndent
autocmd custom_commands TextYankPost *  silent! lua require'vim.highlight'.on_yank()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu
set wildmode=full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__,node_modules
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set ruler
set relativenumber number
set cmdheight=2
set pumheight=10
set pumwidth=50
set pumblend=20
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
set nostartofline
set noerrorbells
set novisualbell
set tm=500
set diffopt&
				\ diffopt+=vertical
				\ diffopt+=hiddenoff

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable

command! -nargs=? -complete=customlist,CompleteColors SetColorscheme call helpers#setColorscheme(<f-args>)
nnoremap <silent><F12> :SetColorscheme dark<cr>
nnoremap <silent><F24> :SetColorscheme light<cr>
silent exec "SetColorscheme"

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <leader><leader> :noh<cr>

map j gj
map k gk
map <Down> gj
map <Up> gk
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>

noremap <silent><leader>bd :call helpers#bufcloseCloseIt()<cr>
noremap <leader>ba :bufdo bd<cr>

noremap <leader>e :edit <c-r>=fnameescape(expand("%:p:h"))<cr>/
noremap <leader>cd :cd %:p:h <bar> pwd<cr>

try
	set switchbuf=useopen,usetab
	set stal=2
catch
endtry

autocmd custom_commands BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map Y y$
nnoremap x "_x
xnoremap <expr> p printf('pgv"%sygv<esc>', v:register)
vnoremap o $

autocmd custom_commands BufRead,BufNewFile,VimEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.c,*.cpp,*.go let g:nav_mode = 1
autocmd custom_commands BufRead,BufNewFile,VimEnter *.java,*.lua let g:nav_mode = 1
autocmd custom_commands BufRead,BufNewFile,VimEnter *.js,*.jsx,*.ts,*.tsx,*.py,*.c,*.cpp,*.java,*.go,*.lua silent call ProgFunc()

xnoremap <Leader>rn :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

nnoremap <F2>
			\ :let @s='\<'.expand('<cword>').'\>'<CR>
			\ :Grepper -cword -noprompt<CR>
			\ :cfdo %s/<C-r>s//g \| update
			\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

xmap <F2>
			\ "sy
			\ gvgr
			\ :cfdo %s/<C-r>s//g \| update
			\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <leader>ss :setlocal spell!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <leader>q :e ~/buffer<cr>
noremap <leader>x :e ~/buffer.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CompleteColors(ArgLead, CommandLine, CursorColumn) abort
	let l:comp = extend(getcompletion('', 'color'), ['dark', 'light'])
	let l:pat = '^'.a:ArgLead
	call filter(l:comp, {idx,val -> val =~ l:pat})
	return l:comp
endfunction

function! ProgFunc() abort
	silent exec "RainbowParentheses"
	if !get(g:, "nav_mode")
		let g:nav_mode = helpers#toggleTags()
	else
		call helpers#navMap(g:nav_mode)
	endif
endfunction
