local storyboard = require "storyboard"
local ui = require "ui"
local scene = storyboard.newScene()
local onTap
local level1
local level2
local previous
local background

function scene:createScene(event)
    local group = self.view
    background = display.newImage("img/selectLevel.png",display.contentWidth/2,display.contentHeight/2)
    previous = display.newRect(0,0,165,65);previous.x,previous.y=97,433;previous.alpha=0;previous.isHitTestable=true
    level1 = display.newImage("img/stage1.png",225,display.contentHeight/2);level1.xScale,level1.yScale=.5,.5
    level2 = display.newImage("img/stage2.png",display.contentWidth-225,display.contentHeight/2);level2.xScale,level2.yScale=.5,.5;level2:setFillColor(0,0,0)
   	group:insert(background)
    group:insert(previous)
    group:insert(level1)
    group:insert(level2)
end
function scene:enterScene(event)
	onTap = function (event)
		if event.target == previous then
			storyboard.gotoScene("mainMenu")
		elseif event.target == level1 then
			storyboard.gotoScene("gameLevel1")
		elseif event.target == level2 then
			storyboard.gotoScene("gameLevel2")
		end
	end
	level1:addEventListener("tap", onTap)
	if level2unlock then
		level2:addEventListener("tap", onTap)
		level2:setFillColor(1,1,1)
	end
	previous:addEventListener("tap", onTap)
end

function scene:exitScene(event)
	level1:removeEventListener("tap", onTap)
	level2:removeEventListener("tap", onTap)
	previous:removeEventListener("tap", onTap)
	storyboard.purgeScene("chooseLevel")
end

function scene:destroyScene(event)
	background:removeSelf()
	level1:removeSelf()
	level2:removeSelf()
	previous:removeSelf()

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
