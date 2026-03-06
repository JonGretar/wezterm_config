local wezterm = require("wezterm")
local M = {}

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"

local my_schema = {
    options = { callback = history.Wrapper(sessionizer.DefaultCallback) },
	{
        history.MostRecentWorkspace {},
		processing = {
			sessionizer.for_each_entry(function(entry)
			    entry.label = "📖 " .. entry.label
	            end
			)
		}
    },

    sessionizer.DefaultWorkspace { label_overwrite = "🏠 Default"},

    {
    	sessionizer.AllActiveWorkspaces {filter_default=true, filter_current=true},
    	processing = {
			sessionizer.for_each_entry(function(entry)
			    entry.label = "💻 " .. entry.label
	            end
			)
		}
	},


    {
    	wezterm.home_dir .. "/.config/dotter",
	    sessionizer.FdSearch { wezterm.home_dir .. "/Developer/", fd_path = "/opt/homebrew/bin/fd" },

		processing = sessionizer.for_each_entry(function(entry)
			entry.label = "⊕ " .. entry.label:gsub(wezterm.home_dir, "~")
		end)
    },

}

M.show = sessionizer.show(my_schema)

return M
