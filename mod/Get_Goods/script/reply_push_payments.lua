notice_head = ".send qq"
local text = string.sub(msg.fromMsg,#"uin"+2)

local message = string.sub(text,string.find(text,"消息：")+9,"-1")

qqnums = {}
for qqnum in string.gmatch(text, "%d+") do
    table.insert(qqnums, qqnum.." ")
    eventMsg(notice_head..qqnum.." "..message, "277649597", "674037656")
    --sleepTime(000)
end
return "已向"..table.concat(qqnums).."催肾"
    