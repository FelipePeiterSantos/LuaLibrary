function YesOrNot (string)
	local aux = ""
	for i=string:len(),1,-1 do
		aux = aux .. string:sub(i,i)
	end
	if string == aux then
		print("A palavra ".. string .. " é um palindromo.")
	else
		print("A palavra ".. string .." não é um palindromo.")
	end
end
YesOrNot("mussum")
YesOrNot("ovo")
YesOrNot("epaminondas")