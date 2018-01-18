local N1 = 0
local N2 = 1
print("Serie de Fibonacci até décimo quinto termo")
for i=0,15 do
	local aux = N2
	N2 = N1 + N2
	N1 = aux
	print(N2)
end