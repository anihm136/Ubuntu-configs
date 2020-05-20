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
	autocmd User ClapOnEnter map <silent><buffer> <Esc><Esc> :call clap.input.clear() <bar> call clap#floating_win#close()<cr>
augroup END
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep'
let g:clap_provider_dotfiles = {
			\ 'source': ['~/.dotfiles/tag-nvim/config/nvim/plugins.vim', '~/.dotfiles/tag-nvim/config/nvim/init.vim', '~/.dotfiles/tag-nvim/config/nvim/genconfig.vim', '~/.dotfiles/tag-nvim/config/nvim/firevimconfig.vim', '~/.dotfiles/tag-vifm/config/vifm/vifmrc', '~/.zshrc', '~/.profile', '~/.sh_funcs'],
			\ 'sink': 'e',
			\ }

nnoremap <silent> <leader>ff :Clap files<cr>
nnoremap <silent> <leader>bb :Clap buffers<cr>
nnoremap <silent> <leader>rg :Clap grep<cr>
nnoremap <silent> <leader>bl :Clap blines<cr>
nnoremap <silent> <leader>fd :Clap dotfiles<cr>
