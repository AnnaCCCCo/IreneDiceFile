--[[
    @Author RainChain-Zero
    @Version 1.0
    @Last Modified 2022/08/12 23:36
    @Description 先攻、行动圈顺序表
]]
msg_order = {}

--[[
    录入当前行动条长度
    一人一群一长度
    默认500
]]
function action_set(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local length = string.match(msg.fromMsg, "(%d+)")
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    actionBar.length = tonumber(length or 500)
    setGroupConf(msg.fromGroup, "actionBar", actionBar)
    return "『SUCCESS』{self}已设置当前群聊行动圈长度为：" .. actionBar.length
end
msg_order[".acl"] = "action_set"

--[[
    玩家通过指令录入先攻值,.ac 玩家名（唯一） 先攻值
]]
function action_start(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    -- 玩家名中不能有+、-、空格
    local nameRcv, signRcv, numRcv
    local idx = string.find(msg.fromMsg, "[%+%-]")
    if not idx then
        nameRcv, numRcv = string.match(msg.fromMsg, "[%s]*(.+)[%s]+(%d+)", #".ac" + 1)
    else
        -- local tmp = string.sub(msg.fromMsg, idx)
        -- signRcv = string.sub(tmp, 1, 1)
        -- numRcv = string.match(tmp, "(%d+)")
        nameRcv, signRcv, numRcv = string.match(msg.fromMsg, "[%s]*(.+)[%s]+([%+%-]+)[%s]*(%d+)", #".ac" + 1)
    end
    if not nameRcv then
        return "『ERROR』要告诉{self}正确的玩家名才可以哦？"
    end
    if not numRcv then
        return "『ERROR』好像没有找到正确的先攻数值呢...要不再检查一下？"
    end
    --[[
        一个群对应一个actionBar的table
        {
            length = "行动条长度:number，默认500",
            players = {
                name1 = {
                    speed = "先攻值：number",
                    distance = "行动条"
                },
                name2 = {
                    speed = "先攻值：number",
                    distance = "行动条"
                }
            }
            waiting_stack = {}
        }
    ]]
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    -- 空值检验
    if not actionBar.players then
        actionBar.players = {}
    end
    if not actionBar.players[nameRcv] then
        actionBar.players[nameRcv] = {}
    end
    -- 行动圈距离
    actionBar.players[nameRcv].distance = actionBar.players[nameRcv].distance or 0
    -- 直接录入新的先攻值
    if not signRcv then
        -- 修订原先的先攻值
        actionBar.players[nameRcv].speed = tonumber(numRcv)
    else
        if not actionBar.players[nameRcv].speed then
            return "『ERROR』好像...不存在先攻值的说，没办法修正哦"
        end
        if signRcv == "+" then
            actionBar.players[nameRcv].speed = actionBar.players[nameRcv].speed + numRcv
        elseif signRcv == "-" then
            actionBar.players[nameRcv].speed = actionBar.players[nameRcv].speed - numRcv
        end
    end
    local length = actionBar.length or 500
    actionBar.length = length
    local speed = actionBar.players[nameRcv].speed
    if speed < 0 then
        return "『ERROR』先攻值可不能小于0诶..."
    end
    setGroupConf(msg.fromGroup, "actionBar", actionBar)
    return "『SUCCESS』{self}已为您录入先攻值，当前先攻值为" .. actionBar.players[nameRcv].speed
end
msg_order[".ac"] = "action_start"

-- 中途删除玩家
function action_del(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    if not actionBar.players then
        return "『ERROR』当前群聊中还不存在任何玩家的先攻值哦？"
    end
    local str = string.match(msg.fromMsg, "[%s]*(.*)", #".ac del" + 1)
    if not str then
        return "『ERROR』诶？这里是需要输入待移除的玩家列表的"
    end
    local players = split(str, "%s+")
    for _, v1 in pairs(players) do
        -- 从玩家列表移出对应玩家
        for k2, _ in pairs(actionBar.players) do
            if v1 == k2 then
                actionBar.players[k2] = nil
                break
            end
        end
        -- 从等待栈中移除玩家
        for k3, v3 in pairs(actionBar.waiting_stack or {}) do
            if v1 == v3 then
                table.remove(actionBar.waiting_stack, k3)
            end
        end
    end

    setGroupConf(msg.fromGroup, "actionBar", actionBar)
    return "『SUCCESS』{self}已将" .. #players .. "位玩家移出本群先攻列表"
end
msg_order[".ac del"] = "action_del"

-- 下一位行动的玩家
function action_next(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    if not actionBar.players then
        return "『ERROR』当前群聊中还不存在任何玩家的先攻值哦？"
    end
    -- 查看当前等待栈
    local waiting_stack = actionBar.waiting_stack or {}
    if #waiting_stack >= 1 then
        local now = waiting_stack[1].name
        table.remove(waiting_stack, 1)
        actionBar.waiting_stack = waiting_stack
        setGroupConf(msg.fromGroup, "actionBar", actionBar)
        return "下一位该行动的是...唔，是" .. now .. "！"
    end
    -- 行动圈长度默认500
    local length = actionBar.length or 500
    -- 防止恶意大循环
    local times = 0
    while true do
        -- 当前有人能到达终点的集合，{name="玩家名",time="耗时:number"}
        local waiting = {}
        -- 查看跑完一次是否有人能到达终点
        for k, _ in pairs(actionBar.players) do
            local diff = length - actionBar.players[k].distance
            actionBar.players[k].distance = actionBar.players[k].distance + actionBar.players[k].speed
            if actionBar.players[k].distance >= length then
                local speed = actionBar.players[k].speed
                actionBar.players[k].distance = actionBar.players[k].distance % length
                table.insert(waiting, {name = k, speed = speed, time = diff / speed})
            end
        end
        if #waiting >= 1 then
            --[[
                先比较到达时间，先到达排前
                到达时间相同时，比较速度，速度大的排前
            ]]
            table.sort(
                waiting,
                function(a, b)
                    if a.time == b.time then
                        return a.speed > b.speed
                    end
                    return a.time < b.time
                end
            )
            local now = waiting[1].name
            table.remove(waiting, 1)
            actionBar.waiting_stack = waiting
            setGroupConf(msg.fromGroup, "actionBar", actionBar)
            return "下一位该行动的是...唔，是" .. now .. "！"
        end
        times = times + 1
        if times > 1e4 then
            sendMsg(
                "『WARNING』" ..
                    getUserConf(msg.fromQQ, "nick", "用户") ..
                        "(" .. msg.fromQQ .. ")在" .. getGroupConf(msg.fromGroup, "name", "私聊") .. "疑似恶意让{self}进入大数循环",
                0,
                3032902237
            )
            return "『WARNING』检测到数据异常，您疑似使{self}进入大数循环，已通知管理员..."
        end
    end
end
msg_order[".ac next"] = "action_next"

-- 展示当期行动圈
function action_show(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    local res = "当前行动次序，按照行动圈规则的话...让{self}看看...\n行动圈长度为" .. (actionBar.length or 500)
    if not actionBar.players then
        return "『ERROR』当前群中不存在玩家的先攻值信息哦~"
    end
    for k, v in pairs(actionBar.players) do
        res = res .. "\n" .. k .. "：目前累计" .. v.distance .. "，先攻值：" .. v.speed
    end
    res = res .. "\n当前等待："
    for i = 1, #(actionBar.waiting_stack or {}), 1 do
        res = res .. actionBar.waiting_stack[i].name .. " "
    end
    return res
end
msg_order[".ac show"] = "action_show"

-- 展示当前先攻的功能次序（普通）
function action_list(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    local players = {}
    if not actionBar.players then
        return "『ERROR』咦...当前群聊中好像没有一——条先攻信息诶！"
    end
    for k, v in pairs(actionBar.players) do
        table.insert(players, {name = k, speed = v.speed})
    end
    -- 按先攻值从大到小排序
    table.sort(
        players,
        function(a, b)
            return a.speed > b.speed
        end
    )
    local res = "当前行动次序，按照普通先攻规则的话...让{self}看看..."
    for i = 1, #players, 1 do
        res = res .. "\n" .. i .. "." .. players[i].name .. "：先攻值：" .. players[i].speed
    end
    return res
end
msg_order[".ac list"] = "action_list"

-- 重置本群行动轮次序
function action_reset(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    local actionBar = getGroupConf(msg.fromGroup, "actionBar", {})
    if not actionBar.players then
        return "『ERROR』当前群聊中还不存在任何玩家的先攻值哦？"
    end
    -- 清空玩家累计
    for k, _ in pairs(actionBar.players) do
        actionBar.players[k].distance = 0
    end
    -- 清空等待栈
    actionBar.waiting_stack = {}
    setGroupConf(msg.fromGroup, "actionBar", actionBar)
    return "『SUCCESS』{self}已经重置了本群的行动轮次序√"
end
msg_order[".ac reset"] = "action_reset"

-- 清除本群行动条
function action_clear(msg)
    if msg.fromGroup == "0" then
        return "『ERROR』这条指令只能在群聊中使用哦？"
    end
    setGroupConf(msg.fromGroup, "actionBar", nil)
    return "『SUCCESS』1 2 3...本群的先攻信息已经清空了哦"
end
msg_order[".ac clr"] = "action_clear"

-- 字符串分割函数
function split(szFullString, szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray, nSeparatorArray = {}, {}
    while true do
        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
        if not nFindLastIndex then
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
            break
        end
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
        --nFindStartIndex = nFindLastIndex + string.len(szSeparator)
        nFindStartIndex = nFindLastIndex + 1
        nSeparatorArray[nSplitIndex] = string.sub(szFullString, nFindLastIndex, nFindLastIndex)
        nSplitIndex = nSplitIndex + 1
    end
    return nSplitArray, nSeparatorArray
end
