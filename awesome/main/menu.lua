-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon

local M = {} -- menu
local _M = {} -- module

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html

local terminal = RC.vars.terminal
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Create a main menu
M.awesome = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

M.favorite = {
    { "thunar", "thunar" },
    { "firefox", "firefox" },
    { "thunderbird", "thunderbird" },
    { "libreoffice", "libreoffice" },
    { "gimp", "gimp" },
    { "inkscape", "inkscape" },
    { "screenshooter", "xfce4-screenshooter" },
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()

    -- Main Menu
    local menu_items = {
        {"awesome", M.awesome, beautiful.awesome_subicon}, 
        {"open terminal", terminal},
        {"favorite", M.favorite}
    }

    return menu_items
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
    __call = function(_, ...)
        return _M.get(...)
    end
})
