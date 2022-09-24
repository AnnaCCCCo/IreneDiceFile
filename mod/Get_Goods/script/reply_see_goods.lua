goodname = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"看看手速排表"+1)

local code = goodname

--if(filename == "国插三")then
--    goodsname = "V5bCQAyNzc2NDk1OTd.fCpj09ZQMA"
--else if (filename == "国插三特典")then
--    goodsname = "V5bCQAyNzc2NDk1OTc1fSpjpVh9AA"
--end
--end

goodsCodeFile = io.open("Dice1208585235\\Lists\\AAAGoodsCodeList.txt", "r")
goodscode = goodsCodeFile:read("*a")

if string.find(goodscode, goodname)then
    code = string.sub(goodscode,string.find(goodscode,"名："..goodname)-30,string.find(goodscode,"名："..goodname)-2)

    goodsCodeFile:close()

    local filetext
    file = io.open("Dice1208585235\\Lists\\"..msg.fromGroup.."\\Goods_"..code..".txt", "r")
    filetext = file:read("*a")
    msg.goods = goodname
    msg.inv = filetext
    
    return "{reply_see_goods}"
else
    goodsCodeFile:close()
    return "没有找到"..goodname.."的序列代码~请联系管理员设置"
end

--return code
