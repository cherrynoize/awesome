-- noize-control battery widget
-- Module imports
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local math = require("math")
local utils = require("widgets.utils")
local style = require("themes.noize.style2")
local widget = require("widgets.widget-control")
local spawn_with_shell = awful.util.spawn_with_shell or awful.spawn.with_shell

local battery = {}

battery.path = "/sys/class/power_supply/BAT1/"
battery.low_level = 18
battery.crit_level = 9
battery.alert = 0

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
battery.widget = wibox.container.margin((widget.wibox),
                                       margin_right, margin_left,
                                       margin_top, margin_bottom)

-- reads battery charge | when: now, full or full_design
function battery.charge(when)
	return utils.read(battery.path .. "charge_" .. when)
end

-- returns battery level as percentage number
function battery.level()
    return math.floor(utils.percent(battery.charge("now"), battery.charge("full")))
end

-- returns battery condition (charging, low or critical)
function battery.is(state)
    if state == "charging" then
        local status = utils.read(battery.path .. "status"):gsub("%s+", "")
        return status == "Charging" or status == "Full"
    elseif state == "critical" then
        return battery.level() <= battery.crit_level
    elseif state == "low" then
        return battery.level() <= battery.low_level
    end
end

-- widget update
function battery.text_update()
	local wdg = battery.widget:get_all_children()
    local color = widget.color_discharging

	if battery.is("charging") then
        battery.alert = 0
		color = widget.color
	elseif battery.is("crit") and battery.alert ~= 2 then
        battery.alert = 2
		color = widget.color_off
        naughty.notify({title = "Critical battery. Plug in your device."})
	elseif battery.is("low") and battery.alert ~= 1 then
        battery.alert = 1
		color = widget.color_low
        naughty.notify({title = "Low battery. You may want to plug in your device."})
	end

    if battery.is("charging") then
        battery.text_msg = '**' .. battery.level() .. '**'
    else
        battery.text_msg = battery.level() .. '%'
    end

    if not text_hide then
        wdg[1]:set_markup_silently('<span color="' .. color .. '">' .. battery.text_msg .. '</span>')
    end
end

function battery.bar_update()
	local wdg = battery.widget:get_all_children()

	wdg[1]:set_value(battery.level() / 100)

	if battery.is("charging") then
		wdg[1]:set_color(widget.color)
		wdg[1]:set_background_color(widget.color_bg)
	elseif battery.is("crit") then
		wdg[1]:set_color(widget.color_off)
		wdg[1]:set_background_color(widget.color_bg_off)
	elseif battery.is("low") then
		wdg[1]:set_color(widget.color_low)
		wdg[1]:set_background_color(widget.color_bg_low)
	else
		wdg[1]:set_color(widget.color_discharging)
		wdg[1]:set_background_color(widget.color_bg_discharging)
	end

    if battery.is("charging") then
        battery.text_msg = '**' .. battery.level() .. '**'
    else
        battery.text_msg = battery.level() .. '%'
    end

    if not text_hide then
        wdg[2]:set_markup_silently('<span color="' .. text_color .. '">' .. battery.text_msg .. '</span>')
    end
end

function battery.update()
    if widget.text_mode then
        battery.text_update()
    else
        battery.bar_update()
    end
end

-- notify popup
function battery.popup(when)
    naughty.notify({title = utils.read(battery.path .. "charge_" .. when)})
    battery.update()
end

-- mouse click events
battery.widget:buttons(awful.util.table.join(
		awful.button({ }, 1, function() battery.popup("now") end),
		awful.button({ }, 3, function() battery.popup("full") end)
	)
)

-- set timer and initialize
battery.timer = gears.timer {
    timeout   = 10,
    call_now  = true,
    autostart = true,
    callback  = battery.update
}

return battery
