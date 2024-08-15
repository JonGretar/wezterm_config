local wezterm = require("wezterm")
local act = wezterm.action
-- local mux = wezterm.mux

-- Create a function that takes config parameters and returns a config table

local function make_config(config)
	config.leader = { key = "b", mods = "CMD", timeout_milliseconds = 2000 }

	config.keys = {
		{ key = "P", mods = "CMD|SHIFT", action = wezterm.action.ActivateCommandPalette },
		{ key = "Enter", mods = "CMD", action = act.ActivateCopyMode },
		{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "l", mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "LeftArrow", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "LeftArrow", mods = "CMD|ALT", action = act.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|ALT", action = act.ActivateTabRelative(1) },
		{ key = "t", mods = "CMD|SHIFT", action = act.ShowTabNavigator },
		{ key = "H", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
		{ key = "L", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
		{ key = "K", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
		{ key = "J", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
		{
			key = "k",
			mods = "SUPER",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackAndViewport"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
		-- Leader Key tmuxing
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
	}
end

return {
	make_config = make_config,
}
