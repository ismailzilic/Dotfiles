vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/BurntSushi/ripgrep" },
	{ src = "https://github.com/sharkdp/fd" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" } })

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		path_display = { "smart" },
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			}
		},
		file_ignore_patterns = {
			"node_modules",
			"vendor",
			"build",
			"%.git",
		}
	}
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep in cwd" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Telescope grep string in cwd" })

vim.keymap.set("n", "<leader>ci", builtin.lsp_incoming_calls)
vim.keymap.set("n", "<leader>co", builtin.lsp_outgoing_calls)
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations)
vim.keymap.set("n", "<leader>go", builtin.lsp_references)
