local augroup = vim.api.nvim_create_augroup
local grp = augroup("grp", {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  	group = grp,
  	pattern = "*",
  	command = [[%s/\s\+$//e]],
})
