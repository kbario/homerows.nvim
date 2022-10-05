local utes = require("homerows.utils")
local log = require("homerows.dev")

local layouts = utes.load_layouts()
local prefs = utes.load_config()

return layouts[prefs["current_layout"]]

