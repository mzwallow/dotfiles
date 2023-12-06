local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local terminal = Global.vars.terminal
local editor_cmd = Global.vars.editor_cmd

local _M = {}
local M = {}

-- Create a launcher widget and a main menu
M.awesome = {
    {"hotkeys", function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
    end}, 
    {"manual", terminal .. " -e man awesome"}, 
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart}, 
    {"quit", function() awesome.quit() end}
}

function _M.get()
    local menu_items = {
        {"awesome", M.awesome, beautiful.awesome_icon}, 
        {"open terminal", terminal}
    }
    
    return menu_items
end

return setmetatable(
    {},
    {__call = function(_, ...) return _M.get(...) end}
)
