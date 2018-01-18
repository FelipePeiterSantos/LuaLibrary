local storyboard = require "storyboard"
local scene = storyboard.newScene()
local onTap
local text
local background

function scene:createScene(event)
    local group = self.view
    background = display.newImage("img/creditos.jpg",display.contentWidth/2,display.contentHeight/2)
    group:insert(background)
end
function scene:enterScene(event)
	onTap = function (event)
		storyboard.gotoScene("mainMenu")
	end
	background:addEventListener("tap", onTap)
end

function scene:exitScene(event)
	background:removeEventListener("tap", onTap)
	storyboard.purgeScene("screenCredits")
end

function scene:destroyScene(event)
	background:removeSelf()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene