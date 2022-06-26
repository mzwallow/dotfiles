local gmc = require("themes.zz.gmc")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Font
theme.font          = "JetBrains Mono 10" -- "Terminus 8" -- "Tamsyn 10" -- "Sans 8"
theme.taglist_font  = "JetBrains Mono 10" -- "Inconsolata Medium 9"
-- }}}

-- {{{ Gap
theme.useless_gap   = dpi(5)
-- }}}

-- {{{ Border
theme.border_width  = dpi(0)

theme.border_normal = gmc.color['gray900']
theme.border_focus  = gmc.color['redA700']
theme.border_marked = gmc.color['redA700']
-- }}}

-- {{{ Tag List
theme.bg_normal     = gmc.color['gray900']
theme.bg_focus      = gmc.color['red900dark']
theme.bg_urgent     = gmc.color['redA400']
theme.bg_minimize   = gmc.color['gray300'] 
theme.bg_systray    = gmc.color['gray300'] 

theme.fg_normal     = gmc.color['red900dark']
theme.fg_focus      = gmc.color['redA700']
theme.fg_urgent     = gmc.color['red900dark']
theme.fg_minimize   = gmc.color['redA700']

theme.taglist_bg_focus = gmc.color['red900dark']
theme.taglist_fg_focus = gmc.color['redA700']
-- theme.taglist_bg_focus = "png:" .. theme_path .. "misc/copycat-holo/taglist_bg_focus.png"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--    taglist_square_size, gmc.color['black']
--)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, gmc.color['white']
--)
-- Alternative
theme.taglist_squares_sel      = theme_path .. "taglist/zz/square_sel.png"
theme.taglist_squares_unsel    = theme_path .. "taglist/zz/square_unsel.png"
-- }}}

-- {{{ Task List
theme.tasklist_bg_normal = gmc.color['gray900']
theme.tasklist_bg_focus  = gmc.color['redA700']
theme.tasklist_fg_focus  = gmc.color['white']
-- Alternative
-- theme.tasklist_bg_normal = "png:" .. theme_path .. "misc/copycat-holo/bg_focus.png"
-- theme.tasklist_bg_focus  = "png:" .. theme_path .. "misc/copycat-holo/bg_focus_noline.png"
-- }}}

-- {{{ Menu
theme.menu_submenu_icon  = theme_path .. "misc/zz/submenu.png"

theme.menu_height = dpi(20)      -- dpi(15)
theme.menu_width  = dpi(180)     -- dpi(100)
--theme.menu_context_height = 20

theme.menu_bg_normal = gmc.color['gray900']
theme.menu_bg_focus  = gmc.color['redA700']
theme.menu_fg_focus  = gmc.color['white']

theme.menu_border_color = gmc.color['gray900']
theme.menu_border_width = 1
-- }}}

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"