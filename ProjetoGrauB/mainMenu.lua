local storyboard = require "storyboard"
local scene = storyboard.newScene()
local background
local BTinstruction
local BTcredits
local BTchooseLevel
local onTap

function scene:createScene(event)
    local group = self.view
    background = display.newImage("img/mainMenu.png",display.contentWidth/2,display.contentHeight/2)
    BTinstruction = display.newRect(0,0,165,65); BTinstruction.x,BTinstruction.y = 97,433;BTinstruction.alpha=0;BTinstruction.isHitTestable=true
	BTcredits = display.newRect(0,0,165,65); BTcredits.x,BTcredits.y = 406,433; BTcredits.alpha=0;BTcredits.isHitTestable=true
	BTchooseLevel = display.newRect(0,0,165,65); BTchooseLevel.x,BTchooseLevel.y = 704,433; BTchooseLevel.alpha=0;BTchooseLevel.isHitTestable=true
	group:insert(background)
	group:insert(BTinstruction)
	group:insert(BTcredits)
	group:insert(BTchooseLevel)
end
function scene:enterScene(event)
	onTap = function (event)
		if event.target == BTinstruction then
			storyboard.gotoScene("instructions")
		elseif event.target == BTcredits then
			storyboard.gotoScene("screenCredits")
		elseif event.target == BTchooseLevel then
			storyboard.gotoScene("chooseLevel")
		end
	end
	BTinstruction:addEventListener("tap", onTap)
	BTcredits:addEventListener("tap", onTap)
	BTchooseLevel:addEventListener("tap", onTap)
end
function scene:exitScene(event)
	BTinstruction:removeEventListener("tap", onTap)
	BTcredits:removeEventListener("tap", onTap)
	BTchooseLevel:removeEventListener("tap", onTap)
	storyboard.purgeScene("mainMenu")
end
function scene:destroyScene(event)
	background:removeSelf()
	BTinstruction:removeSelf()
	BTcredits:removeSelf()
	BTchooseLevel:removeSelf()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene