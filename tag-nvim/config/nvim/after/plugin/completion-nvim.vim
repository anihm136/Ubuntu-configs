autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr><silent> <Tab> pumvisible() 
			\ ? "\<C-n>" 
			\ : vsnip#available(1)
			\ ? "<Plug>(vsnip-expand-or-jump)" 
			\ : "\<C-r>=(UltiSnipFunc()>0)?\"\":\"\<Tab>\"<cr>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0
inoremap <silent><expr> <c-space> completion#trigger_completion()
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_auto_change_source = 1
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() 
			\ ? complete_info()["selected"] != "-1" 
			\ ? "\<Plug>(completion_confirm_completion)"  
			\ : "\<c-e>\<CR>" 
			\ : "\<CR>"


let g:completion_chain_complete_list = {
			\ 'vim': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'octave': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'lua': [
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\],
			\ 'sql': [
			\    {'complete_items': ['vim-dadbod-completion']},
			\    {'mode': '<c-n>'}
			\],
			\ 'default': [
			\    {'complete_items': ['lsp']},
			\    {'mode': '<c-n>'},
			\    {'mode': 'file'}
			\]
			\}

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <F7> <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
