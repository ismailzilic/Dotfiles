vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.showtabline = 8
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true
vim.opt.cursorcolumn = false
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.winborder = "rounded"

-- Plugins
vim.pack.add({ { src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/saghen/blink.cmp",                version = vim.version.range("^1") },
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
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = true,
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	completion = {
		keyword = { range = 'full' },
		documentation = { auto_show = true, auto_show_delay_ms = 400 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" }
			}
		}
	},
})

-- Nvim treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
	pattern = { '<filetype>' },
	callback = function() vim.treesitter.start() end,
})

-- Theming
vim.cmd(":hi statusline guibg=NONE")
vim.cmd(":colorscheme kanagawa")

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

-- Auto closing characters
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
