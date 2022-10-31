local text = string.sub(msg.fromMsg,#"uin")

local temp = string.sub(text,string.find(text,"\"pics\""),"-1")
local temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
local temp = string.sub(temp,string.find(temp,"/")+1,"-1")
local pic = string.sub(temp,"1",string.find(temp,"!!")-1)

if string.find(pic,"*") then
    pic = string.sub(pic,"1",string.find(pic,"*")-1)
end

-- local filetext
-- file = io.open("Dice1208585235\\Lists\\AAAGoodsCodeList"..msg.fromGroup..".txt", "a+")
-- file:write(pic.." 名：忽略".." 长度："..string.len(pic).."）\n")
-- file:close()
msg.goodscode = pic

return "{reply_upload_pics}"
