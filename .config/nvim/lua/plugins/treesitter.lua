vim.pack.add({ {
	src = "https://github.com/romus204/tree-sitter-manager.nvim",
} })

require("tree-sitter-manager").setup({
	ensure_installed = { "vim", "vimdoc", "markdown", "asm", "c", "cpp", "rust", "python", "make", "cmake", "lua", "typescript", "javascript", "bash" },
	auto_install = true,
	highlight = true,
	border = nil,
})
