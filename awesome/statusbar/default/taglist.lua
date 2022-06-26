-- {{{ Required libraries
-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Wibox handling library
local wibox = require("wibox")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB = wibox_package

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local function add_widgets_left(s)
  return {
    layout = wibox.layout.fixed.horizontal,
    s.taglist
  }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.generate_wibox_taglist(s)
  -- Create the wibox
  s.wibox_two = awful.wibar({
    screen = s,
    position = "bottom",
    height = dpi("30"),
    width = dpi("500")
  })

  -- Add widgets to the wibox
  s.wibox_two:setup {
    layout = wibox.layout.align.horizontal,
    add_widgets_left(s)
  }
end
