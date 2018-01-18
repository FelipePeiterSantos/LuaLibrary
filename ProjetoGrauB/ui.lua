function enabledPlant(pts,poke1,poke2,poke3,poke4)
	if pts >= 5 then
		poke1:setFillColor(1,1,1)
	else
		poke1:setFillColor(.5,.5,.5)
	end
	if pts >= 10 then
		poke2:setFillColor(1,1,1)
	else
		poke2:setFillColor(.5,.5,.5)
	end
	if pts >= 15 then
		poke3:setFillColor(1,1,1)
	else
		poke3:setFillColor(.5,.5,.5)
	end
	if pts >= 20 then
		poke4:setFillColor(1,1,1)
	else
		poke4:setFillColor(.5,.5,.5)
	end
end
level2unlock = false
function zombieAnimation(rand)
	local animation
	if rand == 1 then
		local sheetData = {width=100,height=143.5,numFrames=7}
		local mySheet = graphics.newImageSheet("img/zumbi1.png", sheetData)
		local sequenceData={{name="run",start=1,count=7,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
		animation.xScale,animation.yScale=.7,.7
	elseif rand == 2 then
		local sheetData = {width=62,height=101,numFrames=7}
		local mySheet = graphics.newImageSheet("img/zumbi2.png", sheetData)
		local sequenceData={{name="run",start=1,count=7,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
	elseif rand == 3 then
		local sheetData = {width=112,height=159,numFrames=7}
		local mySheet = graphics.newImageSheet("img/zumbi3.png", sheetData)
		local sequenceData={{name="run",start=1,count=7,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
		animation.xScale,animation.yScale=.7,.7
	end
	animation:play()
	return animation
end
platControl = {}
function plantAnimation(plant)
	local animation
	if plant == 1 then
		local sheetData = {width=100,height=92,numFrames=7}
		local mySheet = graphics.newImageSheet("img/planta1.png", sheetData)
		local sequenceData={{name="run",start=1,count=7,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
	elseif plant == 2 then
		local sheetData = {width=120,height=115,numFrames=8}
		local mySheet = graphics.newImageSheet("img/planta2.png", sheetData)
		local sequenceData={{name="run",start=1,count=8,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
	elseif plant == 3 then
		local sheetData = {width=125,height=117,numFrames=4}
		local mySheet = graphics.newImageSheet("img/planta3.png", sheetData)
		local sequenceData={{name="run",start=1,count=4,time=3000}}
		animation=display.newSprite(mySheet, sequenceData)
	elseif plant == 4 then
		local sheetData = {width=115,height=92,numFrames=8}
		local mySheet = graphics.newImageSheet("img/planta4.png", sheetData)
		local sequenceData={{name="run",start=1,count=8,time=1000}}
		animation=display.newSprite(mySheet, sequenceData)
	end
	animation.xScale,animation.yScale=.7,.7
	animation:play()
	return animation
end