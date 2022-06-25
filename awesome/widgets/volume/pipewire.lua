local wibox = require("wibox")
local beautiful = require("beautiful")

local shell = require("awful.util").shell

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/widgets/volume/icons/"

local function get_widget(args)
  local args = args or {}

  local widget = wibox.widget {
    image = beautiful.awesome_icon,
    resize = false,
    widget = wibox.widget.imagebox
  }
end
