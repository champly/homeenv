return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*",
		opts = {
			enabled = function()
				return not vim.list_contains({ "NvimTree" }, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			keymap = {
				preset = "enter",
				["<C-e>"] = { "hide", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			},
			cmdline = {
				enabled = false,
			},
			completion = {
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon" }, { "kind" } },
					},
					border = "rounded",
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 50,
					window = {
						border = "rounded"
					},
				},
			},
			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
				providers = {
					snippets = {
						-- https://cmp.saghen.dev/recipes#hide-snippets-after-trigger-character
						should_show_items = function(ctx)
							return ctx.trigger.initial_kind ~= "trigger_character"
						end,
						opts = {
							search_paths = { vim.fn.stdpath("config") .. "/external/snippets/" },
						}
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded"
				},
			},
		},
		init = function()
			if vim.g.color_theme == vim.g.color_theme_light then
				vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = "black", bold = true })
				vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = "gray" })
			end
		end
	},
}
