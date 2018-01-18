display.setStatusBar(display.HiddenStatusBar)
local storyboard = require ("storyboard")
storyboard.isDebug = true
timer.performWithDelay(1000, function() storyboard:printMemUsage() end, 0)
storyboard.gotoScene("mainMenu")