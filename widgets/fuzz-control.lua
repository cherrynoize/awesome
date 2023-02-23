-- fuzz-control brightness widget
-- Module imports
local awful = require("awful")
local spawn_with_shell = awful.util.spawn_with_shell or awful.spawn.with_shell
local wibox = require("wibox")
local gears = require("gears")
local math = require("math")
local utils = require("widgets.utils")
local style = require("themes.noize.style2")
local widget = require("widgets.widget-control")

local fuzz = {}
local intel_path = 'intel_backlight/' -- intel path
local amd_path = 'amdgpu_bl0/' -- amd path
local cur_path = intel_path -- try to initialize to intel first
local backlight = style.backlight or '/sys/class/backlight/' -- backlight path
-- if you think you've set the correct udev permission rules and it still isn't working
-- you need to install `light` and set style.use_light to true in your theme profile
local lstep = style.step/100 or widget.step -- widget step
local sstep = 5 -- step scalar

local prec = 0 -- default floating point precision
if style.prec ~= nil then prec = style.prec end -- overwrite even if 0

function fbrightness()
   return backlight .. '/' .. cur_path .. '/' .. (style.cur_fuzz or 'brightness')
end

function fmax()
   return backlight .. '/' .. cur_path .. '/' .. (style.max_fuzz or 'max_brightness')
end

-- Lua implementation of PHP scandir function
function scandir(directory)
   local i, t, popen = 0, {}, io.popen
   local pfile = popen('ls -a "'..directory..'"')
   for filename in pfile:lines() do
      i = i + 1
      t[i] = filename
   end
   pfile:close()
   return t
end

-- returns true if file exists
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- returns new if old doesn't exist
function fupdate(old, new)
   if not file_exists(old) then
      return new
   end
end

local naughty = require("naughty")

-- set backlight path
cur_path = fupdate(fbrightness(), intel_path) or cur_path -- intel
cur_path = fupdate(fbrightness(), amd_path) or cur_path -- amd
cur_path = fupdate(fbrightness(), scandir(backlight)[3]) or cur_path -- fallback (brute-read anything from backlight dir)

-- define bar
if widget.text_mode then
   widget.wibox = wibox.widget(widget.text)
   widget.wibox.layout = wibox.layout.stack
else
   widget.wibox = wibox.widget {
      widget.bar,
      widget.text,
      layout = wibox.layout.stack
   }
end

-- define widget
fuzz.widget = wibox.container.margin((widget.wibox),
   margin_right, margin_left,
   margin_top, margin_bottom)

fuzz.cur    = fbrightness()
fuzz.maxp   = fmax()

-- return current brightness level
function fuzz.current()
   local cur = utils.read(fuzz.cur)
   if cur then
      if style.perc then
         cur = utils.percent(cur, fuzz.max())
      end
      return string.format('%.' .. prec .. 'f', cur)
   else
      return 'N/A'
   end
end

-- return max brightness level
function fuzz.max()
   return utils.read(fuzz.maxp) or 'N/A'
end

function fuzz.text_update()
   local wdg = fuzz.widget:get_all_children()
   wdg[1]:set_markup_silently('<span color="' .. widget.text_color .. '">' .. fuzz.current() .. '</span>')
end

function fuzz.bar_update()
   local wdg = fuzz.widget:get_all_children()

   wdg[1]:set_value(fuzz.current() / fuzz.max())

   if not widget.text_hide then
      wdg[2]:set_markup_silently('<span color="' .. widget.text_color .. '">' .. fuzz.current() .. '</span>')
   end
end

function fuzz.update()
   if widget.text_mode then
      fuzz.text_update()
   else
      fuzz.bar_update()
   end
end

function fuzz.step()
   return fuzz.max() * lstep * sstep
end

function fuzz.up()
   if style.use_light then
      utils.capture('light -rA ' .. fuzz.step())
   else
      utils.write(fuzz.cur, fuzz.current() + fuzz.step())
   end
   fuzz.update()
end

function fuzz.down()
   if style.use_light then
      utils.capture('light -rU ' .. fuzz.step())
   else
      utils.write(fuzz.cur, fuzz.current() - fuzz.step())
   end
   fuzz.update()
end

function fuzz.min()
   if style.use_light then
      utils.capture('light -rS ' .. 0)
   else
      utils.write(fuzz.cur, 0)
   end
   fuzz.update()
end

function fuzz.all()
   if style.use_light then
      utils.capture('light -rS ' .. fuzz.max())
   else
      utils.write(fuzz.cur, fuzz.max())
   end
   fuzz.update()
end

function fuzz.half()
   if style.use_light then
      utils.capture('light -rS ' .. fuzz.max()/2)
   else
      utils.write(fuzz.cur, fuzz.max()/2)
   end
   fuzz.update()
end

function fuzz.toggle()
   if tonumber(fuzz.current()) ~= 0
   then
      fuzz.min()
   else
      fuzz.all()
   end
end

-- mouse click events
fuzz.widget:buttons(awful.util.table.join(
                       awful.button({ }, 1, fuzz.toggle),
                       awful.button({ }, 3, fuzz.all),
                       awful.button({ }, 5, fuzz.up),
                       awful.button({ }, 4, fuzz.down)
                                         )
)

-- initialize
fuzz.update()

return fuzz
