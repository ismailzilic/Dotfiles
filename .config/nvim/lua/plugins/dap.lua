vim.pack.add({
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/mfussenegger/nvim-dap" }
})

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

-- LLDB ADAPTER
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap",
	name = "lldb"
}

-- DAP Config for C, C++
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	}
}

dap.configurations.c = dap.configurations.cpp

-- DAP UI
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Keybinds
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dn", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dm", dap.step_back, { desc = "Step back" })
vim.keymap.set("n", "<leader>drr", dap.restart, { desc = "Restart debugging" })

vim.keymap.set("n", "<leader>?", function()
	dapui.eval(nil, { enter = true })
end, { desc = "Eval var under cursor" })
