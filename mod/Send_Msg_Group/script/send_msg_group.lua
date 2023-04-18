notice_head = ".send group"

local text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&推车"+1)

local time = string.sub(text, 1, string.find(text,"image")-5)

--if string.find(text,"image") then
    image = string.sub(text, string.find(text,"image")-4)
--end
sendMsg("艾丽妮已收到！正在准备开始推车，间隔"..time.."分钟，总计时长12h", msg.fromGroup, nil)

local groupnum = 667546784
local mstime = time * 60 * 1000
local htotaltime = 12 * 60

for i = 1, htotaltime, 30 do
    eventMsg(notice_head..groupnum.." "..image, msg.fromQQ, "674037656")
    ransleep = ranint(0,5*60*1000)
    sleepTime(mstime + ransleep)
end

return "今天的推车结束啦"

