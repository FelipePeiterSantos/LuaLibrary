local storyboard = require "storyboard"
local ui = require "ui"
local scene = storyboard.newScene()
local background
local voceVenceu
local previous
function scene:createScene(event)
	background = display.newRect(0,0,display.contentWidth,display.contentHeight);background.alpha=0;background:setFillColor(0,0,0)
	voceVenceu = display.newText( "VOCÊ VENCEU O CAMPEONATO DE POKEMON VS ZOMBIES!!!", display.contentWidth/2,0, native.systemFont, 26);voceVenceu.alpha=0
	previous = display.newImage("img/BTvoltar.png");previous.alpha=0
end

function scene:enterScene(event)
	level2unlock = true
	previous.x,previous.y=97,433
	background.x,background.y=display.contentWidth/2,display.contentHeight/2
	local events = function(event)
		local function onTap(event)
			storyboard.gotoScene("mainMenu")
		end
		previous:addEventListener("tap", onTap)
	end
	local fadeInBT = function() transition.to(previous,{time=500,alpha=1,onComplete=events}) end
	local fadeInText = function() transition.to(voceVenceu,{time=500,y=display.contentHeight/2,alpha=1,onComplete=fadeInBT}) end
	transition.to(background,{time=500,alpha=.5,onComplete=fadeInText})
end

function scene:exitScene(event)
	storyboard.purgeScene("gameLevel2")
	storyboard.purgeScene("victoryST2")
end

function scene:destroyScene(event)
	background:removeSelf()
	voceVenceu:removeSelf()
	previous:removeSelf()
end
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
