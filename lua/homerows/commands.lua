---@enum print
local PRINT = {
  NoLayout = "a",
  ChangedLayout = "b",
  LayoutIs = "c"
}

--- print feedback to the user
---@param reason print
---@param input string
local function printer(reason, input)
  if reason == PRINT.NoLayout then
    print(string.format('no layouts called %s', input))
  elseif reason == PRINT.ChangedLayout then
    print(string.format("changed layout to %s", input))
  elseif reason == PRINT.LayoutIs then
    print(string.format("current layout is %s", input))
  end
end

---check if the input is a layout name in the homerows config
---@param layout any
---@return boolean
local function is_layout_name(layout)
  return require("homerows.utils").get_layouts()[layout] ~= nil
end

---Create the right hand ripple from provided layout
---@param layout Layout
---@return string
local function right_ripple(layout)
  return string.format("%s%s%s%s", layout.r4, layout.r3, layout.r2, layout.r1)
end

---Create the left hand ripple from provided layout
---@param layout Layout
---@return string
local function left_ripple(layout)
  return string.format("%s%s%s%s", layout.l4, layout.l3, layout.l2, layout.l1)
end

---get the layout from the users ripple
---@param ripple string
---@return boolean
---@return string
local function get_layout_from_ripple(ripple)
  local config = require("homerows.utils").load_config()
  for _, v in pairs(config.prefs) do
    if right_ripple(config.layouts[v]) == ripple or left_ripple(config.layouts[v]) == ripple then
      return true, v
    end
  end
  for k, _ in pairs(config.layouts) do
    if right_ripple(config.layouts[k]) == ripple or left_ripple(config.layouts[k]) == ripple then
      return true, k
    end
  end
  return false, ''
end

---Save the new layout in persisted config, print feedback to the user and reload nvim so the changes take effect
---@param config HomerowsConfig
---@param layout string
local function save_print_reload_layout(config, layout, utes)
  config.current_layout = layout
  printer(PRINT.ChangedLayout, layout)
  utes.save_config(config)
  vim.api.nvim_command(":source $MYVIMRC")
end

---Change the layout Homerows will use
---@param input string # The layout you wish to change to
local function HomerowsTo(input)
  local h = require("homerows.helpers")
  local utes = require("homerows.utils")
  local config = utes.load_config()

  -- if is null then do nothing
  if h.is_nil(input) then
    return
    -- if is a string, assume it is input from keymap
  elseif h.is_string(input) then
    input = string.lower(input)
  else
    -- if it is table, assume it is input from command
    input = string.lower(input[1])
  end

  local layout_name = is_layout_name(input)
  local ripple_ok, layout = get_layout_from_ripple(input)

  if layout_name then
    config.current_layout = input
    save_print_reload_layout(config, input, utes)
  elseif ripple_ok then
    save_print_reload_layout(config, layout, utes)
  else
    printer(PRINT.NoLayout, input)
  end
end

---Print the current layout Homerows is using
local function HomerowsAre()
  local config = require("homerows.utils").load_config()
  printer(PRINT.LayoutIs, config.current_layout)
end

vim.api.nvim_create_user_command("HomerowsAre", HomerowsAre, {
  desc = "Print out the keyboard layout Homerows is using",
  nargs = 0,
})

vim.api.nvim_create_user_command("HomerowsTo", function(opts)
  HomerowsTo(opts.fargs)
end, {
  desc = "Change the keyboard layout you're using",
  nargs = "*",
  complete = function()
    return require("homerows.utils").get_layouts()
  end,
})

return {
  HomerowsTo = HomerowsTo,
  HomerowsAre = HomerowsAre,
}
