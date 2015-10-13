--Part! 2.Types and Values

print(type("Hello world"))
print(type(10.4*3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print("x="..type(X))
print(type(type(X)))

print("\n==============================\n")

print(type(a))
a = 10
print(type(a))
a = "a string!!"
print(type(a))
a = print
a(type(a))

print("\n==============================\n")

a = "one string"
b = string.gsub(a, "one", "another")  -- change string parts
print(a)       --> one string
print(b)

a = "hello"
print(#a)             --> 5
print(#"good\0bye")   --> 8

print("\n==============================\n")

print("one line\nnext line\n\"in quotes\", 'in quotes'")
print('a backslash inside quotes: \'\\\'')
print("a simpler way: '\\'")

page = [[
     <html>
     <head>
       <title>An HTML Page</title>
     </head>
     <body>
       <a href="http://www.lua.org">Lua</a>
     </body>
     </html>
     ]]

print(page)

print("\n==============================\n")

print("10" + 1)
print("10 + 1")
print("-5.3e-10"*"2")
--error: print("hello" + 1)
print(10 .. 20)

--line = io.read()    -- read a line
line=21
n = tonumber(line)    -- try to convert it to a number
if n == nil then
   error(line .. " is not a valid number")
 else
   print(n*2)
 end


print("===================================")

a = {}           -- create a table and store its reference in 'a'
k = "x"
a[k] = 10        -- new entry, with key="x" and value=10
a[20] = "great"  -- new entry, with key=20 and value="great"
print(a["x"])    --> 10
k = 20
print(a[k])      --> "great"
a["x"] = a["x"] + 1     -- increments entry "x"
print(a["x"])

print("=====================================================")

a = {}
a["x"] = 10
b = a
print(b["x"])
b["x"] = 20
print(a["x"])
a = nil
b = nil

print("=====================================================")

a = {}     -- empty table
-- create 1000 new entries
for i = 1, 1000 do a[i] = i*2 end
print(a[9])    --> 18
a["x"] = 10
print(a["x"])  --> 10
print(a["y"])  --> nil

print("=====================================================")

a = {}
x = "y"
a[x] = 10
print(a[x])
print(a.x)
print(a.y)


print("=====================================================")
for i = 1, 10 do a[i] = i*2 end
for i = 1, #a do
print(a[i])      -- print the lines
end

print(table.maxn(a))