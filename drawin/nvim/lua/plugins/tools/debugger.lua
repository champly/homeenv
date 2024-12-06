return {
	{
		"mfussenegger/nvim-dap",
		event = "BufReadPre",
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

			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				}
			}
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				}
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug (Default)",
					request = "launch",
					program = "${file}"
				},
				{
					type = "delve",
					name = "Debug test (Default)", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}"
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod Default)",
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

			-- auto reload .vscode/launch.json
			local type_to_filetypes = { codelldb = { "rust" }, delve = { "go" } }
			require("dap.ext.vscode").load_launchjs(nil, type_to_filetypes)

			local pattern = "*/.vscode/launch.json"
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = pattern,
				callback = function(args)
					require("dap.ext.vscode").load_launchjs(args.file, type_to_filetypes)
				end
			})
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
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	}
}
