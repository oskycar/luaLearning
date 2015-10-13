print "helloworld"
print [[
a multi line
message
]]

s,e = string.find("hello lua users","lua")
print(s,e)

function  dummy(...)
return ...
end

print(dummy(s,e))
print((dummy(s,e)))  -->强制返回一个结果

print(unpack{10,20,30})
a,b=unpack{10,20,30}  -->30被忽略了

f = string.find
a = {"hello lua users","lua"}
print(f(unpack(a)))

function add(...)
    local s = 0
    
    for i,v in ipairs{...} do
        s = s+v
    end
    return s

end

print("sum is " .. add(3,4,10,25,55))

-->利用select访问变长参数
a={1,nil,2,3}
function selectTest(...)
    for i=1,select('#',...) do
    if select(i,...)~=nil then
        local arg1 = select(i,...)
        print("the".. i .."param is ".. arg1) 
    else
        print("the".. i .."param is nil") 
    end
    
    end
    
    
    --[[ -->5.0以前的版本使用隐含变量arg arg.n
    for i=1,arg.n do
        if arg[i]~=nil then
            print("隐含变量方式：the".. i .."param is ".. arg[i]) 
        else
            print("隐含变量方式：the".. i .."param is ".. arg[i]) 
        end
    end
    --]]
end

selectTest(unpack(a))

--print(nil .. 3) -->不能用nil去构造、连接任何值


function addfun(x,y)
return x+y
end

function addfunclo(a)  -->当函数只有一个参数时，可以在调用时省略括号，将table跟在函数名后面调用
return a.x+a.y
end

print(addfun(1,2))
print(addfunclo{x=1,y=2})