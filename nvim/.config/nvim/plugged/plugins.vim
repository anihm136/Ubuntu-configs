call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
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
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'ts', 'jsx', 'tsx', 'php']}
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'mitsuhiko/vim-jinja', {'for': 'html'}
Plug 'tweekmonster/django-plus.vim', {'for': ['python', 'html']}
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'jupyter-vim/jupyter-vim', {'for': 'python'}
call plug#end()

runtime macros/matchit.vim

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

" JSON customization
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END

" Auto pairs gentle
augroup ft_pairs
  autocmd!
  au FileType htmljinja,htmldjango let b:AutoPairs = AutoPairs | call AutoPairsInit() | let b:AutoPairs = AutoPairsDefine({"{%":"%}", "{#":"#}", "<":">"}) | call AutoPairsInit()
  au FileType php let b:AutoPairs = AutoPairs | call AutoPairsInit() | let b:AutoPairs = AutoPairsDefine({"<?":"?>", "<?php":"?>", "<":">"}) | call AutoPairsInit() 
  au FileType html let b:AutoPairs = AutoPairs | call AutoPairsInit() | let b:AutoPairs = AutoPairsDefine({"<":">"}) | call AutoPairsInit() 

augroup END

" Grepper
let g:grepper       = {}
let g:grepper.tools = ["rg"]

" Gitgutter
let g:gitgutter_map_keys=0
map <silent> <Leader>gf :GitGutterFold<cr>

" Easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Sandwich
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> saa <Plug>(operator-sandwich-add)<SID>line
nmap <silent> sdd <Plug>(operator-sandwich-delete)<SID>line
nmap <silent> srr <Plug>(operator-sandwich-replace)<SID>line

" Jinja
let g:htmljinja_disable_html_upgrade = 1

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
