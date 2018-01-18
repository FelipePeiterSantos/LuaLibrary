local array = {}
for i=1,10 do
	mRand = math.random(10)
	table.insert(array, mRand)
end
local function compare( a, b )
    return a < b
end

table.sort( array, compare )
print( table.concat( array, ", " ) )