local config = {}

function config.nvim_coc()
	require("modules.completion.coc")
end

function config.nvim_lsp()
	require("modules.completion.lspconfig")
end

function config.nvim_cmp()
	-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
	vim.opt.completeopt = "menuone,noselect"

	local cmp = require("cmp")
	cmp.setup({
		preselect = cmp.PreselectMode.None,
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		formatting = {
			format = function(entry, vim_item)
				local icons = require "modules.completion.lspconfig_icon"
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					buffer = "[BUF]",
				})[entry.source.name]

				return vim_item
			end,
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
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
end

function config.lua_snip()
	local ls = require("luasnip")
	ls.config.set_config({
		delete_check_events = "TextChanged",
	})
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = { "./snippets/" },
	})
end

function config.lspsaga_nvim()
	require("lspsaga").setup({})

	-- LSP finder - Find the symbol's definition
	-- If there is no definition, it will instead be hidden
	-- When you use an action in finder like "open vsplit",
	-- you can use <C-t> to jump back
	vim.keymap.set("n", "rf", "<cmd>Lspsaga lsp_finder<CR>")

	-- Code action
	vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

	-- Rename all occurrences of the hovered word for the entire file
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

	-- Rename all occurrences of the hovered word for the selected files
	-- vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

	-- Peek definition
	-- You can edit the file containing the definition in the floating window
	-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
	-- It also supports tagstack
	-- Use <C-t> to jump back
	-- vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")

	-- Go to definition
	vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>")

	-- Peek type definition
	-- You can edit the file containing the type definition in the floating window
	-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
	-- It also supports tagstack
	-- Use <C-t> to jump back
	-- vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

	-- -- Go to type definition
	-- vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")


	-- -- Show line diagnostics
	-- -- You can pass argument ++unfocus to
	-- -- unfocus the show_line_diagnostics floating window
	-- vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

	-- -- Show cursor diagnostics
	-- -- Like show_line_diagnostics, it supports passing the ++unfocus argument
	-- vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

	-- Show buffer diagnostics
	vim.keymap.set("n", "<leader>ds", "<cmd>Lspsaga show_buf_diagnostics<CR>")

	-- -- Diagnostic jump
	-- -- You can use <C-o> to jump back to your previous location
	-- vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	-- vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

	-- -- Diagnostic jump with filters such as only jumping to an error
	-- vim.keymap.set("n", "[E", function()
	--     require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	-- end)
	-- vim.keymap.set("n", "]E", function()
	--     require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	-- end)

	-- Toggle outline
	vim.keymap.set("n", "<space>o", "<cmd>Lspsaga outline<CR>")

	-- Hover Doc
	-- If there is no hover doc,
	-- there will be a notification stating that
	-- there is no information available.
	-- To disable it just use ":Lspsaga hover_doc ++quiet"
	-- Pressing the key twice will enter the hover window
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

	-- If you want to keep the hover window in the top right hand corner,
	-- you can pass the ++keep argument
	-- Note that if you use hover with ++keep, pressing this key again will
	-- close the hover window. If you want to jump to the hover window
	-- you should use the wincmd command "<C-w>w"
	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

	-- -- Call hierarchy
	-- vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
	-- vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

	-- Floating terminal
	-- vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

	-- vim.cmd [[ highlight link LspSagaFinderSelection guifg='#ff0000' guibg='#00ff00' gui='bold' ]]
end

return config
