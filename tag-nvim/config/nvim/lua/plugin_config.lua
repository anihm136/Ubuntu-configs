-- nvim-colorizer
require "colorizer".setup()

-- treesitter
require "nvim-treesitter.configs".setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true -- false will disable the whole extension
    },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = "@parameter.inner"
            },
            swap_previous = {
                ["g<"] = "@parameter.inner"
            }
        }
    },
    indent = {
        enable = true
    }
}

-- telescope
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    "<cmd>lua require('telescope_config').project_search()<CR>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope_config').git_files()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>lua require('telescope_config').edit_dotfiles()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rgl", "<cmd>lua require('telescope_config').live_grep()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rgw", "<cmd>lua require('telescope_config').grep_prompt()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>fb", "<cmd>lua require('telescope_config').buffers()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>bl", "<cmd>lua require('telescope_config').curbuf()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<space>fh", "<cmd>lua require('telescope_config').help_tags()<CR>", {noremap = true})
