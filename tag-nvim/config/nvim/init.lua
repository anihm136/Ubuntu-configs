local lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')
local util = require('nvim_lsp/util')
-- local treesitter = require'nvim-treesitter.configs'
require'colorizer'.setup()

if vim.env.SNIPPETS then
	vim.snippet = require 'snippet'
end

vim.lsp.set_log_level("debug")

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

local servers = {'clangd', 'intelephense', 'tsserver', 'cssls', 'jsonls', 'html', 'bashls', 'gopls'}
for _, lsp_srv in ipairs(servers) do
	lsp[lsp_srv].setup {
		on_attach = on_attach,
	}
end

lsp.bashls.setup{
	filetypes = {"sh", "bash", "zsh"}
}

configs['pyright'] = {
  default_config = {
    cmd = {"pyright-langserver", "--stdio"};
    filetypes = {"python"};
    root_dir = util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt");
    settings = {
      analysis = { autoSearchPaths= true; };
      pyright = { useLibraryCodeForTypes = true; };
    };
    -- The following before_init function can be removed once https://github.com/neovim/neovim/pull/12638 is merged
    before_init = function(initialize_params)
            initialize_params['workspaceFolders'] = {{
                name = 'workspace',
                uri = initialize_params['rootUri']
            }}
    end
   };
  docs = {
    description = [[
https://github.com/microsoft/pyright
`pyright`, a static type checker and language server for python
]];
  };
}

lsp.pyright.setup{
	on_attach = on_attach;
	root_dir = function(fname)
		local filename = util.path.is_absolute(fname) and fname
		or util.path.join(vim.loop.cwd(), fname)
		local root_pattern = util.root_pattern('setup.py', 'setup.cfg', 'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc', '.git', '.gitignore')
		return root_pattern(filename) or util.path.dirname(filename)
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
