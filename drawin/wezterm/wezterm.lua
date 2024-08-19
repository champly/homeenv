-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("SauceCodePro Nerd Font")
config.font_size = 15

-- For example, changing the color scheme:
config.color_scheme = "BlulocoLight"
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "white",
		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#f6f6f6",
			-- The color of the text for the tab
			fg_color = "black",
		},
		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#e8e8e8",
			fg_color = "black",
		},
	},
	-- the background color of selected text
	selection_bg = '#b3b3b3',
}

config.scrollback_lines = 100000
config.enable_scroll_bar = true

config.keys = {
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
	},
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
	},
	{
		key = "[",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Prev")
	},
	{
		key = "]",
		mods = "SUPER",
		action = wezterm.action.ActivatePaneDirection("Next")
	},
}

-- and finally, return the configuration to wezterm
return config
