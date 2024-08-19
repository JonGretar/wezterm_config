local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

M.setup = function()
	-- Full screen on startup
	wezterm.on("gui-startup", function(cmd)
		local tab, pane, window = mux.spawn_window(cmd or {})
		window:gui_window():toggle_fullscreen()
	end)
end

return M
