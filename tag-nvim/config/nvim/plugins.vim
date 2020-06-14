call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'tyru/caw.vim'
Plug 'anihm136/context_filetype.vim'
Plug 'anihm136/vim-unimpaired'
Plug 'fedorenchik/gtags.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-grepper', {'on': 'Grepper'}
Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/completion-nvim'
Plug 'haorenW1025/diagnostic-nvim'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/vim-vsnip'
Plug 'sbdchd/neoformat'
" Plug 'nvim-treesitter/nvim-treesitter'
Plug 'roryokane/detectindent'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive', {'on': ['Git','G','GPush']}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-dirvish'
" Language-specific
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'htmljinja', 'htmldjango']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
Plug 'tweekmonster/django-plus.vim', {'for': ['python','html','htmldjango']}
Plug 'wmvanvliet/jupyter-vim', {'for': 'python'}
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
" Textobjects
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ryanoasis/vim-devicons'
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

" Jupyter
let g:jupyter_mapkeys = 0
nmap <buffer><silent> gR <Plug>JupyterRunTextObj
vmap <buffer><silent> gR <Plug>JupyterRunVisual			

" Ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="google"
let g:UltiSnipsExpandTrigger="<nop>"
let g:UltiSnipsJumpForwardTrigger="<nop>"
let g:UltiSnipsJumpBackwardTrigger="<nop>"

let g:ulti_expand_or_jump_res = 0
function! UltiSnipFunc()
	call UltiSnips#ExpandSnippetOrJump()
	return g:ulti_expand_or_jump_res
endfunction

" ALE
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = ''
let g:ale_virtualtext_cursor = 1





