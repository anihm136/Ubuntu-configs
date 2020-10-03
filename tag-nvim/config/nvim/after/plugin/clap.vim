if !get(g:, 'loaded_clap', v:false)
	finish
endif

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
			\ 'source': map(
			\							split(globpath(expand('$XDG_CONFIG_HOME').'/nvim', '*.vim'))
			\						+ split(globpath(expand('$XDG_CONFIG_HOME').'/nvim/after', '**/*.vim'))
			\						+ ['~/.sh_funcs', '~/.aliases', '~/.config/zsh/.zshrc', '~/.config/zsh/.zaliases', '~/.config/antibody/zsh_plugins.txt', '~/.config/antibody/zsh_plugins.sh']
			\					, {_,val -> simplify(val)}
			\						),
			\ 'sink': 'e',
			\ }

nnoremap <silent> <leader>ff :Clap files<cr>
nnoremap <silent> <leader>bb :Clap buffers<cr>
nnoremap <silent> <leader>rg :Clap grep<cr>
nnoremap <silent> <leader>bl :Clap blines<cr>
nnoremap <silent> <leader>fd :Clap dotfiles<cr>
