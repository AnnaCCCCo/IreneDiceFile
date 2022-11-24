notice_head = ".send qq"

local text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&催肾"+1)

local message = string.sub(text, 1, string.find(text,"at")-5)

local atPplGroup = string.sub(text, string.find(text,"at"), string.find(text,"image"))

local image = string.sub(text, string.find(text,"image")-4)

qqnums = {}
for qqnum in string.gmatch(atPplGroup, "%d+") do
    table.insert(qqnums, qqnum.." ")
    eventMsg(notice_head..qqnum.." "..message..image, msg.fromGroup, "674037656")
    sleepTime(5000)
end

return "已向"..table.concat(qqnums).."催肾"