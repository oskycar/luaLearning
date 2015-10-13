
function trace(x)
if x==nil then
print("=====================================================")
else
print("======================".. x .."==========================")
end
end

--[[ 删除该类型注释运行所有代码

co = coroutine.create(function() print("helloworld") end)
print(co)
coroutine.resume(co)
print(coroutine.status(co))

trace()

co = coroutine.create(function()
        for i=1,10 do
        print("co yield ",i .." ")
        coroutine.yield(i)     -->需要在外面显示调用resume才能唤醒到下一次执行,yield传入的参数，会在当前resume中返回出去
        end
        end)

coroutine.resume(co) --》创建后不会自动执行，需要调用resume唤醒

for i=1,10 do
print("co status is  ".. coroutine.status(co))
print("resume for ".. i .."  times ")
print(coroutine.resume(co))
end


print(coroutine.resume(co))   -->执行完毕后协同程序进入死亡状态，无法继续执行

trace()

co = coroutine.create(function (a, b, c)
print("co", a, b, c + 2)
end)

coroutine.resume(co, 1, 2, 3)  -->传递给resume的参数都将作为协同程序主函数的参数

trace("yield和resume的参数传递方式")
trace("注意这段代码的输出结果及顺序")

co = coroutine.create(function (a,b)
print("yield result ：" , coroutine.yield(a + b, a - b))   -->yield返回的结果是第二次resume时传入的参数，第一次resume只是启动函数。也就是说先yield再resume
print("resumed and return")
return 5,6
end)
print(coroutine.resume(co, 1, 2))  -->true 30 10   返回的30，10是传给yield的参数
print(coroutine.resume(co,3,4))  -->true 此时yield的状态被resume唤醒，并执行yield后的代码,函数的返回结果被当做resume的结果

trace("end")


co = coroutine.create(function ()
return 6, 7
end)
print(coroutine.resume(co)) --> true 6 7   当协同程序结束时，主函数的返回值都将作为resume的返回值



trace("生产者消费者模式")

function receive ()
local status, value = coroutine.resume(producer)
return value
end

function send (x)
coroutine.yield(x+1)       -->消费者在resume生产者后等待生产者，生产者生产数据后在yield自己时，将数据返回给后消费者的resume，将数据交给
print("send after yield")
end

function consumer ()
    while true do
        local x = receive() -- receive value from producer
        io.write("consumer get one value = " .. x, "\n") -- consume it
    end
end

function producer ()
    while true do
    local x = io.read() -- produce new value
    print("producer one value = ".. x)
    send(x) -- send it to consumer
    end
end

producer = coroutine.create(producer)
    
consumer()



trace("管道，过滤器模式")

function producer ()
    return coroutine.create(
    function()
        while true do
        local x = io.read() -- produce new value
        send(x) -- send it to consumer
        end
    end
    )
    
end
function consumer(prod)
    while true do
    local x = receive(prod) -- receive value from producer
    io.write(x, "\n") -- consume it
    end
end

function receive(prod)
    local status, value = coroutine.resume(prod)  -->唤醒生产者，以获取一个值
    return value
end

function send (x)
    coroutine.yield(x)       -->将send所在生产者挂起，并返回生产者的产生的值
end

function filter(prod)        -->过滤器是一个特殊的生产者，其先从其它生产者中获取数据，再在其数据基础上产生新数据
    return coroutine.create(
    function()
        for line=1,math.huge do
        local x = receive(prod) --获取新值
        x=string.format("%5d %s",line,x)
        send(x)
        end
    end
    )
end

p=producer()
f=filter(p) 
consumer(f) -->基于过滤器生产者去消费，就实现了过滤器模式



trace("以协同程序实现迭代器的例子")

function permgen (a, n)  -->该函数用于遍历某个数组的所有排列组合
    n = n or #a -- default for 'n' is size of 'a'
    if n <= 1 then -- nothing to change?
        printResult(a)
    else
        for i = 1, n do
            -- put i-th element as the last one
            a[n] , a[i] = a[i] , a[n]
            -- generate all permutations of the other elements
            permgen(a, n - 1)
            -- restore i-th element
            a[n] , a[i] = a[i] , a[n]
        end
    end
end

function printResult (a)
    for i = 1, #a do
        io.write(a[i] , " ")
    end
    io.write("\n")
end

permgen({1,2,3,4})


trace("迭代器版本的实现方式")

function permgenIter(a, n)  -->将原来函数中的printresult改为yield，并将a作为输入用于在resume时返回
    n = n or #a -- default for 'n' is size of 'a'
    if n <= 1 then -- nothing to change?
        coroutine.yield(a)
    else
        for i = 1, n do
            -- put i-th element as the last one
            a[n] , a[i] = a[i] , a[n]
            -- generate all permutations of the other elements
            permgen(a, n - 1)
            -- restore i-th element
            a[n] , a[i] = a[i] , a[n]
        end
    end
end

function permutations(a)  -->将生成函数放到协同程序中，并在迭代器函数中每次迭代时去唤醒，
    local co = coroutine. create(function () permgenIter(a) end)
    return function () -- iterator
            local code, res = coroutine.resume(co)
            return res
            end
end

for p in permutations{1,2,3,4} do
    printResult(p)
end

trace("wrap封装方式")
k=coroutine.wrap(trace) -->wrap提供了对唤醒协同程序的封装，wrap返回的是一个函数，每调用该函数，相当于调用resume唤醒一次协同程序
k()
trace("非wrap封装方式")
co = coroutine.create(trace)
coroutine.resume(co)

--]]

trace("文件下载示例，非抢先多线程")

require "socket"
function download (host, file)
    local c = assert(socket.connect(host, 80))
    local count = 0 -- counts number of bytes read
    c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
    while true do
        local s, status = receive(c)
        count = count + #s
        if status == "closed" then break end
    end
    c:close()
    print(file, count)
end

function receive (connection)
    local s, status, partial = connection:receive(2^10)
    return s or partial, status
end
