return {
	-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			-- "L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
			-- "hrsh7th/cmp-nvim-lua",
		},
		config = function()
			-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
			vim.opt.completeopt = "menuone,noselect"

			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						-- before = function(entry, vim_item)
						--     vim_item.menu = ({
						--         nvim_lsp = "[LSP]",
						--         nvim_lua = "[Lua]",
						--         buffer = "[BUF]",
						--     })[entry.source.name]
						--     return vim_item
						-- end
					})
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
								"")
						else
							fallback()
						end
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					-- { name = "nvim_lua" },
				},
				-- https://github.com/hrsh7th/nvim-cmp/issues/381#issuecomment-947895080
				-- https://github.com/hrsh7th/nvim-cmp/issues/183
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertCharPre",
		-- version = "<CurrentMajor>.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local ls = require("luasnip")
			ls.config.set_config({
				delete_check_events = "TextChanged",
			})
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./external/snippets/" },
			})
		end
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertCharPre",
		dependencies = "nvim-lspconfig",
		init = function()
			if vim.g.color_theme == vim.g.color_theme_light then
				vim.cmd([[ hi LspSignatureActiveParameter guibg=grey ]])
			end
		end
	}
}
