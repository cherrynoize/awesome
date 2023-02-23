-- noize-control volume widget

-- Module imports
local awful = require("awful")
local spawn_with_shell = awful.util.spawn_with_shell or awful.spawn.with_shell
local wibox = require("wibox")
local naughty = require("naughty")
local gears = require("gears")
local math = require("math")
local utils = require("widgets.utils")
local style = require("themes.noize.style2")
local widget = require("widgets.widget-control")

local volume = {}

-- define bar
if widget.text_mode then
    widget.wibox = wibox.widget(widget.text)
    widget.wibox.layout = wibox.layout.stack
else
    widget.wibox = wibox.widget:new() {
       widget.bar,
       widget.text,
       layout = wibox.layout.stack
    }
end

-- define widget
volume.widget = wibox.container.margin((widget.wibox),
                                       margin_right, margin_left,
                                       margin_top, margin_bottom)


function volume.strip(lvl)
	local lvl = string.gsub(lvl,"%%","")
	lvl = string.gsub(lvl,"dB","")
	return tonumber(lvl)
end

function volume.level()
	return utils.capture("amixer sget Master | grep -oP '(?<=\\[).*?(?=\\])' | grep -F -e '%' -e 'dB' -m1")
end

function volume.is_mute()
	if utils.capture("amixer sget Master | awk '/off/ { print $6 }' | grep -e '' -m1") == "[off]" then
		return true
	else
		return false
	end
end

function volume.text_update()
	local wdg = volume.widget:get_all_children()
    local color = widget.text_color

	if volume.is_mute() then
		color = widget.text_color_off or color
	end

    wdg[1]:set_markup_silently('<span color="' .. color .. '">' .. volume.level() .. '</span>')
end

function volume.bar_update()
	local wdg = volume.widget:get_all_children()

	wdg[1]:set_value(volume.strip(volume.level())/100)

	if volume.is_mute() then
		wdg[1]:set_color(color_mute)
		wdg[1]:set_background_color(widget.color_bg_mute)
	else
		wdg[1]:set_color(color)
		wdg[1]:set_background_color(widget.color_bg)
	end

    if not widget.text_hide then
        wdg[2]:set_markup_silently('<span color="' .. widget.text_color .. '">' .. volume.level() .. '</span>')
    end
end

function volume.update()
    if widget.text_mode then
        volume.text_update()
    else
        volume.bar_update()
    end
end

function volume.mixer()
	spawn_with_shell(widget.mixer_gui)
end

function volume.up()
	os.execute("amixer sset Master " .. widget.step * 100 .. "%+")
	volume.update()
end

function volume.down()
	os.execute("amixer sset Master " .. widget.step * 100 .. "%-")
	volume.update()
end

function volume.min()
	os.execute("amixer sset Master 0%")
	volume.update()
end

function volume.half()
	os.execute("amixer sset Master 50%")
	volume.update()
end

function volume.max()
	os.execute("amixer sset Master 100%")
	volume.update()
end

function volume.overmax()
	os.execute("amixer sset Master " .. widget.uber_level .. "%")
	volume.update()
end

function volume.togglemute()
	if volume.is_mute() then
		os.execute("amixer sset Master unmute")
	else
		os.execute("amixer sset Master mute")
	end

	volume.update()
end

-- mouse click events
volume.widget:buttons(awful.util.table.join(
		awful.button({ }, 1, volume.togglemute),
		awful.button({ }, 3, volume.mixer),
		awful.button({ }, 5, volume.up),
		awful.button({ }, 4, volume.down)
	)
)

-- initialize
volume.update()

return volume
