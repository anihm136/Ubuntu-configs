call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'tyru/caw.vim'
Plug 'anihm136/context_filetype.vim'
Plug 'anihm136/vim-unimpaired'
Plug 'chaoren/vim-wordmotion'
Plug 'fedorenchik/gtags.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim'
Plug 'roryokane/detectindent'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'htmljinja', 'htmldjango']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
Plug 'tweekmonster/django-plus.vim', {'for': ['python','html','htmldjango']}
" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
" UX
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vim-clap'
Plug 'psliwka/vim-smoothie'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/is.vim'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-swap'
" Themes
Plug 'liuchengxu/space-vim-theme'
Plug 'anihm136/vim-monokai-pro'
Plug 'KeitaNakamura/neodark.vim'
Plug 'carakan/new-railscasts-theme'
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'ajh17/Spacegray.vim'
call plug#end()

runtime macros/matchit.vim
runtime macros/sandwich/keymap/surround.vim

" Airline
let g:airline_powerline_fonts = 1

" Textobj-entire
let g:textobj_entire_no_default_key_mappings = 1
xmap ag <Plug>(textobj-entire-a)
omap ag <Plug>(textobj-entire-a)
xmap ig <Plug>(textobj-entire-i)
omap ig <Plug>(textobj-entire-i)

