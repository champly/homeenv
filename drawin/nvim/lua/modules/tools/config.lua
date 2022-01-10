local config = {}
local bind = require("utils.bind")

function config.vimspector()
	if not packer_plugins["nui.nvim"].loaded then
		vim.cmd [[ packadd nui.nvim ]]
	end
	require("modules/tools/vimspector")

	vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'

	-- -- https://github.com/zunpeng/neovim/blob/master/cfgs/plug-cfg/vimspector-cfg.vim
	-- function! s:read_template_into_buffer(template)
	-- --     -- has to be a function to avoid the extra space fzf#run insers otherwise
	-- --     -- execute '0r ~/.config/nvim/vimspector/'.a:template
		-- execute '0r '.a:template
	-- endfunction
	-- command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
	--             \   'source': 'ls -d -1 ~/.config/nvim/vimspector/*.json',
	--             \   'down': 20,
	--             \   'sink': function('<sid>read_template_into_buffer')
	--             \ })
	-- noremap <leader>dt :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
	-- noremap <leader>dt :tabe .vimspector.json<CR>:Telescope vimspector<CR>
	vim.api.nvim_set_keymap("n", "<leader>dt", "<CR>:lua show_vimspector_list()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-s>", ":VimspectorReset<CR>", { noremap = true })

	vim.cmd [[ sign define vimspectorBP text=🛑 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorBPDisabled text=🚫 texthl=Normal ]]
	vim.cmd [[ sign define vimspectorPC text=👉 texthl=SpellBad ]]
end

return config
