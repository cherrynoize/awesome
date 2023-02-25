local awful = require "awful"
local wibox = require "wibox"
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                         -- buttons for the titlebar
                         local buttons = {
                            awful.button({}, 1, function()
                                  c:activate { context = "titlebar", action = "mouse_move" }
                            end),
                            awful.button({ "Shift" }, 1, function()
                                  c:activate { context = "titlebar", action = "mouse_resize" }
                            end),
                            awful.button({}, 3, function()
                                  c:activate { context = "titlebar", action = "mouse_resize" }
                            end),
                         }

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
-- imagine (not) using titlebars for tiled windows
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
