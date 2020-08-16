local lsp = require('nvim_lsp')
-- local treesitter = require'nvim-treesitter.configs'

if vim.env.SNIPPETS then
	vim.snippet = require 'snippet'
end

-- treesitter.setup {
-- 	highlight = {
-- 		enable = true,
-- 	},
-- 	incremental_selection = {
-- 		enable = false,
-- 		-- keymaps = {
-- 		-- 	node_incremental = "grn",
-- 		-- 	scope_incremental = "grc"
-- 		-- }
-- 	},
-- 	ensure_installed = 'all'
-- }

vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = {'pyls_ms', 'clangd', 'intelephense', 'tsserver', 'cssls', 'jsonls', 'html', 'bashls'}
for _, lsp_srv in ipairs(servers) do
	lsp[lsp_srv].setup {
		on_attach = on_attach,
	}
end

lsp.bashls.setup{
	filetypes = {"sh", "bash", "zsh"}
}


lsp.pyls_ms.setup{
	cmd = { "dotnet", "exec", "/home/anirudh/Applications/python-language-server/output/bin/Release/Microsoft.Python.LanguageServer.dll" };
	on_attach = on_attach;
	root_dir = function(fname)
		local filename = lsp.util.path.is_absolute(fname) and fname
		or lsp.util.path.join(vim.loop.cwd(), fname)
		local root_pattern = lsp.util.root_pattern('setup.py', 'setup.cfg', 'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc', '.git', '.gitignore')
		return root_pattern(filename) or lsp.util.path.dirname(filename)
	end;
}

lsp.clangd.setup{
	on_attach = on_attach;
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true
				}
			}
		}
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true
	}
}

lsp.intelephense.setup{
	on_attach = on_attach;
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true
				}
			}
		}
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true
	}
}
