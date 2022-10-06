local log = require("homerows.dev")

local function printer(reason, input)
  if reason == "no_layout" then
    print(string.format('no layouts called %s', input))
  elseif reason == "change_layout" then
    print(string.format("changed layout to %s", input))
  elseif reason == "layout_is" then
    print(string.format("current layout is %s", input))
  end
end

local function is_layout_name(layout)
  local layouts = require("homerows.utils").load_layouts()
  return layouts[layout] ~= nil
end

local function concat_ripple_right(layout)
  return string.format("%s%s%s%s", layout.r4, layout.r3, layout.r2, layout.r1)
end

local function concat_ripple_left(layout)
  return string.format("%s%s%s%s", layout.l4, layout.l3, layout.l2, layout.l1)
end

local function is_layout_ripple(ripple)
  local layouts = require("homerows.utils").load_layouts()
  local prefs = require("homerows.utils").load_config()
  for _, v in pairs(prefs.pref) do
    if concat_ripple_right(layouts[v]) == ripple then
      return true
    elseif concat_ripple_left(layouts[v]) == ripple then
      return true
    end
  end
  for k, _ in pairs(layouts) do
    if concat_ripple_right(layouts[k]) == ripple then
      return true
    elseif concat_ripple_left(layouts[k]) == ripple then
      return true
    end
  end
  return false
end

local function get_layout_from_ripple(ripple)
  local layouts = require("homerows.utils").load_layouts()
  local prefs = require("homerows.utils").load_config()
  for _, v in pairs(prefs.pref) do
    if concat_ripple_right(layouts[v]) == ripple then
      return v
    elseif concat_ripple_left(layouts[v]) == ripple then
      return v
    end
  end
  for k, _ in pairs(layouts) do
    if concat_ripple_right(layouts[k]) == ripple then
      return k
    elseif concat_ripple_left(layouts[k]) == ripple then
      return k
    end
  end
end

local function HomerowsTo(layout)
  local utes = require("homerows.utils")
  local config = utes.load_config()

  if utes.is_nil(layout) then
    return
  elseif utes.is_string(layout) then
    layout = string.lower(layout)
  else
    layout = string.lower(layout[1])
  end

  if is_layout_name(layout) then
    config.current_layout = layout
    printer("change_layout", layout)
  elseif is_layout_ripple(layout) then
    local new_layout = get_layout_from_ripple(layout)
    config.current_layout = new_layout
    printer("change_layout", new_layout)
  else
    return printer("no_layout", layout)
  end
  utes.save_config(config)
  vim.api.nvim_command(":source $MYVIMRC")
end

local function HomerowsAre()
  local prefs = require("homerows.utils").load_config()
  printer("layout_is", prefs.current_layout)
end

vim.api.nvim_create_user_command("HomerowsAre", HomerowsAre, {
  desc = "Prints out the keyboard layout homerows is using",
  nargs = 0,
})

vim.api.nvim_create_user_command("HomerowsTo", function(opts)
  HomerowsTo(opts.fargs)
end, {
  desc = "Change the keyboard layout you're using",
  nargs = "+",
  -- complete = "custom,v:lua.mason_completion.available_package_completion",
})

return {
  HomerowsTo = HomerowsTo,
  HomerowsAre = HomerowsAre,
}
