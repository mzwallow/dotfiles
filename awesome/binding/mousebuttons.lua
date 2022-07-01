local gears = require("gears")
local awful = require("awful")

local mousebuttons = {}

mousebuttons = gears.table.join(
    awful.button({}, 3, function()
        Global.mainmenu:toggle()
    end), 
    awful.button({}, 4, awful.tag.viewnext), 
    awful.button({}, 5, awful.tag.viewprev)
)

return mousebuttons
