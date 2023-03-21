local awful = require "awful"
local bling = require "bling"
local l = awful.layout.suit

awful.layout.layouts = {
   l.floating,
   l.tile,
   l.tile.left,
   l.tile.bottom,
   l.tile.top,
   l.fair,
-- l.fair.horizontal,
-- l.spiral,
   l.spiral.dwindle,
-- l.max,
-- l.max.fullscreen,
-- l.magnifier,
   l.corner.nw,
   l.corner.ne,
-- l.corner.sw,
-- l.corner.se,
   bling.layout.mstab,
   bling.layout.centered,
   bling.layout.equalarea,
   bling.layout.deck,
}
