local wezterm = require("wezterm")
-- local act = wezterm.action
local mux = wezterm.mux

local function get_tab_index(window)
    local tab_id = window:active_tab():tab_id()
    local tabs = window:mux_window():tabs_with_info()
    for _, item in ipairs(tabs) do
        if item.is_active then
            return item.index
        end
    end
end

return {
    get_tab_index = get_tab_index
}
