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

-- {{{ Error handling
require("main.error-handling")
-- }}}

-- {{{ Variable definitions
Global.vars = require("main.user-variables")
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

Global.layouts = require("main.layouts")
Global.tags = require("main.tags")
-- }}}

-- {{{ Menu
local menu_items = require("main.menu")
Global.mainmenu = awful.menu({ items = menu_items })

Global.launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = Global.mainmenu
})

-- Menubar configuration
menubar.utils.terminal = Global.vars.terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar: Status Bar
require("deco.statusbar")
-- }}}

-- {{{ Mouse bindings
Global.mousebuttons = require("binding.mousebuttons")
root.buttons(Global.mousebuttons)
-- }}}

-- {{{ Key bindings
Global.globalkeys = require("binding.globalkeys")
Global.globalkeys = require("binding.bindtotags").bind(Global.globalkeys)

Global.clientkeys = require("binding.clientkeys")
Global.clientbuttons = require("binding.clientbuttons")

-- Set keys
root.keys(Global.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = require("main.rules").set(Global.clientkeys, Global.clientbuttons)
-- }}}

-- {{{ Signals
require("main.signals")
-- }}}
