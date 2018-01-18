local tentativas = 0
repeat 
	n1 = math.random(6)
	n2 = math.random(6)
	n3 = math.random(6)
	tentativas = tentativas+1
until n1 == n2 and n2 == n3
print("Em ".. tentativas .. " tentativas, os 3 dados cairam no numero ".. n1)