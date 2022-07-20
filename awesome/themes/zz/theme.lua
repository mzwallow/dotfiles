local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gmc = require("themes.gmc")

local home = os.getenv("HOME")

local theme                             = {}

theme.dir                               = home .. "/.config/awesome/themes/zz"
-- theme.wallpaper                         = 

theme.font                              = "JetBrains Mono 9"

theme.bg_normal     = "#101519"
theme.bg_focus      = "#223A44"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.dir.."/icons/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.dir.."/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.dir.."/icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme.dir.."/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme.dir.."/icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.dir.."/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.dir.."/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.dir.."/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.dir.."/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.dir.."/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.dir.."/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.dir.."/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.dir.."/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.dir.."/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.dir.."/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.dir.."/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.dir.."/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir.."/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir.."/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.dir.."/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.dir.."/icons/titlebar/maximized_focus_active.png"

theme.wallpaper = theme.dir.."/background.jpg"

-- You can use your own layout icons like this:
theme.layout_floating  = theme.dir.."/icons/layouts/floating.png"
theme.layout_tile = theme.dir.."/icons/layouts/tile.png"
-- theme.layout_tileleft   = theme.dir.."/icons/layouts/tileleft.png"
-- theme.layout_tilebottom = theme.dir.."/icons/layouts/tilebottom.png"
-- theme.layout_tiletop = theme.dir.."/icons/layouts/tiletop.png"
-- theme.layout_fairh = theme.dir.."/icons/layouts/fairh.png"
-- theme.layout_fairv = theme.dir.."/icons/layouts/fairv.png"
-- theme.layout_spiral  = theme.dir.."/icons/layouts/spiral.png"
theme.layout_dwindle = theme.dir.."/icons/layouts/dwindle.png"
-- theme.layout_max = theme.dir.."/icons/layouts/max.png"
-- theme.layout_fullscreen = theme.dir.."/icons/layouts/fullscreen.png"
-- theme.layout_magnifier = theme.dir.."/icons/layouts/magnifier.png"
-- theme.layout_cornernw = theme.dir.."/icons/layouts/cornernw.png"
-- theme.layout_cornerne = theme.dir.."/icons/layouts/cornerne.png"
-- theme.layout_cornersw = theme.dir.."/icons/layouts/cornersw.png"
-- theme.layout_cornerse = theme.dir.."/icons/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
