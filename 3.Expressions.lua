x=math.pi
print(x)
print(x-x%0.01)


print("===========================")

local tolerance =219
function isturnback(angle)
angle = angle%360
return (math.abs(angle-180)<tolerance)
end

print(isturnback(212))


print("===========lua 的 and or 跟c的不同，是有返回值的================")
print(4 and 5)
print(nil and 13)
print(false and 13)
print(4 or 5)
print(false or 5)

print("===========================")

x=3
y=4
function getMax(x,y)
    return x>y and x or y
end

print(getMax(x,y))

print(nil or 3)   -->return 3
print(nil and 3)  -->return nil


print(not nil)

print(1 .. 3)
print(type(1 .. 3))

print("======================================")

a={10,20,30,nil,nil,nil}
b={10,20,30}
print(a==b)
print("len of a is  ".. #a .."  len of b is ".. #b)

print(-2^2)


a={["+"]="add"}

for i=-10,10 do
    print(i,i%3)
end

function polynomial(x,coff)
    len = #coff
    sum = 0
    for i=1,len-1 do
        sum = sum + coff[i]* (x^(len-i))
    end
    return sum+coff[len]
end

print( polynomial(2,{2,1}))

print("=======================================")
sunday="monday"  monday="sunday"
t={sunday="monday",[monday]=monday}   -->sunday="monday" === ["sunday"]="monday"   [monday]=monday  === ["sunday"]="sunday"
print(table.maxn(t))
print(t.sunday,t.monday,t[sunday],t[t.sunday])

print("=======================================")
t[1]=1
for k in pairs(t) do print(k) end



