local wezterm = require("wezterm")
local M = {}

M.setup = function()
	-- mux status
	wezterm.on("update-right-status", function(window, _)
		local SOLID_LEFT_ARROW = " " .. utf8.char(0xe0b2)
		local SOLID_RIGHT_ARROW = utf8.char(0xe0b0) .. " "
		local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
		local date = wezterm.strftime("%Y-%m-%d %H:%M")
		local prefix = ""

		if window:leader_is_active() then
			prefix = " " .. utf8.char(0x1f30a) -- ocean wave
			SOLID_LEFT_ARROW = utf8.char(0xe0b2)
		end

		if tabs.get_tab_index(window) ~= 0 then
			ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
		end -- arrow color based on if tab is first pane

		window:set_right_status(wezterm.format({
			{ Background = { Color = "#b7bdf8" } },
			{ Foreground = { Color = "#1e2030" } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Text = date },
		}))

		window:set_left_status(wezterm.format({
			{ Background = { Color = "#b7bdf8" } },
			{ Text = prefix },
			ARROW_FOREGROUND,
			{ Text = SOLID_LEFT_ARROW },
		}))
	end)
end

return M
