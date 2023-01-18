local menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local popup_options = {
	relative = "win",
	position = "50%",
	size = {
		width = "30%",
		height = "20%",
	},
	border = {
		style = "rounded",
		highlight = "FloatBorder",
		text = {
			top = "[Choice one vimspector configuration]",
			top_align = "center",
		},
	},
	highlight = "Normal:Normal",
}

local get_vimspector_list = function()
	local results = {}

	local path = vim.fn.stdpath("config") .. "/vimspector"

	local fs = vim.fn.split(vim.fn.globpath(path, "*.json"))
	for _, f in pairs(fs) do
		table.insert(results, menu.item(f))
	end
	return results
end

function _G.show_vimspector_list()
	local list = menu(popup_options, {
		lines = get_vimspector_list(),
		max_width = 100,
		separator = {
			char = "-",
			text_align = "right",
		},
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function()
			-- print("CLOSED")
		end,
		on_submit = function(item)
			-- local data = read(item.text)
			-- local cmd = string.format("tabedit .vimspector.json<CR><ESC>:0r %s<CR>", item.text)
			vim.cmd(string.format(":tabedit .vimspector.json"))
			vim.cmd(string.format(":0r %s", item.text))
		end,
	})

	-- mount the component
	list:mount()

	-- close menu when cursor leaves buffer
	list:on(event.BufLeave, list.menu_props.on_close, { once = true })
end
