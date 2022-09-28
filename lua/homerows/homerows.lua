local M = {}

local function HomerowsTo(layout)
  local utes = require("homerows.utils")
  local layouts = utes.
  local config = utes.load_config("data")
  config.current_layout = layout
  utes.save_config("data", config)
end

vim.api.nvim_create_user_command("HomerowsTo", function(opts)
    HomerowsTo(opts.fargs)
end, {
    desc = "Change the keyboard layout you're using",
    -- nargs = "+",
    -- complete = "custom,v:lua.mason_completion.available_package_completion",
})

return M
