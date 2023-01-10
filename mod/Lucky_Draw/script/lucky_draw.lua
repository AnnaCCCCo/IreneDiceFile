filename = string.match(msg.fromMsg, "^[%s]*(.-)[%s]*$", #"&抽奖" + 1)

goodsCodeFile = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAGoodsCodeList" .. msg.fromGroup .. ".txt", "r")
goodscode = goodsCodeFile:read("*a")

function at_oneself() --艾特的核心函数（
    return "{at}"
end

if string.find(goodscode, filename) then
    temp = string.sub(goodscode, string.find(goodscode, "名：" .. filename), "-1")
    length = string.sub(temp, string.find(temp, "长度：") + 9, string.find(temp, "）") - 1)
    code = string.sub(goodscode, string.find(goodscode, "名：" .. filename) - tonumber(length) - 1,
        string.find(goodscode, "名：" .. filename) - 2)

    goodsCodeFile:close()

    local filetext
    file = io.open(
        "C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\Goods_Group" .. msg.fromGroup .. "_" ..
            code .. ".csv", "r")
    filetext = file:read("*a")

    msg.goods = filename
    msg.inv = filetext
    local num = 0
    local luckyList = {}

    for line in io.lines("C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\Goods_Group" .. msg.fromGroup .. "_" ..code .. ".csv") do
        num = num+1
        table.insert(luckyList,line)
    end
    msg.num = num
    luckyMan = luckyList[ranint(1,num)]

    luckyQQ = string.sub(luckyMan,1,string.find(luckyMan,",")-1)

    msg.luckyman = "[CQ:at,qq=" .. luckyQQ .. "]"
    return "{reply_see_luckyman}"
else
    goodsCodeFile:close()
    return "没有找到" .. filename .. "的序列代码~请联系管理员设置"
end


