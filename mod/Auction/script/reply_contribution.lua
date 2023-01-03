local text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&拍卖投稿"+1)

-- http = require("socket.http")
filename = string.sub(text, "1", string.find(text,"卖家cn")-2)

if string.find(text,"image") then
    image = string.sub(text, string.find(text,"image")-4)
    if image:match("%[CQ:image(.*)http") then
        imageHttp = image:match("https?://(.*)%]")
    else
        imageHttp = "https://gchat.qpic.cn/gchatpic_new/0/0-0-"..image:match("{(.*)}"):gsub("-","").."/0"
    end
end

cn = string.sub(text, string.find(text,"卖家cn")+11, string.find(text,"物品企划名")-2)
ip = string.sub(text, string.find(text,"物品企划名")+18, string.find(text,"物品柄名")-2)
goods = string.sub(text, string.find(text,"物品柄名")+15, string.find(text,"物品状态")-2)
status = string.sub(text, string.find(text,"物品状态")+15, string.find(text,"起拍价")-2)
startPrice = string.sub(text, string.find(text,"起拍价")+12, string.find(text,"有/无流")-2)
endPrice = string.sub(text, string.find(text,"有/无流")+31, string.find(text,"邮费")-2)
mail = string.sub(text, string.find(text,"邮费")+31, string.find(text,"物品照片")-2)

local file = io.open("C:\\Users\\Administrator\\OneDrive\\Auction\\"..filename..".csv", "a+")
file:write(cn,",",ip,",",goods,",",status,",",startPrice,",",endPrice,",",mail,",",imageHttp,"\n")

file:close()

return "1"

--卖家cn：晚钟\n物品企划名：bang dream\n物品柄名：五周年kv\n物品状态：99新\n起拍价：15r\n有/无流（有流流价）：30r流\n邮费（包邮/不包邮）：不包邮\n物品照片（吧唧需要正反面）：