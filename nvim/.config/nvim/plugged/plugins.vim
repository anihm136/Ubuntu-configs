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
Plug 'machakann/vim-swap'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'roryokane/detectindent'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
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

" Airline
let g:airline_powerline_fonts = 1
