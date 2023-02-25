local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
-- Widget and layout library
local widgets = "widgets/"
local wibox = require "wibox"
local noize = require(widgets .. "noize-control")
local fuzz = require(widgets .. "fuzz-control")
local battery = require(widgets .. "batt-control")
local sep = require(widgets .. "flow-control")
require "conf.wibar"

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Screen names.
names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Each screen has its own tag table.
local l = awful.layout.suit  -- Just to save some typing: use an alias.
local layouts = { l.tile.right, l.tile.right, l.tile.bottom, l.corner.se, l.corner.nw,
                  l.max, l.corner.ne, l.corner.ne, l.tile.right }

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Create screen tags
      awful.tag(names, s, layouts)

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
      -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))

      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist {
         screen  = s,
         filter  = awful.widget.taglist.filter.all,
         buttons = taglist_buttons
      }

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = tasklist_buttons
      }

      -- Create the wibox
      s.mywibox = awful.wibar({ position = "top", screen = s })

      -- Add widgets to the wibox
      s.mywibox:setup {
         opacity = 0.8,
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
         },
--         { -- Middle widgets
            layout = wibox.layout.align.horizontal,
            s.mytasklist,
--            ntext.box,
--         },
         { -- Right widgets
            align = right,
            layout = wibox.layout.fixed.horizontal,
            {
               align = "center",
               valign = "center",
               spacing = 20,
               spacing_widget = sep.arator,
               layout = wibox.layout.fixed.horizontal,
               mykeyboardlayout,
               fuzz.widget,
               noize.widget,
               battery.widget,
               wibox.widget.systray(),
            },
            mytextclock,
            s.mylayoutbox,
         },
      }
end)
-- }}}
