local bling = require "bling"

Scratch = {}

Scratch.term = bling.module.scratchpad {
  command = terminal .. " --class=scratch",
  rule = { instance = "scratch" },
  sticky = true,
  autoclose = false,
  floating = true,
  geometry = { x = 850, y = 410, height = 300, width = 500 },
  reapply = true,
  dont_focus_before_close = false,
}
