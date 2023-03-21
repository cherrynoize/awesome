local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                         -- Set the windows at the slave,
                         -- i.e. put it at the end of others instead of setting it master.
                         if not awesome.startup then awful.client.setslave(c) end

                         if awesome.startup
                            and not c.size_hints.user_position
                            and not c.size_hints.program_position then
                            -- Prevent clients from being unreachable after screen count changes.
                            awful.placement.no_offscreen(c)
                         end

                         --[[
                            c.shape = function(cr,w,h) -- client shape
                            gears.shape.rounded_rect(cr,w,h,10)
                            end
                         --]]
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                         -- buttons for the titlebar
                         local buttons = gears.table.join(
                            awful.button({ }, 1, function()
                                  c:emit_signal("request::activate", "titlebar", {raise = true})
                                  awful.mouse.client.move(c)
                            end),
                            awful.button({ }, 3, function()
                                  c:emit_signal("request::activate", "titlebar", {raise = true})
                                  awful.mouse.client.resize(c)
                            end)
                         )

                         awful.titlebar(c, {
                                           size = 40,
                                           position = "top",
                         }):setup {
                            {
                               { -- Start
                                  awful.titlebar.widget.closebutton(c),
                                  spacing = 15,
                                  layout = wibox.layout.align.horizontal,
                               },
                               { -- Middle
                                  { -- Title
                                     align  = "center",
                                     widget = awful.titlebar.widget.titlewidget(c)
                                  },
                                  buttons = buttons,
                                  layout  = wibox.layout.flex.horizontal
                               },
                               { -- End
                                  awful.titlebar.widget.minimizebutton(c),
                                  awful.titlebar.widget.maximizedbutton(c),
                                  spacing = 15,
                                  layout = wibox.layout.flex.horizontal,
                               },
                               layout = wibox.layout.align.horizontal,
                            },
                            top = 10,
                            bottom = 10,
                            left = 13,
                            right = 13,
                            widget = wibox.container.margin,
                                  }
end)

--[[
-- Hide titlebar for tiled windows.
screen.connect_signal("arrange", function(s)
                         local layout = s.selected_tag.layout.name
                         for _, c in pairs(s.clients) do
                            if layout == "floating" or c.floating then
                               awful.titlebar.show(c)
                            else
                               awful.titlebar.hide(c)
                            end
                         end
end)
]]--

-- Enable sloppy focus, so that focus follows mouse.
--[[
   client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
   end)
]]--

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
