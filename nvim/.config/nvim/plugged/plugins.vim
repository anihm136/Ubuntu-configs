call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'anihm136/caw.vim'
Plug 'anihm136/context_filetype.vim'
Plug 'anihm136/vim-unimpaired'
Plug 'chaoren/vim-wordmotion'
Plug 'fedorenchik/gtags.vim'
Plug 'haya14busa/is.vim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-operator-user'
Plug 'liuchengxu/vim-clap'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'ts', 'jsx', 'tsx', 'php', 'htmljinja', 'htmldjango']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
Plug 'tweekmonster/django-plus.vim', {'for': ['python','html','htmldjango']}
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
imap <C-z> <Plug>(coc-snippets-expand-jump)

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
let g:clap_disable_run_rooter = v:true

function! MyClapOnEnter() abort
  augroup ClapEnsureAllClosed
    autocmd!
    autocmd BufEnter,WinEnter,WinLeave * ++once call clap#floating_win#close()
  augroup END
endfunction

augroup clapCommands
  autocmd!
  autocmd User ClapOnEnter call MyClapOnEnter()
  autocmd User ClapOnEnter map <silent><buffer> q :call clap.input.clear() <bar> call clap#floating_win#close()<cr>
augroup END
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep'
let g:clap_provider_dotfiles = {
      \ 'source': ['~/.dotfiles/nvim/.config/nvim/plugged/plugins.vim', '~/.dotfiles/nvim/.config/nvim/init.vim', '~/.dotfiles/nvim/.config/nvim/genconfig.vim','~/.dotfiles/nvim/.config/nvim/ipyrc.vim','~/.dotfiles/nvim/.config/nvim/firevimconfig.vim',  '~/.dotfiles/vifm/.config/vifm/vifmrc', '~/.zshrc', '~/.profile', '~/.sh_funcs'],
      \ 'sink': 'e',
      \ }

" Caw
let g:caw_operator_keymappings = 0
let g:caw_no_default_keymappings = 1
map <silent><unique> gc <Plug>(caw:hatpos:toggle:operator)
nmap <silent><unique> gcc <Plug>(caw:hatpos:toggle)

" Gtags
let g:Gtags_No_Auto_Jump = 1

" Rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1
let g:rooter_targets = '*'
let g:rooter_use_lcd = 1
