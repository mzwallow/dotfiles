local awful = require("awful")

local _M = {}

function _M.get()
    local tags = {}

    local tag_pairs = {
        names = {
            "1", "2", "3",
            "4", "5", "6",
            -- "7", "8", "9"
        },
        
        layouts = {
            Global.layouts[9], Global.layouts[9], Global.layouts[9],
            Global.layouts[9], Global.layouts[9], Global.layouts[9],
            -- Global.layouts[9], Global.layouts[9], Global.layouts[9]
        }
    }

    awful.screen.connect_for_each_screen(function (s)
        -- Each screen has its own tag table.
        tags[s] = awful.tag(tag_pairs.names, s, tag_pairs.layouts)
    end)

    return tags
end

return setmetatable(
    {},
    {__call = function(_, ...) return _M.get(...) end}
)
