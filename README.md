<div align="center" width="200%">

<img src="logo.svg" alt="drawing" width="100%"/>

# homerows.nvim
##### I don't care what keyboard layout I'm using, I just want my keybinding on my homerows...

</div>

## problem
I don't know if you've noticed but qwerty is f***ing everywhere. I think it sucks 
so I opt for a alternate layout when I can.

Most of my keybinds are put on my homerows for convenience but
when I switch between using vim on my laptop and my sick lightup keyboard this gets messed up.

If only there was a way to easily switch between keyboard layouts and keep my 
homerow keybindings. 

Then I thought, "I don't make the rules but I do make shitty nvim plugins."

## settings

```lua
settings = {
  pref = { "programmers_dvorak", "colemak_dh" }
  add_change_keymap = true,
  add_print_keymap = true
  custom_layouts = {
    ["your_layout"] = {

    }
  }
}
```
### pref


## preconfigured layouts

## commands

### :HomerowsTo

Change the keyboard layout that homerows is using. Either type the layout you're using 

the default keybinding for the command is `"<leader>hrt"` but you can easily 
enable, disable or use another keybinding in the [setup of homerows](#settings).

#### ripples



**at present, this does not reload your neovim so you will need to restart for the changes to take effect.**
If you know how to do this, please make a pull request to change it.

### :HomerowsAre

forgot what keyboard layout you're using? `"<leader>hra"` prints this in the bottom bar, or change it in the [setup](#settings). 


