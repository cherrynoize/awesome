-- utility tools library
-- Module imports
local naughty = require("naughty")

-- Utils
local utils = {}

-- Read file contents
function utils.read(path)
   local file = io.open(path, "rb") -- r read mode and b binary mode
   if not file then return nil end
   local content = file:read "*a" -- *a or *all reads the whole file
   file:close()
   return content
end

-- Overwrite file
function utils.write(path, text)
   local file = io.open(path, "w")
   if file then
      io.output(file)
      io.write(text)
      io.close(file)
   else
      naughty.notify({title = 'Error: failed to write to file (did you overwrite default permissions in `/etc/udev/rules.d/backlight.rules`?)'})
   end
end

-- Capture shell command output
function utils.capture(cmd, raw)
   local f = assert(io.popen(cmd, 'r'))
   local s = assert(f:read('*a'))
   f:close()
   if raw then return s end
   s = string.gsub(s, '^%s+', '')
   s = string.gsub(s, '%s+$', '')
   s = string.gsub(s, '[\n\r]+', ' ')
   return s
end

-- returns ratio as percentage number
function utils.percent(part, tot)
   return 100 * part / tot
end

return utils
