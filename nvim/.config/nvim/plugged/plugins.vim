call plug#begin('~/.config/nvim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdcommenter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neoclide/coc.nvim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'mattn/emmet-vim'
  Plug 'machakann/vim-sandwich'
  Plug 'psliwka/vim-smoothie'
  Plug 'sickill/vim-pasta'
  Plug 'honza/vim-snippets'
  Plug 'elzr/vim-json'
  Plug 'ryanoasis/vim-devicons'
  Plug 'joshdick/onedark.vim'
  Plug 'vhda/verilog_systemverilog.vim'
  Plug 'haya14busa/is.vim'
  Plug 'vim-scripts/auto-pairs-gentle'
  Plug 'mhinz/vim-grepper'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'anihm136/vim-unimpaired'
  Plug 'tpope/vim-repeat'
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
let g:NERDSpaceDelims            = 1
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1

" FZF customization
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'Fzf'

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
let g:coc_snippet_next = '  '

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
let g:AutoPairsUseInsertedCount = 1

" Grepper
let g:grepper       = {}
let g:grepper.tools = ["rg"]

" Gitgutter
let g:gitgutter_map_keys=0
map <Leader>gf :GitGutterFold<cr>

" Pasta
let g:pasta_paste_before_map = '[p'
let g:pasta_paste_after_map  = ']p'

" Easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Sandwich
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> saa <Plug>(operator-sandwich-add)<SID>line
nmap <silent> sdd <Plug>(operator-sandwich-delete)<SID>line
nmap <silent> srr <Plug>(operator-sandwich-replace)<SID>line
