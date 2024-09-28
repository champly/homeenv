return {
	{
		"preservim/nerdcommenter",
		event = "BufRead",
		init = function()
			-- 注释的时候自动加个空格,强迫症必配
			---@diagnostic disable-next-line: inject-field
			vim.g.NERDSpaceDelims = 1
		end
	}
}
