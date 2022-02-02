-- {{{ Required libraries
-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Wibox handling library
local wibox = require("wibox")
local lain  = require("lain")

-- Custom Local Library
require("statusbar.lain.lain")
local gmc = require("themes.zz.gmc")
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WB = wibox_package

function WB.initdeco ()
    -- Spacer
    WB.spacer = wibox.widget.textbox(" ")
    WB.spacerline = wibox.widget.textbox(" | ")

    -- Separators lain
    local separators  = lain.util.separators
    local arrow_color = gmc.color['red300']
    WB.arrow_dl = separators.arrow_left("alpha", arrow_color)
    WB.arrow_ld = separators.arrow_left(arrow_color, "alpha")
    WB.arrow_dr = separators.arrow_right("alpha", arrow_color)
    WB.arrow_rd = separators.arrow_right(arrow_color, "alpha")
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.add_widgets_main (s)
  return {
    layout = wibox.layout.fixed.horizontal,
--    RC.launcher,
--    s.taglist,
    WB.ar_lr_pre,
    s.promptbox,
    WB.ar_lr_post
  }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.add_widgets_monitor_left (s)
  local cws = clone_widget_set
  local cis = clone_icon_set

  return {
    layout = wibox.layout.fixed.horizontal,
    WB.spacer,
    s.taglist,
    wibox.widget.textbox(" | "),
    s.promptbox,

    -- at last   , you can ignore this line below
    WB.spacer,
  }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.add_widgets_monitor_right (s)
  local cws = clone_widget_set
  local cis = clone_icon_set

  return {
    layout = wibox.layout.fixed.horizontal,

    -- vol_pulse
    cis.vol_pulse,      cws.vol_pulse,
    -- vol
    cis.vol,      cws.vol,
    -- mem
    cis.mem,      cws.mem,
    -- time
    cws.clock,    cis.clock,
  }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function WB.generate_wibox_two (s)
  -- layout: l_left, l_mid, tasklist

  -- Create the wibox
  s.wibox_two = awful.wibar({ 
    position = "top", 
    screen = s, 
    height = dpi(10),
    bg = "#00000000",
    fg = "#00000000",
    opacity = 0.0
  })

  -- Create REAL the wibox
  s.wibox_two = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(25), 
    width = dpi(1259), -- 1900
    -- bg = "#00000000",
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    opacity = 1.0,
  })

  -- Add widgets to the wibox
  s.wibox_two:setup {
    layout = wibox.layout.align.horizontal,
    WB.add_widgets_monitor_left (s),
    WB.spacer,
    WB.add_widgets_monitor_right (s)
  }
end
