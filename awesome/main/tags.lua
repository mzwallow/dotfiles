-- Standard awesome library
local awful = require("awful")

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/icons"

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local tags = {}

  local tagpairs = {
    names = {
      -- "main", "www", "dev", 
      -- "四", "五", "六", 
      -- "七", "八", "九"
      "1", "2", "3",
      "4", "5", "6",
      "7", "8", "9",
    },

    layout = {
      RC.layouts[1], RC.layouts[9], RC.layouts[9],
      RC.layouts[9], RC.layouts[9], RC.layouts[9],
      RC.layouts[9], RC.layouts[9], RC.layouts[9]
    }
  }

  local tag_main = awful.tag.add("main", {
    -- icon = ICON_DIR .. "volume"
  })

  

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tagpairs.names, s, tagpairs.layout)
  end)

  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
  __call = function(_, ...)
    return _M.get(...)
  end
})
