-- If LuaRocks is installed, make sure that packages
-- installed through it are found. If not, do nothing.
pcall(require, "luarocks.loader")

-- Gears filesystem awesome library.
local gfs = require("gears.filesystem")

-- Theme handling library.
local beautiful = require("beautiful")

-- Notification library.
local naughty = require("naughty")

-- User defined params.
local theme = "themes/neo/theme"
local awesome_path = gfs.get_configuration_dir()

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

F = {}

require "lib"
require "ui"
