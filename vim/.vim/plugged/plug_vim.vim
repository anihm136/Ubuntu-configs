call plug#begin('~/.vim/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/nerdcommenter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-eunuch'
    Plug 'psliwka/vim-smoothie'
    Plug 'haya14busa/is.vim'
    Plug 'sickill/vim-pasta'
    Plug 'elzr/vim-json'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vhda/verilog_systemverilog.vim'
    Plug 'vim-scripts/auto-pairs-gentle'
call plug#end()
runtime macros/matchit.vim

" Airline customization
" let g:airline_extensions#enabled = ['branch']
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

" NERDCommenter customization
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

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

" Auto Pairs Gentle
let g:AutoPairsUseInsertedCount = 1
