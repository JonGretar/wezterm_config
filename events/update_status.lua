local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local tabs = require("utils.tabs")

local function left_status(window, pane)
	local elements = {}
	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
	local SOLID_LEFT_ARROW = " " .. nf.pl_right_hard_divider
	local LEADER_ICON = " " .. utf8.char(0x1f30a) -- ocean wave

	table.insert(elements, { Background = { Color = "#b7bdf8" } })

	if window:leader_is_active() then
		table.insert(elements, { Text = LEADER_ICON })
	end

	-- arrow color based on if tab is first pane
	if tabs.get_tab_index(window) ~= 0 then
		table.insert(elements, { Foreground = { Color = "#1e2030" } })
	else
		table.insert(elements, ARROW_FOREGROUND)
	end
	table.insert(elements, { Text = SOLID_LEFT_ARROW })

	window:set_left_status(wezterm.format(elements))
end

local function right_status(window, pane)
	local elements = {}

	local SOLID_RIGHT_ARROW = nf.pl_left_hard_divider .. " "
	local RIGHT_ARROW = utf8.char(0xe0b1)

	-- Key Table
	if window:active_key_table() then
		local text = table.concat({
			RIGHT_ARROW,
			" ",
			wezterm.nerdfonts.md_keyboard,
			window:active_key_table(),
			" ",
		}, " ")
		table.insert(elements, { Text = text })
		table.insert(elements, "ResetAttributes")
	end

	-- Date pill
	local date = wezterm.strftime("%Y-%m-%d %H:%M")
	table.insert(elements, { Background = { Color = "#b7bdf8" } })
	table.insert(elements, { Foreground = { Color = "#1e2030" } })
	table.insert(elements, { Text = SOLID_RIGHT_ARROW })
	table.insert(elements, { Text = date })

	window:set_right_status(wezterm.format(elements))
end

wezterm.on("update-status", function(window, pane)
	left_status(window, pane)
	right_status(window, pane)
end)
