--仿MDice决斗.duel指令脚本
--作者:安研色Shiki
--本文件仅供学习交流之用
msg_order = {} 

function intostring(num)
    if(num==nil)then
        return ""
    end
    return string.format("%.0f",num)
end

reply_duel_win = {
    "不服？不服你就正面赢我啊",
    "你请我吃顿饭这次就算你赢，怎么样？",
    "哦吼？我觉得我甚至可以让你一个骰子",
    "（面露笑意地看着你）",
    "你觉得能赢我，嘿嘿，那是个幻觉，美丽的幻觉。",
    "再试也没用啦，会输一次就会输一百次哦",
}
reply_duel_lose = {
    "？！居然趁我一时大意。。。"
}
reply_duel_even = {
    "哼哼，平分秋色嘛"
}
function table_draw(tab)
    return tab[ranint(1,#tab)]
end

--惠系决斗
function mdice_duel(msg)
    local isDark=string.sub(msg.fromMsg,1,5)==".dark"
    local poolSelf, poolPlayer = {},{}
    local resSelf, resPlayer, resTotal, resEval = "","","",""
    local sumSelf, sumPlayer, sumTotal=0,0,0
    for times=1, 5 do
        local die = ranint(1,100)
        sumSelf = sumSelf + die
        table.insert(poolSelf,intostring(die))
    end
    resSelf="\n{self}\n"..table.concat(poolSelf,'、').."\n打点"..intostring(sumSelf)
    for times=1, 5 do
        local die = ranint(1,100)
        sumPlayer = sumPlayer + die
        table.insert(poolPlayer,intostring(die))
    end
    resPlayer="\n{pc}\n"..table.concat(poolPlayer,'、').."\n打点"..intostring(sumPlayer)
    sumTotal = sumPlayer-sumSelf;
    resTotal="\n————\n计"..intostring(sumTotal).."/10="..intostring(sumTotal/10).."分"
    if(sumSelf>sumPlayer)then
        if(isDark)then
            resEval="发起黑暗决斗的你，应该做好觉悟了吧？"
            --好孩子不要用 eventMsg(".group ".. intostring(msg.fromGroup) .." ban ".. intostring(msg.fromQQ) .." "..intostring(sumSelf), 0, getDiceQQ())
        else
            resEval=table_draw(reply_duel_win)
        end
    elseif(sumSelf<sumPlayer)then
        resEval = table_draw(reply_duel_lose)
    else
        resEval = table_draw(reply_duel_even)
    end
    local reply = "看起来{pc}想向我发起决斗，呼呼，那我就接下了\n胜负的结果是——"..resSelf..resPlayer..resTotal.."\n"..resEval
    return reply --如有返回值表示回复文本，如有第二返回值表示暗骰文本
end
msg_order[".dark duel"] = "mdice_duel"
msg_order[".duel"] = "mdice_duel"
--指令注册格式 key->指令前缀 value->脚本内函数名