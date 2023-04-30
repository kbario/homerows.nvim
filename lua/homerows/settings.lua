local A_STRING = "a_string"

return {
  [A_STRING] = A_STRING,
  ["settings"] = {
    ["pref"] = {
      ["allow_config_input"] = true,
      ["replace_values"] = true,
      ["desc"] = "if a table is given to spear and one of the extensions is matched as the current file at run time, do you want to stay there or do you want to continue through the rest of the extensions",
      ["values"] = {},
      ["default"] = { "programmers_dvorak", "colemak_dh" },
    },
    ["current_layout"] = {
      ["allow_config_input"] = false,
      ["replace_values"] = true,
      ["desc"] = "the current layout to use in keymaps",
      ["values"] = {},
      ["default"] = "qwerty",
    },
    ["add_change_keymap"] = {
      ["allow_config_input"] = true,
      ["replace_values"] = false,
      ["desc"] = "add the keymap on init or add your own",
      ["values"] = { true, false, A_STRING },
      ["default"] = true,
    },
    ["add_print_keymap"] = {
      ["allow_config_input"] = true,
      ["replace_values"] = false,
      ["desc"] = "add the keymap to print what layout homerows is using",
      ["values"] = { true, false, A_STRING },
      ["default"] = true,
    },
    ["custom_layouts"] = {
      ["allow_config_input"] = true,
      ["replace_values"] = false,
      ["desc"] = "add the keymap to print what layout homerows is using",
      ["values"] = { A_STRING },
      ["default"] = {},
    },
    ["custom_keys"] = {
      ["allow_config_input"] = true,
      ["replace_values"] = false,
      ["desc"] = "add the keymap on init or add your own",
      ["values"] = {},
      ["default"] = {},
    },
  }
}
