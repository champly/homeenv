local bind = require("utils.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.map_cr
local map_cu = bind.map_cu

-- default map
local def_map = {
	-- vim map
	["n|Y"]          = map_cmd("y$"),
	["n|<leader>n"]  = map_cr("enew"),
	["n|<leader>db"] = map_cr("bd!"),

	-- insert
	["n|<leader>ss"] = map_cu("SessionSave"),
	["n|<leader>sl"] = map_cu("SessionLoad"),

	-- Call figlet
	-- brew install figlet
	["n|fl"] = map_cmd(":r !figlet "),
}

bind.nvim_load_mapping(def_map)