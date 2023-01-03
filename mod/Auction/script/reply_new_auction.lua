local text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&新建拍卖"+1)

local name = string.sub(text, "1",string.find(text,"image")-5)

local image = string.sub(text, string.find(text,"image")-4)
local imageHttp = "https://gchat.qpic.cn/gchatpic_new/0/0-0-"..image:match("{(.*)}"):gsub("-","").."/0"

local file = io.open("C:\\Users\\Administrator\\OneDrive\\Auction\\"..name..".csv", "a+")
file:write("本次拍卖肾码：",imageHttp,"\n")
file:write("\n")
file:write("卖家cn,物品企划名,物品柄名,物品状态,起拍价,有/无流,邮费,物品照片","\n")

file:close()

msg.inv = name

return "{reply_new}"