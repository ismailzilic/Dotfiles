-- KODA.NVIM
vim.pack.add({{src = "https://github.com/oskarnurm/koda.nvim"}})

require("koda").setup({
	theme = {
		dark = "dark",
	},
	cache = true,
	colors = {
		bg = "#000000"
	}
})
