local config = {}

function config.vimspector()
	require("modules/tools/vimspector")
end

function config.vimspector_setup()
	vim.g.vimspector_enable_mappings = "VISUAL_STUDIO"

	-- -- https://github.com/zunpeng/neovim/blob/master/cfgs/plug-cfg/vimspector-cfg.vim
	vim.api.nvim_set_keymap("n", "<leader>dt", "<CR>:lua show_vimspector_list()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-s>", ":VimspectorReset<CR>", { noremap = true })

	vim.cmd [[ sign define vimspectorBP text=🛑 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorBPDisabled text=🚫 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorPC text=👉 texthl=SpellBad ]]
end

function config.autopairs()
	local present1, autopairs = pcall(require, "nvim-autopairs")
	local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

	if present1 and present2 then
		autopairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})

		local cmp = require "cmp"
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	else
		autopairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})
	end
end

function config.smoothie_setup()
	vim.g.smoothie_remapped_commands = {
		"<C-D>",
		"<C-U>",
		"<C-F>",
		"<S-Down>",
		"<PageDown>",
		"<C-B>",
		"<S-Up>",
		"<PageUp>",
		"z+",
		"z^",
		"z<CR>",
		"z.",
		"z-",
		-- "zt",
		-- "zz",
		-- "zb",
	}
end

function config.matchparen()
	require("matchparen").setup({
		on_startup = true, -- Should it be enabled by default
		hl_group = "MatchParen", -- highlight group for matched characters
		augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
	})
end

function config.neoformat()
	-- Enable alignment
	vim.g.neoformat_basic_format_align = 1
	-- Enable tab to spaces conversion
	vim.g.neoformat_basic_format_retab = 1
	-- Enable trimmming of trailing whitespace
	vim.g.neoformat_basic_format_trim = 1
end

return config
