local utes = require("homerows.utils")
local log = require("homerows.dev")

local layouts = utes.load_layouts()
local prefs = utes.load_config()

local layout = layouts[prefs["current_layout"]]
for key, value in pairs(prefs["custom_keys"]) do
    layout[key] = layout[value]
end

return layout
