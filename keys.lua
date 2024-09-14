local wezterm = require("wezterm")
local act = wezterm.action

-- Create a function that takes config parameters and returns a config table
local function make_config(config)
	config.leader = { key = "Space", mods = "CMD|SHIFT", timeout_milliseconds = 2000 }

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

		-- Acticate Pane Management mode.
		{
			key = "w",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "pane_management",
				one_shot = false,
				timeout_milliseconds = 4000,
				until_unknown = false,
				prevent_fallback = true,
			}),
		},
		{
			key = "W",
			mods = "LEADER|SHIFT",
			action = act.ActivateKeyTable({
				name = "pane_management",
				timeout_milliseconds = 2000,
			}),
		},
	}

	config.key_tables = {
		pane_management = {
			-- Pane Activation
			{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
			{ key = "h", action = act.ActivatePaneDirection("Left") },
			{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
			{ key = "l", action = act.ActivatePaneDirection("Right") },
			{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
			{ key = "k", action = act.ActivatePaneDirection("Up") },
			{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
			{ key = "j", action = act.ActivatePaneDirection("Down") },

			-- Pane Resizing
			{ key = "LeftArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "RightArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "UpArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "DownArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },

			-- Split Pane
			{ key = "s", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
			{ key = "v", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

			-- Rotate Panes
			{ key = "r", action = act.RotatePanes("Clockwise") },
			{ key = "R", mods = "SHIFT", action = act.RotatePanes("CounterClockwise") },

			-- Swap pane position
			{ key = "m", action = act.PaneSelect({ mode = "SwapWithActive" }) },

			-- Zoom pane
			{ key = "z", action = act.TogglePaneZoomState },

			-- Tab Selection
			{ key = "1", action = act.ActivateTab(0) },
			{ key = "2", action = act.ActivateTab(1) },
			{ key = "3", action = act.ActivateTab(2) },
			{ key = "4", action = act.ActivateTab(3) },
			{ key = "5", action = act.ActivateTab(4) },
			{ key = "6", action = act.ActivateTab(5) },
			{ key = "7", action = act.ActivateTab(6) },
			{ key = "8", action = act.ActivateTab(7) },
			{ key = "9", action = act.ActivateTab(8) },

			-- Exit pane management mode
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}
end

return {
	make_config = make_config,
}
