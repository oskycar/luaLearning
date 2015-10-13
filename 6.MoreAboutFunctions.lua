network = {
        {name = "grauna",  IP = "210.26.30.34"},
        {name = "arraial", IP = "210.26.30.23"},
        {name = "lua",     IP = "210.26.23.12"},
        {name = "derain",  IP = "210.26.23.20"},
}

table.sort(network, function (a,b) return (a.name > b.name) end)  -->使用匿名函数进行排序

print(network[1].name,network[2].name,network[3].name,network[4].name)

function derivative (f, delta)  -->返回函数f的导数函数
       delta = delta or 1e-4
       return function (x)
                return (f(x + delta) - f(x))/delta
              end
end

c = derivative(math.sin)
print(math.cos(10),c(10))  -->sin的导数是cos，因此二者输出的值应该非常相近


names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}  -->按照grades对names进行排序
table.sort(names, function (n1, n2)
                return grades[n1] > grades[n2]        -- compare the grades
                end)
                
function sortbygrade (names, grades)        -->内部匿名函数可以访问外部变量
       table.sort(names, function (n1, n2)
         return grades[n1] > grades[n2]      -- compare the grades
       end)
end

sortbygrade(names,grades)

function newCounter ()
  local i = 0
  return function ()   -- anonymous function
    i=i+1
    return i end
end
c1 = newCounter()
print(c1())  --> 1
print(c1())  --> 2

c2 = newCounter()
print(c2())  --> 1   -- c1 c2中的i是彼此独立的，是存放在2个不同的闭包中处理的
print(c1())  --> 3
print(c2())  --> 2

