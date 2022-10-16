local text = string.sub(msg.fromMsg,#"uin")

local goods = string.sub(text,string.find(text,"\"title\"")+9,string.find(text,"\"",string.find(text,"\"title\"")+9)-1)

local temp = string.sub(text,string.find(text,"\"pics\""),"-1")
local temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
local pic = string.sub(temp,string.find(temp,"/")+1,string.find(temp,"!!")-1)

if string.find(pic,"*") then
    pic = string.sub(pic,"1",string.find(pic,"*")-1)
end

goodsCodeFile = io.open("Dice1208585235\\Lists\\AAAGoodsCodeList"..msg.fromGroup..".txt", "r")
goodscode = goodsCodeFile:read("*a")

if string.find(goodscode, pic)then
    temp = string.sub(goodscode,string.find(goodscode, pic)+string.len(pic)+7)--,string.find(goodscode,"）"))
    goodsname = string.sub(temp, "1", string.find(temp," 长度：")-1)
end

goodsCodeFile:close()

cnString = getGroupConf(msg.fromGroup,"card#"..msg.fromQQ,"")
--cnstring = getUserConf(msg.fromQQ,"nick#"..msg.fromGroup,"")
cn = ""
if (string.find(cnString,"】") and string.find(cnString,"（")) then
    cn = string.sub(cnString,string.find(cnString,"】")+3,string.find(cnString,"（")-1)
else if (string.find(cnString,"】") and string.find(cnString,"-"))then
    cn = string.sub(cnString,string.find(cnString,"】")+3,string.find(cnString,"-")-1)
else if string.find(cnString,"】")then
    cn = string.sub(cnString,string.find(cnString,"】")+3)
else
    cn = cnString
end
end
end

if cn == "" then
    cn = getUserConf(msg.fromQQ,"name","")
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

msg.goodsname = goodsname

if string.find(goods, "接") then
    temp = string.sub(text,string.find(text,"\"title\""),"-1")
    origin = string.sub(temp, string.find(temp,"\"uin\"")+6,string.find(temp,"}")-1)

    if string.find(goodsname, "妈位转位") then
        msg.cn = cn
        return "{reply_get_move_force}"
    else
        local file = io.open("Dice1208585235\\Lists\\"..msg.fromGroup.."\\Goods_Group"..msg.fromGroup.."_"..pic..".txt", "a+")
        file:write("【"..msg.fromQQ.."，cn："..cn.."，接了"..origin.."的转单】\n")
        file:close()

        msg.cn = cn
        msg.origin = origin
        --return origin
        return "{reply_move_goods}"
    end
else if string.find(goods, "撤") then
    local file = io.open("Dice1208585235\\Lists\\"..msg.fromGroup.."\\Goods_Group"..msg.fromGroup.."_"..pic..".txt", "a+")
    file:write("【- "..msg.fromQQ.." - cn："..cn.." "..goods.."】\n")
    file:close()
    msg.cn = cn
    return "{reply_del_goods}"
end
end