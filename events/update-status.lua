local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local tabs = require("../utils/tabs")

local M = {}

M.setup = function()
	-- mux status
	wezterm.on("update-status", function(window, _)
		-- local SOLID_LEFT_ARROW = " " .. utf8.char(0xe0b2)
		local SOLID_LEFT_ARROW = " " .. nf.pl_right_hard_divider
		local SOLID_RIGHT_ARROW = nf.pl_left_hard_divider .. " "
		local RIGHT_ARROW = utf8.char(0xe0b1)
		local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
		local date = wezterm.strftime("%Y-%m-%d %H:%M")
		local prefix = ""

		local key_table = ""
		if window:active_key_table() then
			key_table = RIGHT_ARROW .. " " .. wezterm.nerdfonts.md_keyboard .. " " .. window:active_key_table() .. " "
		end

		if window:leader_is_active() then
			prefix = " " .. utf8.char(0x1f30a) -- ocean wave
			SOLID_LEFT_ARROW = nf.pl_right_hard_divider
		end

		if tabs.get_tab_index(window) ~= 0 then
			ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
		end -- arrow color based on if tab is first pane

		window:set_right_status(wezterm.format({

			{ Text = key_table },
			"ResetAttributes",

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
