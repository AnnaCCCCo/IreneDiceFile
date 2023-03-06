local text = string.sub(msg.fromMsg, #"uin")

if string.find(text, "reportCompass") then
    local temp = string.sub(text, string.find(text, "reportCompass"), "-1")
    temp = string.sub(temp, string.find(temp, "uin") + 5, "-1")
    local reciv = string.sub(temp, "1", string.find(temp, "}}") - 1)

    local goods = string.sub(text, string.find(text, "\"title\"") + 9,
        string.find(text, "\"", string.find(text, "\"title\"") + 9) - 1)

    local temp = string.sub(text, string.find(text, "\"pics\""), "-1")
    local temp = string.sub(temp, string.find(temp, "qungz/") + 6, "-1")
    local pic = string.sub(temp, string.find(temp, "/") + 1, string.find(temp, "!!") - 1)

    if string.find(pic, "*") then
        pic = string.sub(pic, "1", string.find(pic, "*") - 1)
    end

    goodsCodeFile = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAGoodsCodeList" .. msg.fromGroup .. ".txt",
        "r")
    goodscode = goodsCodeFile:read("*a")

    if string.find(goodscode, pic) then
        temp = string.sub(goodscode, string.find(goodscode, pic) + string.len(pic) + 7) -- ,string.find(goodscode,"）"))
        goodsname = string.sub(temp, "1", string.find(temp, " 长度：") - 1)
    end

    goodsCodeFile:close()

    msg.goodsname = goodsname
    if string.find(goods, "已发") then
        if string.find(goodsname, "排发货") then
            local num = 0
            local parcelList = {}

            for line in io.lines("C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\Goods_Group" ..
                                     msg.fromGroup .. "_" .. pic .. ".csv") do
                if string.find(line, reciv) then
                    msg.reciv = reciv
                else
                    num = num + 1;
                    table.insert(parcelList, line)
                end
            end

            file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\Goods_Group" ..
                               msg.fromGroup .. "_" .. pic .. ".csv", "w")
            file:write(table.concat(parcelList, "\n"))
            msg.num = num
            return "{reply_sent_parcels}"
        else
            return nil
        end
        -- return 22
    end
end

