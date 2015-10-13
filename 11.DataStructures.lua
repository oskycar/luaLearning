
--数组

a = {} -- new array,数组使用整数索引，即索引可以是正数、也可以是负数
for i = 1, 1000 do
a[i] = 0
end

print(#a)

a={}
for i=-5,5 do
a[i]=0
end

print(#a) --lua的长度操作符#默认是从1开始计数的，因此这里算出的长度只有5个

--[[矩阵与多维数组]]--


N=3
M=4

--使用嵌套table的方式创建矩阵
mt = {} -- create the matrix
for i = 1, N do
    mt[i] = {} -- create a new row
    for j = 1, M do
        mt[i][j ] = 0
    end
end
print(#mt)  --> 3 #只取出了第一维度的行数信息
--使用合并索引创建矩阵

mt = {} -- create the matrix
for i = 1, N do
    for j = 1, M do
        mt[(i - 1)*M + j ] = 0
    end
end
print(#mt)   -->12 mt此时是个一维数组，长度为N*M


-->队列的例子

List = {}

function List.new ()
    return {first = 0, last = 0}
end

function List.pushfirst (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end
function List.pushlast (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end
function List.popfirst (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
return value
end
function List.poplast (list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil -- to allow garbage collection
    list.last = last - 1
    return value
end

myqueue = List.new()
List.pushlast(myqueue,1)
List.pushlast(myqueue,2)
List.pushlast(myqueue,3)
List.pushlast(myqueue,4)
print("myqueue len = ".. #myqueue)

List.poplast(myqueue)
List.poplast(myqueue)
List.poplast(myqueue)
List.poplast(myqueue)
List.poplast(myqueue)
print("myqueue len = ".. #myqueue)

