local common = {}

function common.redraw_statusline(timeout)
	local function create_timer_callback(timer, times)
		local count = 0

		return function()
			vim.schedule(function()
				vim.cmd([[ redrawstatus ]])
			end)

			count = count + 1

			if count > times then
				vim.loop.timer_stop(timer)
				vim.loop.close(timer)
			end
		end
	end

	timeout = timeout * 1000
	local interval = 150
	local timer = vim.loop.new_timer()
	local timer_callback = create_timer_callback(timer, timeout / interval)
	vim.loop.timer_start(timer, 0, interval, timer_callback)
end

return common
