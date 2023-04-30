local utes = require("homerows.utils")
local log = require("homerows.dev")

local layouts = utes.load_layouts()
local prefs = utes.load_config()

local layout = layouts[prefs["current_layout"]]
return vim.tbl_extend("force", layout, prefs["custom_keys"])
