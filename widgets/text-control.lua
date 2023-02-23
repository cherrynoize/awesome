-- text-control brightness widget

-- Module imports
local awful = require("awful")
local wibox = require("wibox")
local style = require("themes.noize.style2")

local margin_left = style.widget_margin_left or 0
local margin_right = style.widget_margin_right or 0
local margin_top = style.widget_margin_top or 0
local margin_bottom = style.widget_margin_bottom or 0

local text = {}

text.id = 0
text.history = {}
text.placeholder = ""
text.msg = ""
text.color = style.text_control or style.color_off or "#ff6565"

text.widget = wibox.widget {
   markup = text.msg,
   align = "center",
   widget = wibox.widget.textbox
}

text.prompt = wibox.widget {
   markup = "",
   widget = wibox.widget.textbox
}

text.box = wibox.container.margin(text.widget,
                                       margin_right, margin_left,
                                       margin_top, margin_bottom)

function text.update(txt_msg)
    if txt_msg then text.msg = txt_msg end
    text.widget:set_markup_silently("<span color='" .. text.color .. "'>" .. text.msg .. "</span>")
end

function text.toggle()
   if text.hidden then
      text.update(text.hidden)
      text.hidden = nil
   else
      text.hidden = text.msg
      text.update("")
   end
end

function text.back()
   if text.id > 0 then
      text.history[text.id] = text.msg
      text.id = text.id - 1
      text.update(text.history[text.id])
   end
end

function text.forward()
   if text.history[text.id+1] then
      text.id = text.id + 1
      text.update(text.history[text.id])
   end
end

function text.replace()
   awful.prompt.run {
      prompt       = '<b>' .. text.msg .. ': </b>',
      text         = text.placeholder,
      bg_cursor    = text.color,
      textbox      = text.prompt,
      exe_callback = function(input)
         if not input or input == text.placeholder then return end
         text.history[text.id] = text.msg
         text.id = text.id + 1
         text.update(input)
      end
   }

   text.update()
end

function text.key(mod, key)
   if not mod then mod = {modkey, "Control", "Shift"} end
   if not key then key = "h" end
   return awful.key(mod, key, text.toggle)
end

-- mouse click events
text.widget:buttons(awful.util.table.join(
		awful.button({ }, 1, text.toggle),
		awful.button({ }, 3, text.replace),
		awful.button({ }, 5, text.back),
		awful.button({ }, 4, text.forward)
	)
)

-- initialize
text.update()

return text
