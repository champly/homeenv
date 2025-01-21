return {
	{
		"mfussenegger/nvim-dap",
		event = "BufReadPre",
		dependencies = { "rcarriga/nvim-dap-ui" },
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "Normal", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "Normal", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "👉", texthl = "Normal", linehl = "", numhl = "" })

			local opts = { silent = true }
			vim.keymap.set("n", "<F5>", function() require("dap").continue() end, opts)
			vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end, opts)
			vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, opts)
			vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, opts)
			vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, opts)
			vim.keymap.set("n", "<S-s>", function() require("dap").terminate() end, opts)

			local dap = require("dap")

			dap.adapters.delve = function(callback, config)
				if config.mode == "remote" and config.request == "attach" then
					callback({
						type = "server",
						host = config.host or "127.0.0.1",
						port = config.port or "38697"
					})
				else
					callback({
						type = "server",
						port = "${port}",
						executable = {
							command = "dlv",
							args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
							detached = vim.fn.has("win32") == 0,
						}
					})
				end
			end
			dap.adapters.codelldb = {
				type = "executable",
				command = "codelldb",
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}"
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}"
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}"
				}
			}

			dap.configurations.rust = {
				{
					name = "Launch file (Default)",
					type = "codelldb",
					request = "launch",
					program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "BufReadPre",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		},
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")
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
		end,
	}
}
