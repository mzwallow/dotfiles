--[[
     Original Source Modified From: github.com/copycat-killer
     https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.multicolor
--]]

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Standard awesome library
local awful     = require("awful")
local beautiful = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")
local lain = require("lain")

-- Resource Configuration
local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

-- Custom Local Library
local gmc = require("themes.zz.gmc")

local dpi = require("beautiful.xresources").apply_dpi

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local W = {}
clone_widget_set = W           -- object name

local I = {}
clone_icon_set = I             -- object name

-- split module, to make each file shorter,
-- all must have same package name

-- global for all splited
markup      = lain.util.markup

-- progress bar related widgets -- after global markup
local config_path = awful.util.getdir("config") .. "statusbar/lain/"
--dofile(config_path .. "lain-diskfree.lua")
--dofile(config_path .. "lain-battery.lua")
--dofile(config_path .. "lain-sound.lua")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Textclock
I.clock = wibox.widget {
  {
    stylesheet = "" .. string.format("path { fill: %s; }", gmc.color['gray900']),
    image  = beautiful.widget_clock,
    valign = "center",
    halign = "center",
    widget = wibox.widget.imagebox
  },
  bg       = "#ba4928", -- gmc.color['red900dark'],
  widget = wibox.container.background
}
W.clock = wibox.widget {
  {
    widget = wibox.widget.textclock(markup(gmc.color['gray900'], " %H:%M"))
  },
  bg       = "#ba4928", -- gmc.color['red900dark'],
  widget = wibox.container.background
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MEM
I.mem = wibox.widget {
  image = beautiful.widget_mem,
  forced_height = dpi(20),
  forced_width  = dpi(20),
  valign = "center",
  halign = "center",
  widget = wibox.widget.imagebox
}
W.mem = lain.widget.mem {
  settings = function()
    widget:set_markup(markup(gmc.color['red900dark'], mem_now.used .. "MB "))
  end
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- VOL
I.vol = wibox.widget {
  image = beautiful.widget_vol,
  forced_height   = dpi(20),
  forced_width    = dpi(20),
  valign = "center",
  halign = "center",
  widget = wibox.widget.imagebox
}
W.vol = lain.widget.alsa({
  settings = function()
    if volume_now.status == "off" then
      I.vol:set_image(beautiful.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      I.vol:set_image(beautiful.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      I.vol:set_image(beautiful.widget_vol_low)
    else
      I.vol:set_image(beautiful.widget_vol)
    end

    widget:set_markup(markup(gmc.color['red900dark'], volume_now.level .. "% "))
  end
})
-- ALSA volume control
W.vol.widget:buttons(awful.util.table.join(
  awful.button({}, 1, function() -- left click
    awful.spawn("pavucontrol")
  end),
  awful.button({}, 2, function() -- middle click
    os.execute(string.format("%s set %s 100%%", W.vol.cmd, W.vol.channel))
    W.vol.update()
  end),
  awful.button({}, 3, function() -- right click
    os.execute(string.format("%s set %s toggle", W.vol.cmd, W.vol.togglechannel or W.vol.channel))
    W.vol.update()
  end),
  awful.button({}, 4, function() -- scroll up
    os.execute(string.format("%s set %s 1%%+", W.vol.cmd, W.vol.channel))
    W.vol.update()
  end),
  awful.button({}, 5, function() -- scroll down
    os.execute(string.format("%s set %s 1%%-", W.vol.cmd, W.vol.channel))
    W.vol.update()
  end)
))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- VOL_PULSE
I.vol_pulse = wibox.widget {
  image = beautiful.widget_vol,
  scaling_quality = "best",
  forced_height   = dpi(20),
  forced_width    = dpi(20),
  valign = "center",
  halign = "center",
  widget = wibox.widget.imagebox
}
W.vol_pulse = lain.widget.pulse({
  settings = function()
    vlevel = volume_now.left .. "-" .. volume_now.right .. "% | " .. volume_now.device
    -- if volume_now.status == "off" then
    --   I.vol_pulse:set_image(beautiful.widget_vol_mute)
    -- elseif tonumber(volume_now.level) == 0 then
    --   I.vol_pulse:set_image(beautiful.widget_vol_no)
    -- elseif tonumber(volume_now.level) <= 50 then
    --   I.vol_pulse:set_image(beautiful.widget_vol_low)
    -- else
    --   I.vol_pulse:set_image(beautiful.widget_vol)
    -- end

    widget:set_markup(markup(gmc.color['red900dark'], vlevel .. "% "))
  end
})
-- PulseAudio volume control
W.vol_pulse.widget:buttons(awful.util.table.join(
  awful.button({}, 1, function() -- left click
    awful.spawn("pavucontrol")
  end),
  awful.button({}, 2, function() -- middle click
    os.execute(string.format("pactl set-sink-volume %s 100%%", W.vol_pulse.device))
    W.vol_pulse.update()
  end),
  awful.button({}, 3, function() -- right click
    os.execute(string.format("pactl set-sink-mute %s toggle", W.vol_pulse.device))
    W.vol_pulse.update()
  end),
  awful.button({}, 4, function() -- scroll up
    os.execute(string.format("pactl set-sink-volume %s +1%%", W.vol_pulse.device))
    W.vol_pulse.update()
  end),
  awful.button({}, 5, function() -- scroll down
    os.execute(string.format("pactl set-sink-volume %s -1%%", W.vol_pulse.device))
    W.vol_pulse.update()
  end)
))

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- KEY_LAYOUT
W.key_layout = awful.widget.keyboardlayout()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --