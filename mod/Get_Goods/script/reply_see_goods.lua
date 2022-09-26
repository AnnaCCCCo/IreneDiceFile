goodname = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"看看手速排表"+1)

local code = goodname

goodsCodeFile = io.open("Dice1208585235\\Lists\\AAAGoodsCodeList.txt", "r")
goodscode = goodsCodeFile:read("*a")

if string.find(goodscode, goodname)then
    temp = string.sub(goodscode,string.find(goodscode,"名："..goodname),"-1")
    length = string.sub(temp,string.find(temp,"长度：")+9,string.find(temp,"）")-1)
    code = string.sub(goodscode,string.find(goodscode,"名："..goodname)-tonumber(length)-1,string.find(goodscode,"名："..goodname)-2)

    goodsCodeFile:close()

    local filetext
    file = io.open("Dice1208585235\\Lists\\"..msg.fromGroup.."\\Goods_Group"..msg.fromGroup.."_"..code..".txt", "r")
    filetext = file:read("*a")
    msg.goods = goodname
    msg.inv = filetext
    
    return "{reply_see_goods}"
else
    goodsCodeFile:close()
    return "没有找到"..goodname.."的序列代码~请联系管理员设置"
end