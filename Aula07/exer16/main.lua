function fatorial(N)
	local aux = 1
	for i=2,N do
		aux = aux * i
	end
	print(N.."! = ".. aux)
end

for i=1,10 do
	fatorial(i)
end