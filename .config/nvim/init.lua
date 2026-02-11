vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.showtabline = 8
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"

vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.cursorcolumn = false
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.winborder = "rounded"

vim.cmd(":hi statusline guibg=NONE")
vim.cmd(":colorscheme unokai")

-- Plugins
vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
})

require("mason").setup()
require("mini.pick").setup()
require("oil").setup()
require("nvim-treesitter").setup({
	ensure_installed = { "asm", "c", "cpp", "make", "cmake", "lua", "typescript", "javascript" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	indent = { enable = true },
})

-- Nvim treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
	pattern = { '<filetype>' },
	callback = function() vim.treesitter.start() end,
})

-- Keymaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')

-- Auto close characters
vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '{', '{}<Left>')
vim.keymap.set('i', '"', '""<Left>')
vim.keymap.set('i', "'", "''<Left>")

-- LSP
vim.lsp.enable({ "emmylua_ls", "clangd" })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.lsp.config("emmylua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}

})

-- LSP autocompletion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")
