-- local wezterm = require("wezterm")
-- local act = wezterm.action
local tabs = {}

function tabs.get_tab_index(window)
	local tab_list = window:mux_window():tabs_with_info()
	for _, item in ipairs(tab_list) do
		if item.is_active then
			return item.index
		end
	end
end

return tabs
