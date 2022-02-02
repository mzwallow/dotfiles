local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/zz/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- default variables

theme = {}

dofile(theme_path .. "elements.lua")
dofile(theme_path .. "titlebar.lua")
dofile(theme_path .. "layouts.lua")
dofile(theme_path .. "icons.lua")

theme.wallpaper          = theme_path .. "wallpaper.png"
theme.awesome_icon       = theme_path .. "launcher/arch.png"
theme.awesome_subicon    = theme_path .. "launcher/arch.png"

return theme
