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
Plug 'SirVer/ultisnips'
Plug 'sbdchd/neoformat'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'roryokane/detectindent'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'justinmk/vim-dirvish'
Plug 'kkoomen/vim-doge'
" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
" Syntax
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-git'
Plug 'McSinyx/vim-octave', {'for': 'octave'}
Plug 'baskerville/vim-sxhkdrc'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'ericpruitt/tmux.vim', {'rtp': 'vim/'}
Plug 'pboettch/vim-cmake-syntax'
Plug 'kevinoid/vim-jsonc', {'for': 'jsonc'}
" Language-specific
Plug 'captbaritone/better-indent-support-for-php-with-html', {'for': 'php'}
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'php', 'htmljinja', 'htmldjango']}
Plug 'mitsuhiko/vim-jinja', {'for': ['html','htmldjango']}
Plug 'tweekmonster/django-plus.vim', {'for': ['python','html','htmldjango']}
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-completion'
" Textobjects
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
" UI
Plug 'bluz71/vim-moonfly-statusline'
Plug 'anihm136/moonfly-statusline-themes'
Plug 'ap/vim-buftabline'
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-startify'
Plug 'TaDaa/vimade'
" UX
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'
Plug 'justinmk/vim-sneak'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/is.vim'
Plug 'machakann/vim-sandwich'
" Themes
Plug 'sainnhe/sonokai'
Plug 'chuling/equinusocio-material.vim'
Plug 'jacoborus/tender.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'habamax/vim-gruvbit'
Plug 'lifepillar/vim-solarized8'
Plug 'ajh17/Spacegray.vim'
" Experimental
Plug 'metakirby5/codi.vim', {'on': 'Codi'}
Plug 'anihm136/importmagic.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'mfussenegger/nvim-dap'
Plug 'thinca/vim-quickrun'
Plug 'jpalardy/vim-slime'
" Nvim
Plug 'anihm136/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'anihm136/telescope.nvim'
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
smap <silent> <TAB>   <Esc><cmd>call UltiSnips#JumpForwards()<CR>
smap <silent> <S-TAB> <Esc><cmd>call UltiSnips#JumpBackwards()<CR>

" Diagnostic nvim
call sign_define("LspDiagnosticsSignError", {"text" : "◉", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "⚠", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "💡", "texthl" : "LspDiagnosticHint"})
" Slime
let g:slime_no_mappings = 1
