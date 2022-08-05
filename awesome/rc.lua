-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
local menubar = require("menubar")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Global namespace
Global = {}
-- Variable definitions
Global.vars = require("main.user-variables")

-- Error handling
require("main.error-handling")

-- Themes
require("main.theme")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local main = {
    layouts = require("main.layouts"),
    menu    = require("main.menu"),
    tags    = require("main.tags"),
    rules   = require("main.rules")
}

local binding = {
    globalkeys      = require("binding.globalkeys"),
    mousebuttons    = require("binding.mousebuttons"),
    clientbuttons   = require("binding.clientbuttons"),
    clientkeys      = require("binding.clientkeys"),
    bindtotags      = require("binding.bindtotags")
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Layouts
Global.layouts = main.layouts()

-- Tags
Global.tags = main.tags()

-- {{{ Menu
Global.mainmenu = awful.menu({ items = main.menu() })
Global.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = Global.mainmenu
})

-- Menubar configuration
menubar.utils.terminal = Global.vars.terminal -- Set the terminal for applications that require it
-- }}}

-- Mouse bindings
root.buttons(binding.mousebuttons())

-- {{{ Key bindings
Global.globalkeys = binding.globalkeys()
Global.globalkeys = binding.bindtotags(Global.globalkeys)

-- Set keys
root.keys(Global.globalkeys)
-- }}}

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = main.rules(
    binding.clientkeys(),
    binding.clientbuttons()
)

-- Signals
require("main.signals")

-- Statusbar: Wibar
local statusbar = require("statusbar.default.statusbar")
statusbar()

awful.util.spawn("/bin/nm-applet")
awful.util.spawn("/usr/bin/optimus-manager-qt")
