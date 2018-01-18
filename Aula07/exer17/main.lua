local N = 21
local divisiveis = 0
for i=1,N do
	local aux = i % 7
	if aux == 0 then
		divisiveis = divisiveis + 1
	end
end
if divisiveis == 0 then
	print("Não ha divisiveis entre 1 e "..N)
else
	print("Há ".. divisiveis .." numeros divisiveis entre 1 e ".. N)
end