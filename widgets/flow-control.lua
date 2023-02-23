-- text-control brightness widget

-- Module imports
local awful = require("awful")
local wibox = require("wibox")
local theme = require("themes.noize.theme2")
local style = require("themes.noize.style2")

local margin_horizontal = 3
local margin_vertical = 1
local def_margin = 1 -- fallback if horizontal or vertical are nil

local margin_left = style.widget_margin_left or margin_horizontal or def_margin or 3
local margin_right = style.widget_margin_right or margin_horizontal or def_margin or 3
local margin_top = style.widget_margin_top or margin_vertical or def_margin or 1
local margin_bottom = style.widget_margin_bottom or margin_vertical or def_margin or 1

local opacity = style.widget_opacity or 0.8

local sep = {}

sep.list = {'||', '|', '|~|', '|--|'}
sep.padding = ''
sep.id = 1
sep.color = style.flow_control or "#cccddd" or theme.fg_normal

sep.arator = wibox.widget {
   markup = "",
   align = "center",
   opacity = opacity,
   left = margin_left,
   right = margin_right,
   top = margin_top,
   bottom = margin_bottom,
   widget = wibox.widget.textbox
}

function sep.switch(by)
   if sep.list[sep.id + by] then
      sep.id = sep.id + by
   else
      if sep.id > 1 then
         sep.id = 1
      else
         sep.id = #sep.list
      end
   end

   sep.update()
end

function sep.forward() sep.switch(1) end
function sep.back() sep.switch(-1) end

function sep.key(mod, key, f)
   if not mod then mod = {modkey, "Control", "Shift"} end
   if not key then key = "s" end
   if f then
      return awful.key(mod, key, function() f() end)
   else
      return sep.forward
   end
end

function sep.update()
    sep.arator:set_markup_silently("<span color='" .. sep.color .. "'>" .. sep.padding .. sep.list[sep.id] .. sep.padding .. "</span>")
end

-- mouse click events
sep.arator:buttons(awful.util.table.join(
		awful.button({ }, 1, sep.forward),
		awful.button({ }, 3, sep.back),
		awful.button({ }, 5, sep.back),
		awful.button({ }, 4, sep.forward)
	)
)

-- initialize
sep.update()

return sep
