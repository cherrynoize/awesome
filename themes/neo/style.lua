-- widget configuration style
local beautiful = require("beautiful")

local style = {}

-- Configuration
style.use_light     = true      -- use `light` instead of default io

-- General
style.width         = 40        -- width in pixels of bar
style.margin_right  = 5         -- right margin in pixels of bar
style.margin_left   = 5         -- left margin in pixels of bar
style.margin_top    = 0         -- top margin in pixels of bar
style.margin_bottom = 0         -- bottom margin in pixels of bar
style.step          = 2         -- change percent stepsize
style.prec          = nil       -- floating point precision (nil for default)
style.perc          = false     -- convert to percentages
style.color         = "#698f1e" -- foreground color
style.color_bg      = "#33450f" -- background color
style.color_off     = "#ff6565"
style.color_bg_off  = "#532a15"
style.color_semi    = "#cd4c15"
style.color_bg_semi = "#de7c15"
style.color_border  = "#00ab00" -- border color
style.border_width  = 0
style.text_hide     = false
style.text_color    = "#719f9f"
style.text_color_off= style.color_off or '#ff0000'
style.uber          = '150' -- overmax level

style.mixer_gui     = 'alsamixergui' -- audio mixer command
style.backlight     = nil -- backlight path
style.cur_fuzz      = nil
style.max_fuzz      = nil

-- Beautiful theme override
style.color = beautiful.apw_fg_color or style.color
style.color_bg = beautiful.apw_bg_color or style.color_bg
style.color_off = beautiful.apw_mute_fg_color or style.color_off
style.color_bg_off = beautiful.apw_mute_bg_color or style.color_bg_off
style.color_border = beautiful.border_color or style.color_border
style.show_text = beautiful.apw_show_text or style.show_text
style.text_color = beautiful.apw_text_color or style.text_color

return style
