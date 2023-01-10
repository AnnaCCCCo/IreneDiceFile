name = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"设置谷子名称"+1)
goodscode = string.sub(name, "1",string.find(name,"名：")-2)
goodsname = string.sub(name, string.find(name,"名：")+6)

local filetext
file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAGoodsCodeList"..msg.fromGroup..".txt", "a+")
file:write(name, " 长度："..string.len(goodscode).."）\n")
file:close()
msg.goodscode = goodscode
msg.goodname = goodsname

local file = io.open(
    "C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\Goods_Group" .. msg.fromGroup ..
        "_" .. goodscode .. ".csv", "a+")

--return goodsname
return "{reply_set_goodscode}"