nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
let g:ale_linters_explicit = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

call ale#linter#Define('python', {
\   'name': 'mspyls',
\   'lsp': 'stdio',
\   'executable': "dotnet",
\   'command': "dotnet exec /home/anirudh/Applications/python-language-server/output/bin/Release/Microsoft.Python.LanguageServer.dll",
\   'project_root': function('ale#python#FindProjectRoot'),
\})

call ale#linter#Define('css', {
\   'name': 'cssls',
\   'lsp': 'stdio',
\   'executable': "css-languageserver",
\   'command': "css-languageserver --stdio",
\   'project_root': fnameescape(expand('%:p:h')),
\})

call ale#linter#Define('json', {
\   'name': 'jsonls',
\   'lsp': 'stdio',
\   'executable': "vscode-json-languageserver",
\   'command': "vscode-json-languageserver --stdio",
\   'project_root': fnameescape(expand('%:p:h')),
\})

let g:ale_linters = {
			\ "c": ['clangd', 'clang'],
			\ "cpp": ['clangd', 'clang'],
			\ "css": ['cssls'],
			\ "javascript" : ['eslint', 'tsserver'],
			\ "typescript" : ['eslint', 'tsserver'],
			\ "typescriptreact" : ['eslint', 'tsserver'],
			\ "json" : ['jsonls'],
			\ "python" : ["pylint", "flake8", "mspyls"],
			\ "php" : ["php"],
			\ "sh" : ["shell", "language_server"],
			\ "zsh" : ["shell", "language_server"],
			\ "vim" : ["ale_custom_linting_rules"]
			\}
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'javascript': ['eslint'],
			\}
nnoremap <silent><F4> :ALEFix<cr>