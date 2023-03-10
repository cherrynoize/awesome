-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local gfs = require("gears.filesystem")
require("awful.autofocus")

-- User defined params
local widgets = "widgets/"
local theme = "themes/neo/theme"
local awesome_path = gfs.get_configuration_dir()
hostname = "daisy~machine"
username = "noize"
local scrot_path = "/home/" .. username .. "/bnd/pictures/scrot/"

-- Widget and layout library
local wibox = require("wibox")
local noize = require(widgets .. "noize-control")
local fuzz = require(widgets .. "fuzz-control")
local battery = require(widgets .. "batt-control")
local sep = require(widgets .. "flow-control")

-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Other awesome stuff
menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, you fucked up startup again!",
                    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             -- Make sure we don't go into an endless error loop
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, runtime error after startup!",
                                              text = tostring(err) })
                             in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awesome_path .. theme .. ".lua")

-- Defaults
terminal = "alacritty"
editor = "pluma"
editor_cmd = terminal .. " -e vim"
filebrowser = "spacefm"
browser = "firefox"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

require "conf"
F = {}
require "ui"
