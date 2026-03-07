local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local M = {}

local sessionizer = wezterm.plugin.require("https://github.com/mikkasendke/sessionizer.wezterm")
local history = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer-history"

local my_schema = {
    options = {callback = history.Wrapper(sessionizer.DefaultCallback)},
    {
        history.MostRecentWorkspace {},
        processing = {
            sessionizer.for_each_entry(
                function(entry)
                    entry.label = "📖 " .. entry.label
                end
            )
        }
    },
    sessionizer.DefaultWorkspace {label_overwrite = "🏠 Default"},
    {
        sessionizer.AllActiveWorkspaces {filter_default = true, filter_current = true},
        processing = {
            sessionizer.for_each_entry(
                function(entry)
                    entry.label = "💻 " .. entry.label
                end
            )
        }
    },
    function()
        local res = {}
        local success, stdout, stderr =
            wezterm.run_child_process {
            "ls",
            "-1",
            wezterm.home_dir .. "/Developer"
        }
        for line in stdout:gmatch "[^\n]+" do
            table.insert(
                res,
                {
                    label = nf.cod_add .. "  " .. line,
                    id = wezterm.home_dir .. "/Developer/" .. line
                }
            )
        end
        return res
    end
}

M.show = sessionizer.show(my_schema)

return M
