-- {{{ Required libraries
-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Wibox handling library
local wibox = require("wibox")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB = wibox_package

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local function add_widgets_left(s)
    return { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        RC.launcher,
        s.taglist,
        wibox.widget.textbox(" | "),
        s.promptbox
    }
end

local function add_widgets_middle(s)
    return s.tasklist -- Middle widget
end

local function add_widgets_right(s)
    return { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        mykeyboardlayout,
        wibox.widget.systray(),
        mytextclock,
        s.layoutbox
    }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.generate_wibox_one(s)
    -- layout: l_left, tasklist, l_right

    -- Create the wibox
    s.wibox_top = awful.wibar({
        screen = s,
        position = "top",
        height = dpi(30)
    })

    -- Add widgets to the wibox
    s.wibox_top:setup{
        layout = wibox.layout.align.horizontal,
        add_widgets_left(s),
        add_widgets_middle(s),
        add_widgets_right(s)
    }
end
