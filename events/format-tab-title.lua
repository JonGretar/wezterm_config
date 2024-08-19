local wezterm = require("wezterm")
local M = {}

M.setup = function()
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
end

return M
