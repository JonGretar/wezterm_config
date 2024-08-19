local wezterm = require("wezterm")
local tabs = require("utils/tabs")

local config = wezterm.config_builder()

-- Visual Decorations --
config.window_background_opacity = 0.8
config.macos_window_background_blur = 15
config.native_macos_fullscreen_mode = true
-- config.window_decorations = "TITLE | RESIZE"

-- Visual Settings --
config.font_size = 16
config.command_palette_font_size = 18
-- config.color_scheme = "midnight-in-mojave"
config.color_scheme = "Catppuccin Macchiato"

config.default_cursor_style = "SteadyBar"
config.enable_scroll_bar = false

-- Tab Config
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false

-- Keyboard fiddling
config.send_composed_key_when_left_alt_is_pressed = true

-- Background Image --
config.background = {
	{
		source = { File = wezterm.config_dir .. "/backgrounds/crt-term.jpg" },
		opacity = 0.90,
		hsb = {
			hue = 0.9,
			saturation = 0.6,
			brightness = 0.1,
		},
	},
}
require("events.gui-startup").setup()

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

-- Set the Window title
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. tab.active_pane.title
end)

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local title = tab_title(tab)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = utf8.char(0x1F50D) .. " "
	end
	return " " .. tab.tab_index + 1 .. ": " .. zoomed .. title .. " "
end)

-- Load the keybindings from keys.lua --
local keys = require("keys")
keys.make_config(config)

return config
