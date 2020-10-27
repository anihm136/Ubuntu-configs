let g:polyglot_disabled = ['mathematica']

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
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'haorenW1025/diagnostic-nvim'
Plug 'dense-analysis/ale'
Plug 'SirVer/ultisnips'
Plug 'sbdchd/neoformat'
" Plug 'nvim-treesitter/nvim-treesitter'
Plug 'roryokane/detectindent'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-dirvish'
Plug 'kkoomen/vim-doge'
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
" " UI
Plug 'bluz71/vim-moonfly-statusline'
Plug 'anihm136/moonfly-statusline-themes'
Plug 'ap/vim-buftabline'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'tjdevries/cyclist.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
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
Plug 'sainnhe/sonokai'
Plug 'chuling/equinusocio-material.vim'
Plug 'jacoborus/tender.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'habamax/vim-gruvbit'
Plug 'lifepillar/vim-solarized8'
Plug 'ajh17/Spacegray.vim'
" Nvim
Plug 'anihm136/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
call plug#end()

runtime macros/matchit.vim
runtime macros/sandwich/keymap/surround.vim

" Buftabline
hi! link BufTabLineFill Normal
hi! link BufTabLineActive Pmenu
hi! link BufTabLineCurrent PmenuSel
hi! link BufTabLineHidden Pmenu
let g:buftabline_indicators = 1

" Moonfly
let g:moonflyWithALEIndicator = 1
let g:moonflyWithGitBranchCharacter = 1
let g:moonflyIgnoreDefaultColors = 1

" Unimpaired
let g:unimpaired_mapping = {
			\	"toggles" : 0,
			\	"excludes" : {
			\		'nextprevs' : ['f', 'a', 'q', 'l'],
			\		'keys' : ['>p', '<p', '>P', '<P', '=P', '[P', ']P']
			\	}
			\ }

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
let g:ale_hover_cursor = 0
