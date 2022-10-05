local function printer(reason, input)
  if reason == "no_layout" then
    print(string.format('no layouts called %s', input))
  end
end

local function validate_input(layout)
  local layouts = require("homerows.utils").load_layouts()
  return layouts[layout] ~= nil
end

local function HomerowsTo(layout)
  local utes = require("homerows.utils")
  local config = utes.load_config()

  if utes.is_string(layout) then
    layout = string.lower(layout)
  else
    layout = string.lower(layout[1])
  end

  if validate_input(layout) then
    config.current_layout = layout
    utes.save_config(config)
    vim.api.nvim_command(":source $MYVIMRC")
  else
    printer("no_layout", layout)
  end
end

vim.api.nvim_create_user_command("HomerowsTo", function(opts)
  HomerowsTo(opts.fargs)
end, {
  desc = "Change the keyboard layout you're using",
  nargs = "+",
  -- complete = "custom,v:lua.mason_completion.available_package_completion",
})

return {
  HomerowsTo = HomerowsTo,
}
