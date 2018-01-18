require "physics"
physics.start()
physics.setGravity(0,0)
local _W = display.contentWidth
local _H = display.contentHeight
local alert = display.newText("Quando mais ao centro mais lento é disparado.", _W/2, _H-30, display.contentWidth-10, 100, native.systemFont, 30)
local atirador = display.newRect(_W/2,_H/2, 10,10); atirador:setFillColor(.5,.5,1)
local tiros = {}
function tiro(event)
	local speed = (math.sqrt((event.y-_H/2)^2 + (event.x-_W/2)^2))*.00005
	local angulo = math.atan2(event.y-_H/2,event.x-_W/2)
	local senX = math.cos(angulo)
	local senY = math.sin(angulo)
	local projetil = display.newRect(_W/2,_H/2, 10,10)
	physics.addBody(projetil,{density=0,friction=0,bounce=0})
	projetil:applyLinearImpulse(senX*speed,senY*speed)
	table.insert(tiros, projetil)
end
local manter = display.getCurrentStage().numChildren
function enterFrame(event)
	for i=1,#tiros do
		if tiros[i] then
			if tiros[i].x > _W or tiros[i].y > _H or tiros[i].x < 0 or tiros[i].y < 0 then
				table.remove(tiros, i)
				display.getCurrentStage():remove(i+manter)
			end
		end
	end
end
Runtime:addEventListener("enterFrame", enterFrame)
Runtime:addEventListener("tap", tiro)