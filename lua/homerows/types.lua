---@class HomerowsConfig
---@field current_layout string
---@field add_to_keymap? string|boolean
---@field add_are_keymap? string|boolean
---@field custom_keys? table<string, string>
---@field layouts? table<string, Layouts>
---@field prefs? string[]

---@alias Layouts table<string, Layout>

---@class Layout
---@field [string] string
---@field [KeyPosition] string

---@enum KeyPosition
local key_positions = {
  l0 = "l0",
  l1 = "l1",
  l2 = "l2",
  l3 = "l3",
  l4 = "l4",
  r0 = "r0",
  r1 = "r1",
  r2 = "r2",
  r3 = "r3",
  r4 = "r4",
  l0t = "l0t",
  l1t = "l1t",
  l2t = "l2t",
  l3t = "l3t",
  l4t = "l4t",
  r0t = "r0t",
  r1t = "r1t",
  r2t = "r2t",
  r3t = "r3t",
  r4t = "r4t",
  l0b = "l0b",
  l1b = "l1b",
  l2b = "l2b",
  l3b = "l3b",
  l4b = "l4b",
  r0b = "r0b",
  r1b = "r1b",
  r2b = "r2b",
  r3b = "r3b",
  r4b = "r4b",
  L0 = "L0",
  L1 = "L1",
  L2 = "L2",
  L3 = "L3",
  L4 = "L4",
  R0 = "R0",
  R1 = "R1",
  R2 = "R2",
  R3 = "R3",
  R4 = "R4",
  L0t = "L0t",
  L1t = "L1t",
  L2t = "L2t",
  L3t = "L3t",
  L4t = "L4t",
  R0t = "R0t",
  R1t = "R1t",
  R2t = "R2t",
  R3t = "R3t",
  R4t = "R4t",
  L0b = "L0b",
  L1b = "L1b",
  L2b = "L2b",
  L3b = "L3b",
  L4b = "L4b",
  R0b = "R0b",
  R1b = "R1b",
  R2b = "R2b",
  R3b = "R3b",
  R4b = "R4b",
}
