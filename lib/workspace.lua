local awful = require "awful"
local gears = require "gears"
local beautiful = require "beautiful"
local bling = require "bling"
-- Widget and layout library
local wibox = require "wibox"
local widgets = "widgets."
local ctrl = widgets .. "ctrl."
local kbdlayout = require (widgets .. "kbdlayout")
local battctl = require (ctrl .. "battctl")
local soundctl = require (ctrl .. "soundctl")
local lightctl = require (ctrl .. "lightctl")
local sep = require (ctrl .. "spacer")

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, false)
   end
end

-- Screen names.
names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Each screen has its own tag table.
local l = awful.layout.suit  -- Just to save some typing: use an alias.
local layouts = { bling.layout.mstab, bling.layout.mstab, bling.layout.deck, l.spiral.dwindle, l.spiral.dwindle,
                  l.floating, bling.layout.centered, bling.layout.mstab, bling.layout.equalarea }

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
         else
            c.minimized = true
            c:emit_signal(
               "request::activate",
               "tasklist",
               {raise = true}
            )
         end
   end),
   awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
   end),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
end))

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
         layout = { spacing = 5, layout = wibox.layout.fixed.horizontal },
         buttons = taglist_buttons
      }

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = tasklist_buttons
      }

      -- Create the wibox
      s.mywibox = awful.wibar({
            position = "top",
            screen = s,
			height = 30,
            spacing = 20,
            --[[
            -- {{{ Make it an invisible bar (used for spacing)
			height = 62,
            spacing = 200,
            opacity = 0,
			ontop = false,
            -- }}}
            ]]--
      })

      -- Setup wibox layout and widgets.
      s.mywibox:setup {
            layout = wibox.layout.stack,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            menu_launcher,
            s.mytaglist,
            s.mypromptbox,
         },
            layout = wibox.layout.align.horizontal,
            s.mytasklist,
         { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            align = right,
            {
               layout = wibox.layout.fixed.horizontal,
               align = "center",
               valign = "center",
               spacing = 20,
               spacing_widget = sep.arator,
               kbdlayout,
               lightctl.widget,
               soundctl.widget,
               battctl.widget,
               wibox.widget.systray(),
            },
            mytextclock,
            s.mylayoutbox,
         },
      }
end)
-- }}}
