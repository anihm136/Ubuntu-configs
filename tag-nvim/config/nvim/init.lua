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

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local servers = {'pyls_ms', 'clangd', 'intelephense', 'tsserver', 'cssls', 'jsonls', 'html'}
for _, lsp_srv in ipairs(servers) do
	lsp[lsp_srv].setup {
		on_attach = on_attach,
	}
end

lsp.pyls_ms.setup{
	cmd = { "dotnet", "exec", "/home/anirudh/Applications/python-language-server/output/bin/Release/Microsoft.Python.LanguageServer.dll" };
	on_attach = on_attach;
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
