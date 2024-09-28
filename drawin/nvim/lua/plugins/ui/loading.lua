return {
	{
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					-- How long a message should persist after completion
					done_ttl = 1,
					-- https://github.com/j-hui/fidget.nvim/blob/main/lua/fidget/spinner/patterns.lua
					progress_icon = {
						pattern = "meter",
						period = 1,
					}
				}
			},
			notification = {
				window = {
					-- Background color opacity in the notification window
					winblend = 20,
				}
			}
		},
	}
}
