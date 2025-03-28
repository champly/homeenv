-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
-- TODO: use https://github.com/NvChad/NvChad/blob/v2.0/lua/plugins/configs/lspconfig.lua rewrite
local enhance_attach = function(client, bufnr)
	-- highlight
	if client.server_capabilities.documentHighlightProvider then
		if vim.g.color_theme == vim.g.color_theme_dark then
			vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#ff8600", fg = "black" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3e3e3e" })
		else
			vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#ffcc33", fg = "black" })
			vim.api.nvim_set_hl(0, "Pmenu", { bg = "None" })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "black", bold = true })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#d9d9d9" })
			-- vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { fg = "gray" })
		end
	end

	-- lsp document highlight
	vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight })
	vim.api.nvim_create_autocmd("CursorHoldI", { callback = vim.lsp.buf.document_highlight })
	vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references })

	-- keymap
	local opts = { buffer = bufnr, silent = true, noremap = true }
	-- TODO: https://github.com/nvim-telescope/telescope.nvim/issues/1265
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	-- vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float)
	vim.keymap.set({ "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	-- https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers
	-- vim.keymap.set("n", "<c-]>", ":Telescope lsp_definitions theme=get_cursor<CR>", opts)
	-- vim.keymap.set("n", "<leader>td", ":Telescope lsp_type_definitions<CR>", opts)
	-- vim.keymap.set("n", "<leader>im", ":Telescope lsp_implementations theme=ivy<CR>", opts)
	-- vim.keymap.set("n", "<leader>rf", ":Telescope lsp_references theme=ivy<CR>", opts)
	-- -- vim.keymap.set("n", "<leader>ds", ":Telescope diagnostics theme=ivy<CR>", opts)
	-- vim.keymap.set("n", "<leader>bl", ":Telescope lsp_document_symbols<CR>", opts)

	local preset_default = { jump = { reuse_win = false } }
	local preset_ivy = { layout = { preset = "ivy" }, jump = { reuse_win = false } }
	vim.keymap.set("n", "<c-]>", function() Snacks.picker.lsp_definitions(preset_default) end, opts)
	vim.keymap.set("n", "<leader>td", function() Snacks.picker.lsp_type_definitions(preset_default) end, opts)
	vim.keymap.set("n", "<leader>im", function() Snacks.picker.lsp_implementations(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>rf", function() Snacks.picker.lsp_references(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>dw", function() Snacks.picker.diagnostics(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>db", function() Snacks.picker.diagnostics_buffer(preset_ivy) end, opts)
	vim.keymap.set("n", "<leader>bl", function() Snacks.picker.lsp_symbols(preset_default) end, opts)

	-- virtual_lines
	vim.api.nvim_set_keymap("n", "<leader>do", "", {
		callback = function()
			vim.diagnostic.config({ virtual_lines = { current_line = true } })
		end,
	})
	vim.api.nvim_create_autocmd("CursorMoved", {
		callback = function()
			vim.diagnostic.config({ virtual_lines = false })
		end,
	})

	-- -- disabled inlay hint
	-- vim.lsp.inlay_hint.enable(true)

	-- Setup CodeLens handling
	require("config.codelens").setup(client, bufnr, opts)
end

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		---@diagnostic disable-next-line: need-check-nil
-- 		if client:supports_method("textDocument/completion") then
-- 			---@diagnostic disable-next-line: need-check-nil
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

vim.diagnostic.config({
	underline = {
		severity = vim.diagnostic.severity.ERROR,
	},
	virtual_lines = false,
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
		-- severity = {
		--     min = vim.diagnostic.severity.WARN
		-- },
		-- Enable virtual text, override spacing to 4
		spacing = 4,
		prefix = " ", --         ■ ● ▎x
	},
	signs = {
		priority = 20,
		numhl = { "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint" },
		-- icon         
		text = { "✘ ", "▲ ", "» ", "⚑ " }
	},
	float = {
		border = "rounded", -- none,single,double
	}
})

vim.lsp.config("*", {
	on_attach = enhance_attach,
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			}
		}
	}
})

-- vim.o.winborder               = "rounded"
vim.lsp.enable({ "gopls", "lua_ls", "rust_analyzer", "clangd" })
