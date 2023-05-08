---@type HomerowsHelper
local h = require("homerows.helpers")
local commands = require("homerows.commands")
local uv = vim.loop

---@class HomerowsUtils
local M = {}

local function get_config_path()
  return string.format("%s%shomerows.json", vim.fn.stdpath("data"), h.get_slash())
end

---Read a json file
---@return HomerowsConfig
local function read_config()
  local fd = assert(uv.fs_open(get_config_path(), "r", 438)) -- for some reason test won't pass with absolute
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return vim.fn.json_decode(data)
end

---Write a json file with provided data
---@param data string|table # the data to be written
---@return nil
local function write_config(data)
  local f = assert(uv.fs_open(get_config_path(), "w", 438))
  uv.fs_write(f, vim.fn.json_encode(data), -1)
  uv.fs_close(f)
end

---load saved user config
---@return HomerowsConfig
M.load_config = function()
  local ok, config = pcall(read_config)
  if ok then return config else return {} end
end

---save user config
---@param user_config HomerowsConfig
---@return nil
M.save_config = function(user_config)
  return write_config(user_config)
end

---get the list of layouts in the current layouts config
---@return string[]
M.get_layouts = function()
  local config = M.load_config()
  return config.layouts
end

---@type HomerowsConfig
local default_config = {
  add_to_keymap = false,
  add_are_keymap = false,
  custom_keys = {},
  layouts = {},
  prefs = {},
}

---create config from default, persisted user config and provided user config
---@param user_config HomerowsConfig
---@return HomerowsConfig
function M.merge_config(user_config)
  local saved_config = M.load_config()
  ---@type HomerowsConfig
  local config = vim.tbl_extend('force', { current_layout = "qwerty" }, saved_config or {}, default_config, user_config)
  config.layouts = vim.tbl_extend('force', require("homerows.default_layouts"), user_config.layouts or {})
  return config
end

---add the homerows keymaps based on user config
---@param config HomerowsConfig
function M.add_keymaps(config)
  if h.is_string(config.add_to_keymap) or config.add_to_keymap then
    vim.keymap.set("n", h.is_string(config.add_to_keymap) and config.add_to_keymap or "<leader>hrt",
      function()
        local layout = vim.fn.input("change layout to: ")
        commands.HomerowsTo(layout)
      end, { desc = "homerows: change the current layout" })
  end
  if h.is_string(config.add_are_keymap) or config.add_are_keymap then
    vim.keymap.set("n", h.is_string(config.add_are_keymap) and config.add_are_keymap or "<leader>hra", function()
      commands.HomerowsAre()
    end, { desc = "homerows: print the current layout" })
  end
end

return M
