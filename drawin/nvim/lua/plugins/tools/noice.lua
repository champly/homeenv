return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
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
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			-- -- https://github.com/folke/noice.nvim/issues/779#issuecomment-2081998250
			-- views = {
			--     cmdline_popup = {
			--         position = {
			--             row = "40%", -- 40% from top of the screen. This will position it almost at the center.
			--             col = "50%",
			--         }
			--     },
			-- }
		},
	},
	-- {
	--     "rcarriga/nvim-notify",
	--     config = function()
	--         ---@diagnostic disable-next-line: param-type-mismatch
	--         vim.notify = vim.schedule_wrap(require("notify"))

	--         ---@diagnostic disable-next-line: duplicate-set-field
	--         function _G.save_file_with_notify()
	--             ---@diagnostic disable-next-line: param-type-mismatch
	--             local ok, msg = pcall(vim.cmd, "silent write!")
	--             if ok then
	--                 vim.notify("Saved " .. vim.fn.expand "%:t", nil, {
	--                     title = "Success",
	--                     timeout = 1000
	--                 })
	--             else
	--                 ---@diagnostic disable-next-line: param-type-mismatch
	--                 vim.notify(msg, "error", {
	--                     title = "Error",
	--                     timeout = 1000
	--                 })
	--             end
	--         end

	--         vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua save_file_with_notify()<cr>",
	--             { noremap = true, silent = true })
	--     end,
	-- }
}
