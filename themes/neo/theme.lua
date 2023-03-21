local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local gfs = require("gears.filesystem")
local theme_assets = require("beautiful.theme_assets")
local themes_path = gfs.get_themes_dir()
local config_dir = gfs.get_configuration_dir()
local usr_theme = config_dir .. "/themes/neo/"
local icons_path = gfs.get_configuration_dir() .. "/icons/"

local theme = {}

-- use light backlight controller (for brightness widget)
theme.use_light   = true
-- use percentage values instead of absolute
theme.perc        = true
-- allow separator to be changed dynamically
theme.dynamic_sep = false

theme.font_family = "JetBrains Mono"
theme.font        = theme.font_family .. " 10"

theme.bg_normal = "#1d2021"
theme.bg_focus = "#282828"
theme.bg_subtle = "#212526"
theme.bg_urgent = "#1d2021"
theme.bg_minimize = "#1d2021"
theme.bg_dark = "#191513"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#a0a7a7"
theme.fg_focus = "#bdc0c0"
theme.fg_urgent = "#fdc761"
theme.fg_minimize = "#ad97a199"

theme.border_normal = theme.bg_subtle
theme.border_focus = theme.bg_focus
theme.border_marked = theme.bg_subtle

theme.green = "#7db79d"
theme.yellow = "#d8a657"
theme.red = "#dd87a1"
theme.blue = "#0a5982"

theme.warn = theme.yellow
theme.critical = theme.red

theme.useless_gap   = dpi(27)
theme.border_width  = dpi(0)

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_fg_normal = theme.fg_minimize
theme.menu_fg_focus = "#89b482"
theme.menu_submenu_icon = config_dir .. "submenu.svg"
theme.menu_height = dpi(40)
theme.menu_width = dpi(160)

theme.wallpaper = usr_theme .. "bg"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Launcher icon.
theme.launcher_icon = theme_assets.awesome_icon(
    theme.menu_height,
    theme.bg_normal,
    theme.fg_normal
)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

theme.titlebar_bg_focus = theme.bg_subtle
theme.titlebar_bg_normal = theme.bg_focus

theme.taglist_fg_empty = theme.fg_minimize

theme.slider_active_color = theme.warn
theme.slider_handle_color = theme.fg_normal

theme.control_button_active_bg = theme.green
theme.control_button_active_fg = theme.bg_normal
theme.control_button_normal_bg = theme.bg_normal
theme.control_button_normal_fg = theme.fg_normal

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.start_icon = icons_path .. "menu.svg"
theme.charge_icon = icons_path .. "charge.svg"
theme.notification_icon = icons_path .. "notification.svg"
theme.notification_spacing = 10

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- Define the image to load
theme.titlebar_close_button_normal = config_dir .. "close.svg"
theme.titlebar_close_button_normal_hover = config_dir .. "close.svg"
theme.titlebar_close_button_focus = config_dir .. "close.svg"
theme.titlebar_close_button_focus_hover = config_dir .. "close.svg"

theme.titlebar_minimize_button_normal = config_dir .. "minimize.svg"
theme.titlebar_minimize_button_normal_hover = config_dir .. "minimize.svg"
theme.titlebar_minimize_button_focus = config_dir .. "minimize.svg"
theme.titlebar_minimize_button_focus_hover = config_dir .. "minimize.svg"

theme.titlebar_maximized_button_normal_inactive = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_normal_inactive_hover = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_focus_inactive = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_focus_inactive_hover = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_normal_active = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_normal_active_hover = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_focus_active = config_dir .. "maximized.svg"
theme.titlebar_maximized_button_focus_active_hover = config_dir .. "maximized.svg"

theme.layout_floating = gears.color.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg_normal)
theme.layout_tile = gears.color.recolor_image(themes_path .. "default/layouts/tilew.png", theme.fg_normal)
theme.layout_tileleft = gears.color.recolor_image(themes_path .. "default/layouts/tileleftw.png", theme.fg_normal)
theme.layout_tiletop = gears.color.recolor_image(themes_path .. "default/layouts/tiletopw.png", theme.fg_normal)
theme.layout_tilebottom = gears.color.recolor_image(themes_path .. "default/layouts/tilebottomw.png", theme.fg_normal)
theme.layout_fairv = gears.color.recolor_image(themes_path .. "default/layouts/fairv.png", theme.fg_normal)
theme.layout_cornernw = gears.color.recolor_image(themes_path .. "default/layouts/cornernw.png", theme.fg_normal)
theme.layout_spiral = gears.color.recolor_image(themes_path .. "default/layouts/spiralw.png", theme.fg_normal)
theme.layout_dwindle = gears.color.recolor_image(themes_path .. "default/layouts/dwindle.png", theme.fg_normal)
theme.layout_max = gears.color.recolor_image(themes_path .. "default/layouts/maxw.png", theme.fg_normal)

theme.tag_preview_widget_border_radius = 0
theme.tag_preview_client_border_radius = 0
theme.tag_preview_client_opacity = 0.5
theme.tag_preview_client_bg = theme.bg_normal
theme.tag_preview_client_border_color = theme.bg_subtle
theme.tag_preview_client_border_width = 3
theme.tag_preview_widget_bg = theme.bg_dark
theme.tag_preview_widget_border_color = theme.bg_focus
theme.tag_preview_widget_border_width = 2
theme.tag_preview_widget_margin = 10

theme.task_preview_widget_border_radius = 0
theme.task_preview_widget_bg = theme.bg_dark
theme.task_preview_widget_border_color = theme.bg_focus
theme.task_preview_widget_border_width = 3
theme.task_preview_widget_margin = 15

theme.tabbar_radius = 0
theme.tabbar_style = "default"
theme.tabbar_size = 40
theme.tabbar_position = "top"

theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
