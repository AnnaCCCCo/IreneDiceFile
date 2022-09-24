local text = string.sub(msg.fromMsg,#"uin")
-- local qqnumN = string.find(text,"\"uin\"")
local qqnum = string.sub(text,string.find(text,"\"uin\"")+6,string.find(text,"}",string.find(text,"\"uin\""))-1)
-- local goods = string.find(text,"\"title\"")
local goods = string.sub(text,string.find(text,"\"title\"")+9,string.find(text,"\"",string.find(text,"\"title\"")+9)-1)
--local pic = string.sub(text,string.find(text,"&h5=")+4,string.find(text,"\"",string.find(text,"&h5=")+4)-1)
local temp = string.sub(text,string.find(text,"\"pics\""),"-1")--,string.find(text,"?w5=",string.find(text,"qun-qungz")+10)-1)
local temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
local pic = string.sub(temp,string.find(temp,"/")+1,string.find(temp,"!!")-1)


local cnString = getGroupConf(msg.fromGroup,"card#"..msg.fromQQ,"")
local cn = cnString
if string.find(cnString,"（") then
    cn = string.sub(cnString,string.find(cnString,"】")+3,string.find(cnString,"（")-1)
else if string.find(cnString,"-")then
    cn = string.sub(cnString,string.find(cnString,"】")+3,string.find(cnString,"-")-1)
else if string.find(cnString,"】")then
    cn = string.sub(cnString,string.find(cnString,"】")+3)
else
    cn = cnString
end
end
end

if (msg.fromQQ == "2770269826")then
    cn = "京墨"
end

if (msg.fromQQ == "2356057513")then
    cn = "玉霖生"
end

if (msg.fromQQ == "2176452830")then
    cn = "蓝山"
end

list = {}
local goodsname = pic

goodsCodeFile = io.open("Dice1208585235\\Lists\\AAAGoodsCodeList.txt", "r")
goodscode = goodsCodeFile:read("*a")

if string.find(goodscode, pic)then
    temp = string.sub(goodscode,string.find(goodscode, pic)+36)--,string.find(goodscode,"）"))
    goodsname = string.sub(temp, "1", string.find(temp,"）")-1)
end

goodsCodeFile:close()

msg.goodsname = pic
--return "已记入本地文档：Goods_"..goodsname..".txt"
if(goods ~= "yp" and goods ~= "db" and goods ~= "tt" and goods ~= "getcode")then

    table.insert(list,"- qq号："..qqnum)
    table.insert(list,"- cn："..cn)
    table.insert(list,"- 排："..goods)

    fileList = {}
    table.insert(fileList," - qq号："..qqnum)
    table.insert(fileList," - cn："..cn)
    table.insert(fileList," - 排："..goods)

    local file = io.open("Dice1208585235\\Lists\\Goods_"..pic..".txt", "a+")
    file:write(table.concat(fileList), "\n")
    file:close()

    pc = getPlayerCard(msg.uid,msg.gid or 0)
    local personalList = pc._Inventory or {}
    local backpack = goodsname.." 的 "..goods
    table.insert(personalList, {name=backpack})
    pc._Inventory = personalList
    msg.inv = table.concat(list,"\n")
    return "{reply_add_goods}"
    --return goodsname
else if(goods == "yp")then
    msg.cn = cn
    return "{reply_add_yp}"
else if(goods == "db")then
    msg.cn = cn
    return "{reply_add_db}"
else if(goods == "tt")then
    return "妈咪这边排~"
else if(goods == "getcode")then
    return pic
end
end
end
end
end