local n = 10
local s = 1/n
for i=2,n do
	s = s + i/(n-(i-1))
end
print(s)