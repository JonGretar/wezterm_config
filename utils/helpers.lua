-- local wezterm = require("wezterm")
-- local act = wezterm.action
local M = {}

function M.get_tab_index(window)
	local tab_list = window:mux_window():tabs_with_info()
	for _, item in ipairs(tab_list) do
		if item.is_active then
			return item.index
		end
	end
end

function M.get_active_pane_info(pane)
	local pane_list = pane:tab():panes_with_info()
	for _, item in ipairs(pane_list) do
		if item.is_active then
			return item
		end
	end
end

return M
