vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })

require("nvim-tree").setup({
	git = { enable = false },
	sync_root_with_cwd = true,
	respect_buf_cwd = false,
	update_focused_file = {
		enable = true,
		update_root = false,
	}
})

-- Keymaps
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
vim.keymap.set("n", "<C-j>", "<cmd>NvimTreeToggle<CR>", { desc = "Focus file explorer" })
