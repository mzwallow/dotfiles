local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gmc = require("themes.gmc")

local home = os.getenv("HOME")

local theme                             = {}
theme.dir                               = home .. "/.config/awesome/themes/zz"
-- theme.wallpaper                         = 

theme.font                              = "Jetbrains Mono 9"
theme.taglist_font                      = "Jetbrains Mono 9"
-- theme.notification_font                 = "Jetbrains Mono 19"
-- theme.notification_max_width            = 400

-- theme.accent
