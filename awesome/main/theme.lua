local gears = require("gears")
local beautiful = require("beautiful")

local home = os.getenv("HOME")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
