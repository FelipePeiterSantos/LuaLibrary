function dano(D,F)
	local result = D * math.random(6) + F
	print("Destreza: ".. D ..", Forca: ".. F ..", Dano: ".. result)
end
dano(10,5)