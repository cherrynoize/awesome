-- widget-control widget creator

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local style = require("themes.noize.style2")

-- Configuration
local widget = {}

widget.width         = style.width or 40        -- width in pixels of bar
widget.margin_right  = style.margin_right or 0         -- right margin in pixels of bar
widget.margin_left   = style.margin_left or 0         -- left margin in pixels of bar
widget.margin_top    = style.margin_top or 0         -- top margin in pixels of bar
widget.margin_bottom = style.margin_bottom or 0         -- bottom margin in pixels of bar
widget.step          = (style.step/100) or 0.05      -- change stepsize (ranges from 0 to 1)
widget.color         = style.color or '#698f1e'
widget.color_bg      = style.color_bg or '#33450f'
widget.text_color    = style.text_color or '#ffffff'
widget.text_color_off= style.text_color_off or '#ff0000'
widget.color_off     = style.color_off or '#be2a15'
widget.color_bg_off  = style.color_bg_off or '#532a15'
widget.color_low     = style.color_semi or color_crit
widget.color_bg_low  = style.color_bg_semi or color_bg_crit
widget.color_discharging    = style.color_discharging or style.color_empty or style.text_color or style.color
widget.color_bg_discharging = style.color_bg_discharging or style.color_bg_empty or style.color_bg
widget.color_border  = style.color_border or '#00ab00' -- border color
widget.border_width  = style.border_width or 1 -- border width
widget.mixer_gui     = style.mixer_gui or 'alsamixergui' -- mixer command
widget.text_hide     = style.text_hide or false     -- show percentages on bar
widget.uber_level    = style.uber_level or '150' -- overmax level
widget.text_mode     = style.widget_text_mode or true -- toggle visual progress bar

widget.bar = {
    max_value     = 1,
    value         = 0.5,
    forced_height = 20,
    forced_width  = width,
	step          = step,
    paddings      = 1,
    border_width  = border_width,
    border_color  = color_border,
    paddings         = {top = 1, bottom = 1,},
    margins          = {top = 1, bottom = 1,},
	shape         = gears.shape['powerline'],
	bar_shape     = gears.shape['rounded_bar'],
    widget        = wibox.widget.progressbar,
}

widget.text = {
    text   = '',
	align  = 'center',
    widget = wibox.widget.textbox
}

return widget
