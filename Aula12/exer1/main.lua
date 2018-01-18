local function ontap(event)
	print("Posicao X: "..event.x.." / Posicao Y: "..event.y)
end

Runtime:addEventListener("tap", ontap)