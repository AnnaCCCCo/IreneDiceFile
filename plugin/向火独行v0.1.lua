msg_order = {}

intro_flame = [[
COC7版单人冒险书《向火独行(ALONE AGAINST THE FLAMES)》
Dice!脚本化v0.1
原书译者：粉毛提督七宫涟
脚本整理：安研色Shiki
本模组会在导入过程完成快速车卡，事先只需使用.pc new COC7:[调查员姓名]创建新卡即可
游玩过程中请根据提示纯手动翻页，指令为.flame [页码]
如果{nick}已准备好从头开始游戏，请输入.flame 1]]

function flame_simple(msg)
    local idx_page = string.match(msg.fromMsg,"%d+")
    if(not idx_page)then
        return intro_flame
    else
        local idx = tonumber(idx_page)
        if(idx>270)then
            return "页码错误：不存在的页码×"
        end
        local DiceQQ = string.format("%d",getDiceQQ())
        require("Dice"..DiceQQ.."\\plugin\\ALONE_AGAINST_THE_FLAMES\\text");
        return text[idx]
    end
end
msg_order[".flame"] = "flame_simple"