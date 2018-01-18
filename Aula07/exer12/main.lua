local Radigunda = 150
local Eudoxia = 110
local anos = 0
function calc()
	anos = anos + 1
	Radigunda = Radigunda + 2
	Eudoxia = Eudoxia + 3
	if Radigunda >= Eudoxia then
		calc()
	else
		print(Radigunda,Eudoxia)
		return print("Eudoxia levara ".. anos .." para ficar maior que Radigunda.")
	end
end
calc()