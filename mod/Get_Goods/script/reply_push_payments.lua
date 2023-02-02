notice_head = ".send qq"

local text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&催肾"+1)

local message = string.sub(text, 1, string.find(text,"at")-5)

local atPplGroup = string.sub(text, string.find(text,"at"), string.find(text,"image"))

if string.find(text,"image") then
    image = string.sub(text, string.find(text,"image")-4)
end
sendMsg("艾丽妮已收到！正在小窗中...", msg.fromGroup, nil)

qqnums = {}
for qqnum in string.gmatch(atPplGroup, "%d+") do
    table.insert(qqnums, qqnum)
    if string.find(text,"image") then
        eventMsg(notice_head..qqnum.." "..message..image, msg.fromQQ, "674037656")
    else
        eventMsg(notice_head..qqnum.." "..message, msg.fromQQ, "674037656")
    end
    
    ransleep = ranint(0,5000)
    sleepTime(5000 + ransleep)
end

return "已向"..table.concat(qqnums," ").."催肾"

