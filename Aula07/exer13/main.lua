function ontap(event)
	if matriz then
		for i=1,display.getCurrentStage().numChildren do
			display.getCurrentStage():remove(1)
		end
	end
	matriz = {}
	for i=1,25 do
		local aux = tostring(math.random(10))
		local num = display.newText(aux, 0, 0, native.systemFont, 32)
		table.insert(matriz, num)
	end
	local linha1 = 0
	local linha2 = 0
	local linha3 = 0
	local linha4 = 0
	local linha5 = 0
	for i=1,#matriz do
		if i <= 5 then
			matriz[i].x = (display.contentCenterX - 120) + linha1
			matriz[i].y = display.contentCenterY - 120
			linha1 = linha1 + 60
		elseif i <= 10 then
			matriz[i].x = (display.contentCenterX - 120) + linha2
			matriz[i].y = display.contentCenterY - 60
			linha2 = linha2 + 60
		elseif i <= 15 then
			matriz[i].x = (display.contentCenterX - 120) + linha3
			matriz[i].y = display.contentCenterY
			linha3 = linha3 + 60
		elseif i <= 20 then
			matriz[i].x = (display.contentCenterX - 120) + linha4
			matriz[i].y = display.contentCenterY + 60
			linha4 = linha4 + 60
		else
			matriz[i].x = (display.contentCenterX - 120) + linha5
			matriz[i].y = display.contentCenterY + 120
			linha5 = linha5 + 60
		end
	end
end
ontap()
Runtime:addEventListener("tap",ontap)