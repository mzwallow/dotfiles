local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local menu = {}
local menu_items = {}

local terminal = Global.vars.terminal
local editor_cmd = Global.vars.editor_cmd

-- Create a launcher widget and a main menu
menu.awesome = {
    {"hotkeys", function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
    end}, 
    {"manual", terminal .. " -e man awesome"}, 
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart}, 
    {"quit", function() awesome.quit() end}
}

menu_items = {
    {"awesome", menu.awesome, beautiful.awesome_icon}, 
    {"open terminal", terminal}
}

return menu_items
