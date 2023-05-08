local u = require("homerows.utils")
local log = require("homerows.dev")

M = {}

---For use with lazy.nvim
---Build the bare-bones config for use during lazy setup
---@return nil
M.build = function()
  local config = u.merge_config({})
  u.save_config(config)
end

---Set up homerows
---@param user_config HomerowsConfig
---@return HomerowsConfig
M.setup = function(user_config)
  local config = u.merge_config(user_config)
  u.add_keymaps(config)
  u.save_config(config)
  return config
end

---For use with packer.nvim, etc.
---returns the current layout with the custom keys
---@return Layout
M.hr = function()
  local config = u.load_config()
  local layout = config.layouts[config.current_layout]
  for key, value in pairs(config.custom_keys) do
    layout[key] = layout[value]
  end

  return layout
end

---For use with lazy.nvim.
---Source the homerows config from lazy to use in keys, opts, etc.
---returns The current layout with custom keys
---@return Layout
M.lazy_hr = function()
  local plugin = require("lazy.core.config").spec.plugins["homerows.nvim"]
  local hr_opts = require("lazy.core.plugin").values(plugin, "opts", false)
  local config = u.merge_config(hr_opts or {})
  local layout = config.layouts[config.current_layout]
  for key, value in pairs(config.custom_keys) do
    layout[key] = layout[value]
  end

  return layout
end


return M
