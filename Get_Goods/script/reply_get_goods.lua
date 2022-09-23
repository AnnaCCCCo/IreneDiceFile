local text = string.sub(msg.fromMsg,#"uin")
-- local qqnumN = string.find(text,"\"uin\"")
local qqnum = string.sub(text,string.find(text,"\"uin\"")+6,string.find(text,"}",string.find(text,"\"uin\""))-1)
-- local goods = string.find(text,"\"title\"")
local goods = string.sub(text,string.find(text,"\"title\"")+9,string.find(text,"\"",string.find(text,"\"title\"")+9)-1)
local pic = string.sub(text,string.find(text,"&h5=")+4,string.find(text,"\"",string.find(text,"&h5=")+4)-1)

list = {}

if(pic == "2132200")then
    table.insert(list," - 图片：暖暖")
end

if(pic == "1114200")then
    table.insert(list," - 图片：艾丽妮")
end

if(pic == "1604200")then
    table.insert(list," - 谷：国插三切页")
end

table.insert(list,"- qq号："..qqnum)
table.insert(list,"- 排："..goods)
msg.inv = table.concat(list,"\n")
--return pic
return "{reply_add_goods}"