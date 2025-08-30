local wezterm = require("wezterm")
local config = wezterm.config_builder()
local helpers = require("utils.helpers")

-- Visual Decorations --
config.window_background_opacity = 0.8
config.macos_window_background_blur = 15
config.native_macos_fullscreen_mode = true
-- config.window_decorations = "TITLE | RESIZE"

-- Visual Settings --
config.font_size = 16
config.command_palette_font_size = 18
config.color_scheme = "Zenburn"
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#88b090",
			fg_color = "#000",
		},
	},
}

-- TermInfo stuff --
-- See: https://wezfurlong.org/wezterm/config/lua/config/term.html
config.term = "wezterm"

config.enable_scroll_bar = false

-- Tab Config
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

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
	{
		source = { File = wezterm.config_dir .. "/backgrounds/montel-logo-clean.png" },
		opacity = 0.02,
		height = "Contain",
		width = "Contain",
		vertical_align = "Middle",
		horizontal_align = "Center",
		repeat_x = "NoRepeat",
		-- attachment = { Parallax = 0.1 },
	},
}

-- Launch Menu Items --
config.launch_menu = {
	{
		label = 'BTop',
		args = { '/opt/homebrew/bin/btop' },
	},
	{
		label = 'Nushell',
		args = { '/opt/homebrew/bin/nu', '-l' },
	},
	{
		-- Optional label to show in the launcher. If omitted, a label
		-- is derived from the `args`
		label = 'Bash',
		-- The argument array to spawn.  If omitted the default program
		-- will be used as described in the documentation above
		args = { 'bash', '-l' },

		-- You can specify an alternative current working directory;
		-- if you don't specify one then a default based on the OSC 7
		-- escape sequence will be used (see the Shell Integration
		-- docs), falling back to the home directory.
		-- cwd = "/some/path"

		-- You can override environment variables just for this command
		-- by setting this here.  It has the same semantics as the main
		-- set_environment_variables configuration option described above
		-- set_environment_variables = { FOO = "bar" },
	},
}

-- Load the event handlers --
require("events.gui_startup")
require("events.format_tab_title")
require("events.format_window_title")
require("events.update_status")

-- Load the keybindings from keys.lua --
require("keys").make_config(config)

if helpers.file_exists(wezterm.config_dir .. "/domains/ssh_domains.lua") then
	config.ssh_domains = require("domains.ssh_domains")
end

return config
