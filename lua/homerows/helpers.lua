---@class HomerowsHelper
local M = {}

local is_win = vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1

---Get the slash for the current OS
---@return string
M.get_slash = function()
  if is_win then return "\\" else return "/" end
end

---Check if the input is a table
---@return boolean
M.is_table = function(thing)
  return type(thing) == "table"
end

---Check if the input is a non-empty string
---@return boolean
M.is_string = function(thing)
  if type(thing) == "string" then
    if thing ~= "" or thing ~= " " then
      return true
    end
  end
  return false
end

---Check if the input is a table
---@return string|nil
M.project_key = function()
  return vim.loop.cwd()
end

---Check if the input is a table
---@return boolean
M.is_nil = function(input)
  return input == nil
end

return M
