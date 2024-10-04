return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			{
				"smjonas/inc-rename.nvim",
				config = function()
					require("inc_rename").setup()
					vim.keymap.set("n", "<leader>rn", function()
						return ":IncRename " .. vim.fn.expand("<cword>")
					end, { expr = true })
				end,
			}
		},
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
				signature = {
					-- https://github.com/folke/noice.nvim/issues/370
					enabled = false
				}
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			-- cmdline center
			-- views = {
			--     cmdline_popup = {
			--         position = {
			--             row = "30%",
			--             col = "50%",
			--         },
			--     },
			--     cmdline_popupmenu = {
			--         position = {
			--             row = "36%",
			--             col = "50%",
			--         },
			--     },
			-- },
		},
	},
}
