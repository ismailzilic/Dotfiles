vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })

local options = {
	options = {
		separator_style = "thin",
		always_show_bufferline = true,
		sort_by = "insert_after_current",
		show_buffer_close_icons = false,
		show_close_icon = false,
	}
}

require("bufferline").setup(options)

-- Keymaps
vim.keymap.set("n", "<leader>h", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left" })
vim.keymap.set("n", "<leader>l", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right" })
