-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

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

-- User defined params
local theme = "themes/neo/theme"
local awesome_path = "/home/noize/.config/awesome/"
local hostname = "daisy~machine"

-- Defaults
terminal = "alacritty"
editor = "emacs"
editor_cmd = terminal .. " -e emacs -nw"
filebrowser = "thunar"
browser = "firefox"
modkey = "Mod4"
altkey = "Mod1"

-- Screen names.
names = { "( 1 ) [ usr ]", "( 2 ) [ www ]", "( 3 ) [ dev ]", "( 4 ) [ sys ]", "( 5 ) [ mp3 ]", "( 6 ) [ img ]", "( 7 ) [ irc ]", "( 8 ) [ rom ]", "( 9 ) [ tmp ] " }

-- Load config files
require "conf.layout"
require "conf.menu"

require "conf.bound"
require "conf.client"
require "conf.ruled"
