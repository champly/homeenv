-- Shortcuts recorded in Rex, written the way a configuration file spells them.
-- Paste them into your init.lua, then use Reset All in Rex to clear them there.
local popup = require("popup")

popup.toggle("lazygit", { "lazygit" })
rex.bind("cmd+g", "lazygit")

rex.unbind("cmd+k", "session.switch")
rex.unbind("cmd+enter", "pane.split.auto")

rex.bind("cmd+s", "session.switch")
