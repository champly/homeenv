return {
	-- Insert or delete brackets, parens, quotes in pair
	{
		"windwp/nvim-autopairs",
		event = "BufReadPre",
		config = function()
			local present1, autopairs = pcall(require, "nvim-autopairs")
			local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

			if present1 and present2 then
				autopairs.setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})

				local cmp = require("cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			else
				autopairs.setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end
		end,
	}
}
