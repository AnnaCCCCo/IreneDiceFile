--数字炸弹
--作者：落长安Angelina973
--version v1.2 2022-06-16
msg_order={}
Playerlist={}
function getTableContent(obj) --用于打印玩家列表
    local getIndent, quoteStr, wrapKey, wrapVal, isArray, dumpObj
    getIndent = function(level)
        return string.rep("\t", level)
    end
    quoteStr = function(str)
        str = string.gsub(str, "[%c\\\"]", {
            ["\t"] = "\\t",
            ["\r"] = "\\r",
            ["\n"] = "\\n",
            ["\""] = "\\\"",
            ["\\"] = "\\\\",
        })
        return "[CQ:at,qq=" .. str .. "]\n"
    end
    wrapKey = function(val)
        if type(val) == "number" then
            return "『" .. val .. "』"
        elseif type(val) == "string" then
            return "『" .. quoteStr(val) .. "』"
        else
            return "『" .. tostring(val) .. "』"
        end
    end
    wrapVal = function(val, level)
        if type(val) == "table" then
            return dumpObj(val, level)
        elseif type(val) == "number" then
            return val
        elseif type(val) == "string" then
            return quoteStr(val)
        else
            return tostring(val)
        end
    end
    local isArray = function(arr)
        local count = 0
        for k, v in pairs(arr) do
            count = count + 1
        end
        for i = 1, count do
            if arr[i] == nil then
                return false
            end
        end
        return true, count
    end
    dumpObj = function(obj, level)
        if type(obj) ~= "table" then
            return wrapVal(obj)
        end
        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "玩家列表:\n"
        local ret, count = isArray(obj)
        if ret then
            for i = 1, count do
                tokens[#tokens + 1] = getIndent(level) .. wrapVal(obj[i], level) .. ""
            end
        else
            for k, v in pairs(obj) do
                tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. "：" .. wrapVal(v, level) .. ""
            end
        end
        tokens[#tokens + 1] = getIndent(level - 1) ..""
        return table.concat(tokens, "\n")
    end
    return dumpObj(obj, 0)
end
function integer(num)  --取整
    if(num==nil)then
        return ""
    end
    return string.format("%.0f",num)
end
function shuffle(t)
    if type(t)~="table" then
        return
    end
    local tab={}
    local index=1
    while #t~=0 do
        local n=ranint(0,#t)
        if t[n]~=nil then
            tab[index]=t[n]
            table.remove(t,n)
            index=index+1
        end
    end
    return tab --打乱顺序，使用了shiki的ranint而非mathrandom，也许会有更好的随机效果？
end
function getnum(str) --简子姐的 getatqq，用来取数字
  local n = tonumber(str)
  if n then
    return str
  else
    return tonumber(string.match(str,"%d+"))
  end
end

function gameprepare(msg) --游戏初始化（开始）
    if msg.fromGroup == "0" then --判断是否是私聊环境,注：必须有引号否则将被视为nil
        if getUserConf(msg.fromQQ,"Stage",0) ~= 0 then
            return "当前已在游戏中。"
        else
            setUserConf(msg.fromQQ,"Stage",1)
            setUserConf(msg.fromQQ,"boobmax",nil)
            setUserConf(msg.fromQQ,"boobmin",1)
            local key = ranint(0,getUserConf(msg.fromQQ,"boobrange",300))
            setUserConf(msg.fromQQ,"boobkey",key)
        sendMsg("游戏开始\n本轮游戏范围：1 —— "..getUserConf(msg.fromQQ,"boobrange",300).." \n请在游戏结束后使用【数字指定key】来设置范围，范围将被记录为默认值，无须重复设置。例：数字指定1000。{FormFeed}单人游戏无回答限时，现在可以直接开始回答数字。结束请发送【数字炸弹结束】。",msg.fromGroup,msg.fromQQ)
        return "\n数字炸弹启动...私聊模式无须加入游戏.."
        end
    else
        if getGroupConf(msg.fromGroup,"Stage",0) == 0 then
        setGroupConf(msg.fromGroup,"Stage",1)
        setGroupConf(msg.fromGroup,"boobmax",nil)
        setGroupConf(msg.fromGroup,"boobmin",nil)
        setGroupConf(msg.fromGroup,"boobanswer",nil)
        setGroupConf(msg.fromGroup,"boobrange",nil)
        setGroupConf(msg.fromGroup,"PlayerCount",1)
        setGroupConf(msg.fromGroup,"isanswer",0)
        Playerlist[1] = msg.fromQQ
        setGroupConf(msg.fromGroup,"NumBPlayer",Playerlist) --以 table 型保存
        return "※※※准备阶段※※※:\n【加入数字炸弹】\n【退出数字炸弹】\n【数字指定+数字】(指定本局上限，默认人数*1000，例：数字指定300)\n【数字炸弹准备就绪】（开始游戏）\n【数字炸弹结束】"..getTableContent(Playerlist)
        else
            return "当前已经处于游戏进程中，发送【数字炸弹结束】结束游戏。"
        end
    end
end
msg_order["数字炸弹启动"]="gameprepare"

function gamejoin(msg)
    if msg.fromGroup == "0" then
        return "私聊模式无须加入游戏，请直接发送【数字炸弹启动】开始游戏。"
    end
    QQ = msg.fromQQ
    if getGroupConf(msg.fromGroup,"Stage",0) == 0 then--判断游戏进程
      return "{at}本群数字炸弹游戏未开始"
    end
    if getGroupConf(msg.fromGroup,"Stage",0) == 1 then --正确进程
     local Group = msg.fromGroup
     Playerlist = getGroupConf(msg.fromGroup,"NumBPlayer",Playerlist)
     if type(Playerlist)~="table" then
         Playerlist[1] = msg.fromQQ
     end
     ct = #Playerlist
     --检查玩家是否在列表中
     for i=1,ct do
        if Playerlist[i]==QQ then
        return "{nick}已在游戏中"
        end
     end
 ct = ct + 1
 Playerlist[ct] = msg.fromQQ
 setGroupConf(msg.fromGroup,"NumBPlayer",Playerlist) --存入groupconf
 setGroupConf(msg.fromGroup,"PlayerCount",getGroupConf(msg.fromGroup,"PlayerCount",1)+1)
    return"{nick}成功加入游戏！"..getTableContent(Playerlist)
else
    return"游戏已经开始，中途无法加入。"
 end
end
msg_order["加入数字炸弹"]="gamejoin"

function gamestart(msg)
    if msg.fromGroup == "0" then --检查是否私聊
        return "私人模式直接开始，无需准备环节。"
    end
    if getGroupConf(msg.fromGroup,"Stage",0) ~= 1 then --若不在私聊视为群里，直接检查游戏进程信息
        return "错误的游戏进程，可能本群已经在游戏中或尚未初始化。请发送【数字炸弹启动】进行初始化。"
    else --正确进程下执行游戏内容，进 Stage2
        local Group = msg.fromGroup
        Playerlist = getGroupConf(msg.fromGroup,"NumBPlayer",0)
        setGroupConf(msg.fromGroup,"Stage",2)
        sendMsg("数字炸弹正式启动，中途无法加入新玩家。\n退出游戏请发送退出数字炸弹。",msg.fromGroup,msg.fromQQ)
        Playerlist = shuffle(Playerlist)
        setGroupConf(msg.fromGroup,"NumBPlayer",Playerlist)
        local limit = getGroupConf(msg.fromGroup,"PlayerCount")
        local Numrange = getGroupConf(msg.fromGroup,"boobrange",limit*1000)
        setGroupConf(msg.fromGroup,"boobmax",Numrange)
        sendMsg("本轮数字范围已确定为 0 至 "..Numrange.."\n"..getTableContent(Playerlist),msg.fromGroup,msg.fromQQ)
---主题轮询
        local key = ranint(0,getGroupConf(msg.fromGroup,"boobmax",Numrange)) --随机范围取 key
        setGroupConf(msg.fromGroup,"nbkey",key)
        repeat  --循环轮询
          for i=1,#Playerlist do
             local max = getGroupConf(msg.fromGroup,"boobmax",getGroupConf(msg.fromGroup,"boobrange"))
             local min = getGroupConf(msg.fromGroup,"boobmin",0)
             setGroupConf(msg.fromGroup,"boobchecker",Playerlist[i])
             if getGroupConf(msg.fromGroup,"Stage",0) == 0 then  -- v1.1更新
                 return
             end
             if  max - min >2 then
             sendMsg("现在轮到：[CQ:at,id="..Playerlist[i].."]\n【.我选+数字】选择数字。\n例：。我选300\n当前范围：[ "..integer(min).." —— "..integer(max).." ]",msg.fromGroup,msg.fromQQ)
             for i=1,200 do --等待回答模块，如果回答则跳出
                if getGroupConf(msg.fromGroup,"isanswer",0) ~= 1 and getGroupConf(msg.fromGroup,"Stage",0)~=0 then
                sleepTime(100)
                setGroupConf(msg.fromGroup,"answertime",i)
                else
                 break
                end
             end
             local time = getGroupConf(msg.fromGroup,"answertime") --读回答时间
             --回答回执模块
            if time == 200 and getGroupConf(msg.fromGroup,"Stage",0)~=0 then --回答超时
              sendMsg("[CQ:at,id="..Playerlist[i].."]回答超时！",msg.fromGroup,msg.fromQQ)
              setGroupConf(msg.fromGroup,"answertime",0)
              sleepTime(600)
            else
                if getGroupConf(msg.fromGroup,"Stage",0)~=0 then --正确回答
                 local answer = getGroupConf(msg.fromGroup,"boobanswer")
                 local time = getGroupConf(msg.fromGroup,"answertime")/10
                 sendMsg("[CQ:at,id="..Playerlist[i].."]\n回答: "..integer(answer).."\n用时: "..time.."秒。",msg.fromGroup,msg.fromQQ)
                 setGroupConf(msg.fromGroup,"isanswer",0)
                 setGroupConf(msg.fromGroup,"answertime",0)
                end
            end
         else
             setGroupConf(msg.fromGroup,"Stage",0)
             return "没得可选了，看来这炸弹 「"..integer(getGroupConf(msg.fromGroup,"nbkey")).." 」 [CQ:at,id="..getGroupConf(msg.fromGroup,"boobchecker").."] 是要吃下去了。"
         end
     end
     until getGroupConf(msg.fromGroup,"Stage",0) == 0

        end
    end
msg_order["数字炸弹准备就绪"]="gamestart"

function gameanswer(msg)
 if msg.fromGroup == "0" then --私聊执行模块
    if getUserConf(msg.fromQQ,"Stage",0) == 0 then
        return"{nick}还没有开始游戏呢。"
    end
    answer = tonumber(getnum(msg.fromMsg))
    max = tonumber(getUserConf(msg.fromQQ,"boobmax",300))
    min = tonumber(getUserConf(msg.fromQQ,"boobmin",1))
    key = tonumber(getUserConf(msg.fromQQ,"boobkey"))
    if answer == key then
        setUserConf(msg.fromQQ,"Stage",0)
        setUserConf(msg.fromQQ,"boobkey",nil)
        sendMsg("！！炸啦！".."\n{nick}一共活过了"..getUserConf(msg.fromQQ,"NumboobTimes",1).."轮。",msg.fromGroup,msg.fromQQ)
        setUserConf(msg.fromQQ,"NumboobTimes",0)
        return
    end
    if answer >= max or answer<=min then --检查是否合法
    return "这个数不在范围里诶，这样不行的，重新说！\n范围是 "..integer(min).." 到 "..integer(max)
else setGroupConf(msg.fromQQ,"，boobanswer",answer)
       if answer<key then --若合法，修正上下限。
          setGroupConf(msg.fromQQ,"boobmin",answer)
         else
          setGroupConf(msg.fromQQ,"boobmax",answer)
         end
      setUserConf(msg.fromQQ,"NumboobTimes",getUserConf(msg.fromQQ,"NumboobTimes",0)+1)
    end
 end
--群聊执行模块
    if getGroupConf(msg.fromGroup,"Stage",0) ~= 2 then --检查游戏进程
        return
    end
    answer = tonumber(getnum(msg.fromMsg))
 if msg.fromQQ == getGroupConf(msg.fromGroup,"boobchecker") then --判断轮次是否正确
    max = tonumber(getGroupConf(msg.fromGroup,"boobmax"))
    min = tonumber(getGroupConf(msg.fromGroup,"boobmin",0))
    local key = tonumber(getGroupConf(msg.fromGroup,"nbkey"))
        if answer == key then  --判断是否爆炸
           setGroupConf(msg.fromGroup,"Stage",0)
           return "炸弹爆炸！游戏结束。\n{nick}({at})引爆了数字炸弹。炸弹为"..integer(getGroupConf(msg.fromGroup,"nbkey"))
        end
        if answer >= max or answer <= min then --检查是否合法
            return "这个数不在范围里诶，这样不行的，重新说！\n范围是"..integer(min).." 到 "..integer(max)
        else --合法回答
            setGroupConf(msg.fromGroup,"boobanswer",answer) --保存答案
            setGroupConf(msg.fromGroup,"isanswer",1)
            local key = tonumber(getGroupConf(msg.fromGroup,"nbkey"))
            if answer<key then --修正上下限范围
                setGroupConf(msg.fromGroup,"boobmin",answer)
            else
                setGroupConf(msg.fromGroup,"boobmax",answer)
            end
        end
 else
     return "还没到{nick}，别捣乱！"
    end
end
msg_order[".我选"]="gameanswer"


function exitgame(msg)
 if msg.fromGroup == "0" then
   setUserConf(msg.fromQQ,"Stage",0)
   return "游戏结束"
 end
  if getGroupConf(msg.fromGroup,"Stage",0) == 1 then
  Playerlist = getGroupConf(msg.fromGroup,"NumBPlayer",1)
  local ct = #Playerlist
  QQ = msg.fromQQ
  for i=1,ct do
    if Playerlist[i]==QQ then
       ct = ct -1
       table.remove(Playerlist,i)
       setGroupConf(msg.fromGroup,"NumBPlayer",Playerlist) --存入groupconf
       return "{nick}已退出本轮游戏"..getTableContent(Playerlist)
    end
  end
  elseif getGroupConf(msg.fromGroup,"Stage",0) == 2 then
  local ct = #Playerlist
  for i=1,ct do
   if Playerlist[i]==msg.fromQQ then
      ct = ct -1
      table.remove(Playerlist[i])
      setGroupConf(msg.fromGroup,"NumBPlayer",Playerlist) --存入groupconf,方便检查，其实不存也没事
      return "{nick}已退出本轮游戏"..getTableContent(Playerlist)
   end
  end
 end
end
msg_order["退出数字炸弹"]="exitgame"

function Endgame(msg)
    if msg.fromGroup == "0" then
       setUserConf(msg.fromQQ,"Stage",0)
       return "游戏结束"
    end
 if getGroupConf(msg.fromGroup,"Stage",0) == 0 then
    return "游戏都没开始，怎么结束呢？"
 else
    setGroupConf(msg.fromGroup,"boobmax",nil)
    setGroupConf(msg.fromGroup,"Stage",0)
    setGroupConf(msg.fromGroup,"boobmin",nil)
    setGroupConf(msg.fromGroup,"boobanswer",nil)
    setGroupConf(msg.fromGroup,"nbkey",nil)
    setGroupConf(msg.fromGroup,"NumBPlayer",nil)
    Playerlist = {}
    return "游戏进程已结束"
 end
end
msg_order["数字炸弹结束"]="Endgame"

function Pointnum(msg)
 if msg.fromGroup == "0" then
    if getUserConf(msg.fromQQ,"Stage",0) ~= 0
     then return"游戏已经开始，请在结束后进行指定。"
     else
     setUserConf(msg.fromQQ,"boobrange",getnum(msg.fromMsg))
     return "本轮Range上限已指定为"..getUserConf(msg.fromQQ,"boobrange").."\n指令【数字炸弹准备就绪】即可开始游戏。"
    end
 else
     if getGroupConf(msg.fromGroup,"Stage",0) ~= 1
     then return"游戏已经开始，请在结束后指定。"
     else
     setGroupConf(msg.fromGroup,"boobrange",getnum(msg.fromMsg))
     return "本轮Range上限已指定为"..getGroupConf(msg.fromGroup,"boobrange").."\n指令【数字炸弹准备就绪】即可开始游戏。"
     end
end
end
msg_order["数字指定"]="Pointnum"
