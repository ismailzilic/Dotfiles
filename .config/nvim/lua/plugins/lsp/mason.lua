vim.pack.add({ { src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" } })

local lsp_list = {
	"clangd",
	"marksman",
	"pylsp",
	"lua_ls",
	"cssls",
	"html",
	"asm_lsp",
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = lsp_list,
})
