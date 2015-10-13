--[==[
count = 0

function Entry()
count = count+1
end

dofile("data") -->这段代码使用了事件驱动的做法，Entry函数作为回调函数，在dofile时为每个条目所调用

print("entry count is  ".. count)


-->打印作者姓名
local authors={}
function Entry(b)
    authors[b[1]]=true
end
dofile("data")
print("all authors are :   ")
for names in pairs(authors) do print(names) end


-->使用键值对的方式获取作者信息
local authors={}
function Entry(b)
    authors[b.author]=true
end
dofile("data2")
print("all authors are :   ")
for names in pairs(authors) do print(names) end

--]==]

-->序列化

function serialize (o)
    if type(o) == "number" then
        io.write(o)
    end
    if type(o) == "string" then
        io.write("[[", o, "]]")
    end
end



serialize(333)
serialize([[  | &^% djfa 
sdfkj
]])


a = 'a "problematic" \\string'
print(string.format("%q", a))

function quote (s)  -->找到序列中=号的最长长度，然后自动生成一个更长的包含=号的[[]]包含
-- find maximum length of sequences of equal signs
local n = -1
for w in string.gmatch(s, "]=*]") do
n = math.max(n, #w - 2) -- -2 to remove the ']'s
end
-- produce a string with 'n' plus one equal signs
local eq = string.rep("=", n + 1)
-- build quoted string
return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end
print("\n \n \n ")
print(quote([[hello ]=] ]]))


--》保存无环的table

function serialize (o)
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            --io.write(" ", k, " = ")
            io.write(" ["); serialize(k); io.write("] = ")
            serialize(v)
            io.write(", \n")
        end
        io.write("}\n")
    else
    error("cannot serialize a " .. type(o))
    end
end

serialize{a=12, b='Lua', key='another "one"'}