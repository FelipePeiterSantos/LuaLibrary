local storyboard = require "storyboard"
local ui = require "ui"
local physics = require "physics"
local scene = storyboard.newScene()
local background
local stage
local poke1
local poke2
local poke3
local poke4
local pts
local choosedPlant
local score 
local TMPpts 
local progress
local matchTime
local garbage

function scene:createScene(event)
	local group = self.view
	background = display.newImage("img/background.png",display.contentWidth/2,display.contentHeight/2);background.yScale=1.1
	stage = display.newImage("img/scenario.png",display.contentWidth/2+78,display.contentHeight/2+15);stage.yScale=.93
	poke1 = display.newImage("img/1.png",92,115)
	poke2 = display.newImage("img/2.png",92,208);poke2:setFillColor(.5,.5,.5)
	poke3 = display.newImage("img/3.png",92,300);poke3:setFillColor(.5,.5,.5)
	poke4 = display.newImage("img/4.png",92,393);poke4:setFillColor(.5,.5,.5)
	TMPpts = display.newImage("img/sois.png",66,31)
	score = display.newText( "5", 100,28, native.systemFont, 20)
	progress = display.newImage("img/progress.png",432,26)
	matchTime = display.newImage("img/time.png",0,26);matchTime.alpha=.3;matchTime.x=progress.x+progress.contentWidth/2

	group:insert(background)
	group:insert(poke1)
	group:insert(poke2)
	group:insert(poke3)
	group:insert(poke4)
	group:insert(TMPpts)
	group:insert(score)
	group:insert(progress)
	group:insert(matchTime)
