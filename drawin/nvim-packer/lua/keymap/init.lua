local bind = require("utils.bind")
local map_cmd = bind.map_cmd
local map_cr = bind.mpa_cr
local map_cu = bind.map_cu
local map_args = bind.map_args
require("keymap.config")

local plug_map = {
}

bind.nvim_load_mapping(plug_map)
