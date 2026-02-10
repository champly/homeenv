return {
	{
		"tpope/vim-eunuch",
		event = "BufReadPre",
	},
	{
		"tpope/vim-repeat",
		event = "BufReadPre",
	},
	-- https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94
	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},
	-- quick choice
	{
		"gcmt/wildfire.vim",
		event = "BufReadPre",
	},
	{
		"nvim-mini/mini.splitjoin",
		keys = {
			"gS"
		},
		config = true
	},
}
