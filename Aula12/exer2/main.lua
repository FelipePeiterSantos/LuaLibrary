require "physics"
local physics = require("physics")
physics.start()
local function ontap(event)
	local time = (display.contentHeight - (event.y - 50))*4
	local caixa = display.newRect(0,0,50,50)
	caixa.x,caixa.y = event.x,event.y
	physics.addBody(caixa,"dynamic",{density=1,friction=0,bounce=0})
	timer.performWithDelay(time,function() caixa:removeSelf() end)
end

Runtime:addEventListener("tap", ontap)