return {
  	{
    		"mason-org/mason.nvim",
    		opts = {},
  	},
  	{
    		"mason-org/mason-lspconfig.nvim",
    		dependencies = "mason-org/mason.nvim",
    		opts = {
      			ensure_installed = {
        			"clangd",
        			"marksman",
        			"pylsp",
        			"lua_ls",
        			"cssls",
        			"html",
        			"asm_lsp",
      			},
    		},
  	},
  	{
    		"neovim/nvim-lspconfig",
    		dependencies = {
      			"mason-org/mason.nvim",
      			"mason-org/mason-lspconfig.nvim",
    		},
    		config = function()
      			vim.api.nvim_create_autocmd("LspAttach", {
        			callback = function(args)
          				local client = vim.lsp.get_client_by_id(args.data.client_id)
          				if not client then return end
          				local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
          				vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_actions() end, opts)
          				vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          				vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        			end,
      			})
    		end,
  	},
}
