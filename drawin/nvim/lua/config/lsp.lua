---@diagnostic disable: undefined-global
-- https://github.com/nvim-lua/completion-nvim/issues/337#issuecomment-765563829
-- Capture original diagnostic config once at file load time
local original_diagnostic_config = nil
local methods = vim.lsp.protocol.Methods

-- Document highlight colors (set once globally, not per-attach)
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
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None" })
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "black", bold = true })
end

-- LspAttach: keymaps, document highlight, codelens
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_enhance", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end
		local bufnr = args.buf
		local opts = { buffer = bufnr, silent = true, noremap = true }

		-- Document highlight
		if client:supports_method(methods.textDocument_documentHighlight) then
			local hl_group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = hl_group,
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = hl_group,
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end

		-- Keymaps
		local diagnostics_group = vim.api.nvim_create_augroup("lsp_virtual_lines_" .. bufnr, { clear = true })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		local preset_default = { jump = { reuse_win = false } }
		local preset_ivy = { layout = { preset = "ivy" }, jump = { reuse_win = false } }
		vim.keymap.set("n", "<c-]>", function() Snacks.picker.lsp_definitions(preset_default) end, opts)
		vim.keymap.set("n", "<leader>td", function() Snacks.picker.lsp_type_definitions(preset_default) end, opts)
		vim.keymap.set("n", "<leader>im", function() Snacks.picker.lsp_implementations(preset_ivy) end, opts)
		vim.keymap.set("n", "<leader>rf", function() Snacks.picker.lsp_references(preset_ivy) end, opts)
		vim.keymap.set("n", "<leader>dw", function() Snacks.picker.diagnostics(preset_ivy) end, opts)
		vim.keymap.set("n", "<leader>db", function() Snacks.picker.diagnostics_buffer(preset_ivy) end, opts)
		vim.keymap.set("n", "<leader>bl", function() Snacks.picker.lsp_symbols(preset_default) end, opts)

		-- Virtual lines (inline diagnostics)
		if not original_diagnostic_config then
			original_diagnostic_config = vim.diagnostic.config()
		end
		vim.keymap.set("n", "<leader>do", function()
			vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
			vim.api.nvim_clear_autocmds({ group = diagnostics_group, buffer = bufnr })
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = diagnostics_group,
				buffer = bufnr,
				once = true,
				callback = function()
					vim.diagnostic.config(original_diagnostic_config)
				end,
			})
		end, { buffer = bufnr, desc = "Show diagnostics inline" })

		-- CodeLens
		require("config.codelens").setup(client, bufnr, opts)
	end,
})

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		---@diagnostic disable-next-line: need-check-nil
		if client:supports_method(methods.textDocument_foldingRange) then
			local win = vim.api.nvim_get_current_win()
			local win_opts = vim.wo[win]
			win_opts.foldmethod = "expr"
			win_opts.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

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
		-- icon         
		text = {
			[vim.diagnostic.severity.ERROR] = "✘ ",
			[vim.diagnostic.severity.WARN] = "▲ ",
			[vim.diagnostic.severity.INFO] = "» ",
			[vim.diagnostic.severity.HINT] = "⚑ ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
	float = {
		source = true
	}
})


vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			}
		}
	}
})

vim.lsp.enable({ "gopls", "emmylua_ls", "rust_analyzer", "clangd", "pyright" })

-- LSP progress: indeterminate animation while any LSP server is working.
do
	local osc = require("local.osc")
	local active_count = 0

	vim.api.nvim_create_autocmd("LspProgress", {
		group = vim.api.nvim_create_augroup("lsp_osc_progress", { clear = true }),
		callback = function(ev)
			local kind = ev.data.params.value.kind
			if kind == "begin" then
				active_count = active_count + 1
				if active_count == 1 then
					osc.progress(3)
				end
			elseif kind == "end" then
				active_count = math.max(active_count - 1, 0)
				if active_count == 0 then
					osc.progress(0)
				end
			end
		end,
	})
end