end
function scene:enterScene(event)
	physics.start()
	physics.setGravity( 0, 0 )
	garbage = {}
	local maxTimeSpawnZumb=20000
	--physics.setDrawMode( "hybrid" )
	--VARIABLES
	choosedPlant = 0
	pts = 5
	--MATCH TIME
	local function wavesEtimer()
		local win =  function() storyboard.gotoScene("victoryST1") end
		local wave3 = function() maxTimeSpawnZumb=5500;transition.to(matchTime,{time=30000,x=progress.x-progress.contentWidth/2,onComplete=win}) end
		local wave2 = function() maxTimeSpawnZumb=10000;transition.to(matchTime,{time=150000,x=progress.x-100,onComplete=wave3}) end
		transition.to(matchTime,{time=120000,x=progress.x+30,onComplete=wave2})
	end
	wavesEtimer()
	--SPAWN ZOMBIE
	local spawnZombie = function()
		local posZb = {84,162,240,318,396}
		local pokeZombie = zombieAnimation(math.random(1,3))
		table.insert(garbage,pokeZombie)
		pokeZombie.movendo = true
		pokeZombie.name="zombie"
		local hits = 8
		physics.addBody(pokeZombie,"dynamic",{density=1, friction=1, bounce=1, radius=25})
		local removePokeZombie = function()
			storyboard.gotoScene("defeatedST1")
		end
		local function onCollision(event)
			if event.phase == "began" then
				local function danoAnim(event)
					local aux = event
					aux.target:setFillColor(1,0,0)
					timer.performWithDelay(250,function() aux.target:setFillColor(1,1,1) end)
				end
				if event.other.name == "tiro1" then
					hits = hits - 1
					transition.cancel(event.other)
					event.other:removeSelf()
					if hits <= 0 then
						transition.cancel(event.target)
						event.target:removeSelf()
					elseif hits > 0 then
						danoAnim(event)
					end
				elseif event.other.name == "tiro2" then
					hits = hits - .5

					transition.cancel(event.other)
					event.other:removeSelf()
					if hits <= 0 then
						transition.cancel(event.target)
						event.target:removeSelf()
					elseif hits > 0 then
						danoAnim(event)
					end
				end
				if event.other.name == "zombie" then
					local aux = event
					transition.pause(event.other)
					event.other.movendo = false
				end
			end
		end
		pokeZombie:addEventListener("collision",onCollision)
		pokeZombie.x,pokeZombie.y=display.contentWidth,posZb[math.random(1,#posZb)]
		local aux = pokeZombie.y
		transition.to(pokeZombie,{x=150,time=60000,onComplete=removePokeZombie})
		local function centraliza()
			transition.to(pokeZombie,{y=aux,time=1000,onComplete=centraliza})
		end
		centraliza()
	end
	--SCORE/PLANTS
	local scoreSol = function(event)
		if event.phase == "began" then
			transition.cancel(event.target)
			event.target:removeSelf()
			pts = pts + 5
			score.text = pts
			enabledPlant(pts,poke1,poke2,poke3,poke4)
			return true
		end
	end
	--CHOOSE PLANT
	local choosed = function(event)
		if event.target == poke1 and pts >= 5 then
			choosedPlant = 1
			poke1:setFillColor(1,1,.5)
			return true
		elseif event.target == poke2 and pts >= 10 then
			choosedPlant = 2
			poke2:setFillColor(1,1,.5)
			return true
		elseif event.target == poke3 and pts >= 15 then
			choosedPlant = 3
			poke3:setFillColor(1,1,.5)
			return true
		elseif event.target == poke4 and pts >= 20 then
			choosedPlant = 4
			poke4:setFillColor(1,1,.5)
			return true
		end
	end
	--EVENT LISTENER PLANTS
	poke1:addEventListener("tap",choosed)
	poke2:addEventListener("tap",choosed)
	poke3:addEventListener("tap",choosed)
	poke4:addEventListener("tap",choosed)
	--SPAWN SOL
	local spawnSol = function()
		local sol = display.newImage("img/sol"..math.random(1,2)..".png",math.random(219,740),0)
		local removeSol = function()
			sol:removeSelf()
		end
		transition.to(sol,{y=display.contentHeight,time=10000,onComplete=removeSol})
		sol:addEventListener("touch",scoreSol)
	end
	function comecarSpawnarSol()
		timer.performWithDelay(math.random(1000,20000),function(e) comecarSpawnarSol();spawnSol() end)
	end
	comecarSpawnarSol()
	function comecarSpawnarZombies()
		timer.performWithDelay(math.random(5000,maxTimeSpawnZumb),function(e) comecarSpawnarZombies();spawnZombie() end)
	end
	comecarSpawnarZombies()
	--PLANTAR
	local plantar = function(event)
		local posX=event.target.x
		local posY=event.target.y
		if choosedPlant == 1 and pts >= 5 then
			event.target:removeSelf()
			event.target = plantAnimation(1)
			table.insert(garbage, event.target)
			physics.addBody(event.target,"static",{density=1, friction=1, bounce=1, radius=25})
			event.target.isHitTestable=false
			--SPAWN SOL FLOR
			local spawnSolFlor = function(x,y)
				local sol = display.newImage("img/sol"..math.random(1,2)..".png",x,y);sol.alpha=0
				sol:addEventListener("touch",scoreSol)
				transition.to(sol,{y=sol.y-20,alpha=1,time=500,onComplete=function() transition.to(sol,{y=sol.y+20,time=500}) end})
			end
			timer.performWithDelay(20000,function() spawnSolFlor(event.target.x,event.target.y) end,0)
			choosedPlant=0
			pts = pts - 5
			score.text = pts
			enabledPlant(pts,poke1,poke2,poke3,poke4)
		end
		if choosedPlant == 2 and pts >= 10 then
			local hits = 0
			event.target:removeSelf()
			event.target = plantAnimation(2)
			table.insert(garbage, event.target)
			physics.addBody(event.target,"static",{density=1, friction=1, bounce=1, radius=25})
			event.target.alpha=1
			choosedPlant=0
			pts = pts - 10
			score.text = pts
			enabledPlant(pts,poke1,poke2,poke3,poke4)
			timer.performWithDelay(2000,function()  --end,0)
				local circle = display.newCircle(posX,posY,10);circle:setFillColor(.7,.9,.9)
				circle.name = "tiro1"
				transition.moveTo(circle,{time=3000,x=display.contentWidth,onComplete=function() circle:removeSelf() end})
				physics.addBody(circle,"dynamic",{density=1, friction=1, bounce=1, radius=10})
			end,0)
		end
		if choosedPlant == 3 and pts >= 15 then
			event.target:removeSelf()
			event.target = plantAnimation(3)
			table.insert(garbage, event.target)
			event.target.name = "batata"
			local hits=50
			physics.addBody(event.target,"static",{density=1, friction=1, bounce=1, radius=25})
			local function onCollision(event)
				if event.phase == "began" then
					if event.other.name == "zombie" then
						local aux = event
						transition.pause(event.other)
						event.other.movendo = false
						timer.performWithDelay(1000,function(e)
							hits = hits - 5
							local function danoAnim()
								aux.target:setFillColor(1,0,0)
								timer.performWithDelay(250,function() aux.target:setFillColor(1,1,1) end)
							end
							if hits <= 0 then
								timer.cancel(e.source)
								aux.target:removeSelf()
								transition.resume(aux.other)
								aux.other.movendo = true
							elseif hits > 0 then
								danoAnim()
							end
						end,0)
					end
				end
			end
			event.target:addEventListener("collision",onCollision)
			event.target.alpha=1
			choosedPlant=0
			pts = pts - 15
			score.text = pts
			enabledPlant(pts,poke1,poke2,poke3,poke4)
		end
		if choosedPlant == 4 and pts >= 20 then
			event.target:removeSelf()
			event.target = plantAnimation(4)
			table.insert(garbage, event.target)
			physics.addBody(event.target,"static",{density=1, friction=1, bounce=1, radius=25})
			event.target.alpha=1
			choosedPlant=0
			pts = pts - 20
			score.text = pts
			enabledPlant(pts,poke1,poke2,poke3,poke4)
			timer.performWithDelay(500,function()  --end,0)
				local circle = display.newCircle(posX,posY,10);circle:setFillColor(.4,.6,.8)
				circle.name = "tiro2"
				transition.moveTo(circle,{time=3000,x=display.contentWidth,onComplete=function() circle:removeSelf() end})
				physics.addBody(circle,"dynamic",{density=1, friction=1, bounce=1, radius=10})
			end,0)
		end
		event.target.x,event.target.y=posX,posY
	end
	--SPAWN STAGE
	local xAux=219
	local yAux=99
	for i=1,5 do
		for j=1,9 do
			local mRand = math.random()
			local stageSize = display.newRect(0,0,65,78);stageSize.x,stageSize.y=xAux,yAux;stageSize.alpha=0;stageSize.isHitTestable=true
			stageSize:addEventListener("tap", plantar)
			xAux=xAux+65
		end
		xAux=219
		yAux=yAux+78
	end
end

function scene:exitScene(event)
	transition.cancel()
	for i,v in pairs(timer._runlist) do
	    timer.cancel(v)
	end
end
function scene:destroyScene(event)
	background:removeSelf()
	stage:removeSelf()
	score:removeSelf()
	poke1:removeSelf()
	poke2:removeSelf()
	poke3:removeSelf()
	poke4:removeSelf()
	progress:removeSelf()
	matchTime:removeSelf()
	TMPpts:removeSelf()
	-for i,v in ipairs(garbage) do
		v:removeSelf()
	end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene