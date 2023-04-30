local utes = require("homerows.utils")
local HomerowsTo = require("homerows.commands").HomerowsTo
local HomerowsAre = require("homerows.commands").HomerowsAre

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

local function handle_print_keymap(add)
  if utes.is_string(add) then
    vim.keymap.set("n", add, function()
      HomerowsAre()
    end, { desc = "homerows: print the current layout" })
  elseif add then
    vim.keymap.set("n", "<leader>hra", function()
      HomerowsAre()
    end, { desc = "homerows: print the current layout" })
  end
end

local function handle_change_keymap(add)
  if utes.is_string(add) then
    vim.keymap.set("n", add, function()
      local layout = vim.fn.input("change layout to:")
      HomerowsTo(layout)
    end, { desc = "homerows: change the current layout" })
  elseif add then
    vim.keymap.set("n", "<leader>hrt", function()
      local layout = vim.fn.input("change layout to:")
      HomerowsTo(layout)
    end, { desc = "homerows: change the current layout" })
  end
end

M.setup = function(config)
  if not utes.is_table(config) then
    config = {}
  end

  local layouts = handle_layouts(config)

  local output = utes.validate_options(config, layouts)

  utes.save_config(output)

  handle_change_keymap(config["add_change_keymap"])
  handle_print_keymap(config["add_print_keymap"])

  require("homerows.commands")
end

M.hr = function()
  return require("homerows.homerows")
end

return M
