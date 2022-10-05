local utes = require("homerows.utils")
local log = require("homerows.dev")
local HomerowsTo = require("homerows.commands").HomerowsTo

M = {}

local function inputs_are_invalid(inputs)
  local one = inputs == nil
  local two = not utes.is_table(inputs)

  return one and two
end

local function add_to_layouts(layouts, table)
  for k, v in pairs(table) do
    layouts[k] = v
  end
  return layouts
end

local function combine_layouts(defaults, inputs)
  if inputs_are_invalid(inputs) then
    return defaults
  end

  local layouts = {}
  layouts = add_to_layouts(layouts, defaults)
  layouts = add_to_layouts(layouts, inputs)
  return layouts
end

local function handle_layouts(config)
  local default_layouts = require("homerows.layouts")
  local layouts = combine_layouts(default_layouts, config.custom_layouts)
  utes.save_layouts(layouts)
  return layouts
end

local function handle_keymap(add)
  if utes.is_string(add) then
    vim.keymap.set("n", add, function()
      local layout = vim.fn.input("change layout to:")
      HomerowsTo(layout)
    end)
  elseif add then
    vim.keymap.set("n", "<leader>hrt", function()
      local layout = vim.fn.input("change layout to:")
      HomerowsTo(layout)
    end)
  end
end

M.setup = function(config)
  if not utes.is_table(config) then
    config = {}
  end

  local layouts = handle_layouts(config)

  local output = utes.validate_options(config, layouts)

  utes.save_config(output)

  handle_keymap(config["add_keymap"])

  require("homerows.commands")
end

return M
