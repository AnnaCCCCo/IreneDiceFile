local text = string.sub(msg.fromMsg,#"uin")

local qqnum = string.sub(text,string.find(text,"\"uin\"")+6,string.find(text,"}",string.find(text,"\"uin\""))-1)

local goods = string.sub(text,string.find(text,"\"title\"")+9,string.find(text,"\"",string.find(text,"\"title\"")+9)-1)

local temp = string.sub(text,string.find(text,"\"pics\""),"-1")
local temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
local temp = string.sub(temp,string.find(temp,"/")+1,"-1")
local pic = string.sub(temp,"1",string.find(temp,"!!")-1)

if string.find(pic,"*") then
    pic = string.sub(pic,"1",string.find(pic,"*")-1)
end

cnString = getGroupConf(msg.fromGroup,"card#"..msg.fromQQ,"")
cn = ""
--cnstring = getUserConf(msg.fromQQ,"nick#"..msg.fromGroup,"")
--cn = cnString
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

list = {}
local goodsname = "[某种谷子]"

goodsCodeFile = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAGoodsCodeList"..msg.fromGroup..".txt", "r")
goodscode = goodsCodeFile:read("*a")

if string.find(goodscode, pic)then
    temp = string.sub(goodscode,string.find(goodscode, pic)+string.len(pic)+7)--,string.find(goodscode,"）"))
    goodsname = string.sub(temp, "1", string.find(temp," 长度：")-1)
end

goodsCodeFile:close()

msg.goodsname = pic
--return "已记入本地文档：Goods_"..goodsname..".txt"
if goodsname ~= "[某种谷子]" then
    if(goods ~= "yp" and goods ~= "db" and goods ~= "tt" and goods ~= "t" and goods ~= "getcode")then

        table.insert(list,"- qq号："..msg.fromQQ)
        table.insert(list,"- cn："..cn)
        table.insert(list,"- 排："..goodsname.."："..goods)

        if(string.find(goodsname,"妈位")) then
            if (string.find(goodsname,"转位")) then
                msg.inv = goods;
                return "{reply_move_force}"
            end
            msg.inv = table.concat(list,"\n")
            return "{reply_add_force}"
        else if (string.find(goodsname,"肾表")) then
            msg.cn = cn;
            msg.goods = goodsname;
            return "{reply_pay_money}"
        else
            filelist = {}
            table.insert(filelist,"- "..msg.fromQQ)
            table.insert(filelist,"- "..cn)
            table.insert(filelist,"- "..goods)
            local file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\"..msg.fromGroup.."\\Goods_Group"..msg.fromGroup.."_"..pic..".txt", "a+")
            file:write(table.concat(filelist), "\n")
            file:close()

            local backpack = " - 群："..msg.fromGroup.."，谷："..goodsname.."："..goods
            
            local file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\Personal\\"..msg.fromQQ..".txt", "a+")
            file:write(backpack, "\n")
            file:close()
            
            msg.inv = table.concat(list,"\n")
            
            pc = getPlayerCard(msg.uid,msg.gid or 0)
            local personalList = pc._Inventory or {}
            table.insert(personalList, {name=backpack})
            pc._Inventory = personalList
            return "{reply_add_goods}"
        end
        end
    else if(goods == "yp")then
        msg.cn = cn
        msg.goodsname = goodsname
        return "{reply_add_yp}"
    else if(goods == "db")then
        msg.cn = cn
        msg.goodsname = goodsname
        return "{reply_add_db}"
    else if(goods == "tt" or goods == "t")then
        return "妈咪这边排~"
    else if(goods == "getcode")then
        return pic
end
end
end
end
end
end