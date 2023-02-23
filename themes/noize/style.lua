-- widget configuration style
local beautiful = require("beautiful")
local style = {}
style.theme = "themes/noize/theme2"
local theme = require(style.theme)

-- Configuration
style.width         = 40        -- width in pixels of bar
style.margin_right  = 5         -- right margin in pixels of bar
style.margin_left   = 5         -- left margin in pixels of bar
style.margin_top    = 0         -- top margin in pixels of bar
style.margin_bottom = 0         -- bottom margin in pixels of bar
style.step          = 5         -- change percent stepsize
style.color         = theme.widget_color or theme.tasklist_bg_focus or "#698f1e" -- foreground color
style.color_bg      = theme.widget_bg_color or theme.tasklist_bg_normal or "#33450f" -- background color
style.color_off     = theme.widget_color_off or '#ff0000'
style.color_bg_off  = theme.widget_bg_color_off or "#532a15"
style.color_semi    = theme.widget_color_semi or "#cd4c15"
style.color_bg_semi = theme.widget_bg_color_semi or "#de7c15"
style.color_empty   = theme.widget_empty or theme.tasklist_bg_focus
style.color_bg_empty= theme.widget_bg_empty or theme.tasklist_fg_focus
style.color_border  = theme.tasklist_bg_normal_shadow or "#00ab00" -- border color
style.border_width  = 0
style.text_hide     = false
style.text_color    = theme.fg_normal or '#ffffff'
style.text_color_off= style.color_off or '#ff0000'
style.uber          = '150' -- overmax level

style.mixer_gui     = 'alsamixergui' -- audio mixer command
style.backlight     = '/sys/class/backlight/intel_backlight/' -- backlight path
style.cur_fuzz      = 'brightness'
style.max_fuzz      = 'max_brightness'

-- Beautiful theme override
style.color = beautiful.apw_fg_color or style.color
style.color_bg = beautiful.apw_bg_color or style.color_bg
style.color_off = beautiful.apw_mute_fg_color or style.color_off
style.color_bg_off = beautiful.apw_mute_bg_color or style.color_bg_off
style.color_border = beautiful.border_color or style.color_border
style.show_text = beautiful.apw_show_text or style.show_text
style.text_color = beautiful.apw_text_color or style.text_color

return style
