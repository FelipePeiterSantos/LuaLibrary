local salarios = {math.random(50,100),math.random(100,200),math.random(200,300),math.random(300,400)}
local soma = 0
for i=1,#salarios do
	print("Funcionario "..i.. ":R$"..salarios[i])
	soma = soma + salarios[i]
end
print("R$"..soma)