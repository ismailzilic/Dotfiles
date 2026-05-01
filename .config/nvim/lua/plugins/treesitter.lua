vim.pack.add({ {
	src = "https://github.com/nvim-treesitter/nvim-treesitter",
	version = "main",
	data = {
		run = function()
			vim.cmd(":TSUpdate")
		end
	}
} })

require("nvim-treesitter").setup({
	ensure_installed = { "vim", "vimdoc", "markdown", "asm", "c", "cpp", "make", "cmake", "lua", "typescript", "javascript", "bash" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
})
