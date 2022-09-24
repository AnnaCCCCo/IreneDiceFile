--[[
    @Author RainChain-Zero
    @Version 1.5
    @Last Modified 2022/08/14 13:21
    @Description 适用于方舟泰拉trpg的规则检定
]]
---@diagnostic disable: lowercase-global, assign-type-mismatch, cast-local-type
msg_order = {}
order_kng = ".rk"
msg_order[order_kng] = "ark_main"

objTemp, obj, num, sign, add = "", "", "", "", ""

function ark_main(msg)
   --将前缀符号均统一为"."
   local str = string.gsub(msg.fromMsg, "^。", ".")
   -- 判断是.rk还是.rka
   local isrka = true
   if not string.match(msg.fromMsg, "^.rka") then
      isrka = false
   else
      --去掉"a"
      str = string.gsub(str, "^.rka", ".rk")
   end
   local res, round = "", 1
   str, round = ark_multi(str)
   if round > 10 then
      return "诶诶诶？{self}这可要丢到什么时候呀..."
   end
   -- 联合检定判定(用&分割)
   local ark_union = split(str, "&")
   local isunion = #ark_union > 1
   for i = 1, round do
      if isunion then
         if i ~= 1 then
            res = res .. "\n\n"
         end
         res = res .. "{pc}进行ark的联合检定——\n"
      end
      local res_final = true
      for j = 1, #ark_union do
         local union_item = ark_union[j]
         if j ~= 1 then
            union_item = ".rk " .. union_item
         end
         local res_now = ark_check(msg, union_item, isrka)
         -- 修改多次检定的剩余结果抬头
         if not isunion and i ~= 1 then
            res_now = string.gsub(res_now, "{pc}进行ark的(.*)检定:", "")
         elseif isunion then
            res_now = "\n" .. res_now
         end
         -- 有一项检定失败则最终结果为失败
         if string.find(res_now, "Failure") ~= nil or string.find(res_now, "Fumble") ~= nil then
            res_final = false
         end
         res = res .. res_now
         -- 判断联合检定最终结果
         if isunion and j == #ark_union then
            res = res .. "\n\n"
            if not res_final then
               res = res .. "最终结果为——失败了...没有关系的哦~相信你一定能找到解决办法的！"
            else
               res = res .. "最终结果...成功啦!{self}就相信{nick}一定没问题的！"
            end
         end
      end
   end
   return res
end

-- 处理多轮检定,返回处理后的指令内容和多轮检定轮数
function ark_multi(str)
   local round = string.match(str, "(%d+)%s*#")
   if not round then
      return str, 1
   end
   return string.gsub(str, "%d+%s*#", ""), round * 1
end

-- 处理修正值,格式为xdy+z
function ark_mod(str)
   -- 通过+、-号分割字符串
   local num, op = split(str, "[%+%-]")
   local res = cal_mod(num[1])
   for i = 1, #num - 1 do
      if op[i] == "+" then
         res = res + cal_mod(num[i + 1])
      else
         res = res - cal_mod(num[i + 1])
      end
   end
   return res
end

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

-- 计算各个修正项的值
function cal_mod(mod)
   local mod_now = 0
   if not string.find(mod, "[dD]") then
      mod_now = tonumber(mod)
      --log(type(mod_now))
      if type(mod_now) == "number" then
         return mod_now
      else
         return 0
      end
   end
   local x, y = string.match(mod, "(%d+)[dD]+(%d+)")
   if not x or not y then
      return 0
   end
   for i = 1, x do
      mod_now = mod_now + ranint(1, y)
   end
   return mod_now
end

function ark_check(msg, str, isrka)
   -- 如果是.rka进行攻击，检定条目+2d10
   local attack, res_2d10 = 0, ""
   if isrka then
      attack = ranint(1, 10) + ranint(1, 10)
      res_2d10 = "\n（2D10=" .. string.format("%.0f）", attack)
   end
   --提取参数
   objTemp, num, sign = string.match(str, "[%s]*([^%s^%d^%+^%-]*)[%s]*(%d*)[%s]*([%+|%-]?)", #order_kng + 1)
   --判断合法性
   if (objTemp == "" or objTemp == nil) then
      return "请输入正确的检定条目哦"
   end
   --判断是否存在难度条目，如果存在，返回true和难度条目
   local flag, hardness = false, ""
   flag, hardness = HardnessCheck()
   --如果不存在难度条目，检定条目就为objTemp去掉可能的修订条目
   if (not flag) then
      obj = string.match(objTemp, "([^%s^%d^%+^%-]*)[%+|%-]?")
   else
      --如果存在难度条目，此时hardness即为难度条目，提取检定条目
      obj = string.match(objTemp, hardness .. "([^%s^%d^%+^%-]*)[%+|%-]?")
   end
   --侦查和侦察统一
   if (obj == "侦查") then
      obj = "侦察"
   end
   local sign_judge = type(sign) == "string" and (sign ~= "" and sign ~= nil)
   -- 处理修正值
   if sign_judge then
      add = ark_mod(string.match(str, sign .. "(.*)"))
   end

   --不存在即时检定也无修订值
   if ((type(num) == "string" and (num == "" or num == nil)) and not sign_judge) then
      --存在即时检定但无修订值
      --! 已知问题：如果检定条目为“力量”，将会取出nil
      num = getPlayerCardAttr(msg.fromQQ, msg.fromGroup, obj, 0)

      if (num == nil) then
         return ""
      end
      --特殊条目判定
      num = num + attack
      if (num * 1 == 0) then
         return "未设定" .. obj .. "技能值×"
      end
   elseif (type(num) == "string" and (num ~= "" and num ~= nil) and not sign_judge) then
      --不存在即时检定但有修订值
      num = num * 1 + attack
   elseif (type(num) == "string" and (num == "" or num == nil) and sign_judge) then
      --既有即时检定又有修订值
      if (sign == "+") then
         num = getPlayerCardAttr(msg.fromQQ, msg.fromGroup, obj, 0) + attack + add * 1
         if (num <= 0) then
            return "成功率<=0，这样可成功不了哦？"
         end
      elseif (sign == "-") then
         num = getPlayerCardAttr(msg.fromQQ, msg.fromGroup, obj, 0) + attack - add * 1
         if (num <= 0) then
            return "成功率<=0，这样可成功不了哦？"
         end
      else
         return "Error，错误的修订符"
      end
   elseif (type(num) == "string" and (num ~= "" or num ~= nil) and sign_judge) then
      if (sign == "+") then
         num = num * 1 + attack + add * 1
         if (num <= 0) then
            return "成功率<=0，这样可成功不了哦？"
         end
      elseif (sign == "-") then
         num = num * 1 + attack - add * 1
         if (num <= 0) then
            return "成功率<=0，这样可成功不了哦？"
         end
      else
         return "Error 错误的修订符"
      end
   else
      return "Error，检定输入有误"
   end

   --开始检定
   res = ranint(1, 100)
   --如果没有添加难度条目
   if (hardness == "") then
      return NormalJudge() .. res_2d10
   else
      --设定了难度条目的情况
      return Hardness[hardness]() .. res_2d10
   end
end

--检测难度条目
function HardnessCheck()
   for k, _ in pairs(Hardness) do
      if (string.find(objTemp, k) ~= nil) then
         return true, k
      end
   end
   return false, ""
end

--! V3.0 仅有进行攻击时才会进行2d10
-- --特殊条目+2D10判定
-- function attack
--    for _, v in pairs(ItemsNeed2D10) do
--       if (obj == v) then
--          return ranint(1, 10) + ranint(1, 10)
--       end
--    end
--    return 0
-- end

--没有增加难度条目的情况
function NormalJudge()
   if (res <= 5) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" ..
                  "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strCriticalSuccess}"
   elseif (res <= num - 40) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" ..
                  "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollExtremeSuccess}"
   elseif (res <= num - 25) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" ..
                  "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollHardSuccess} "
   elseif (res <= num - 10) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" .. "\nD100" .. "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "是较难成功，还可以吧"
   elseif (res <= num) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" ..
                  "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollRegularSuccess}"
   elseif (res <= 95) then
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" .. "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFailure}"
   else
      reply =
         "{pc}进行ark的" ..
         obj ..
            "检定:" ..
               "\nD100" .. "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFumble}"
   end
   return reply
end

--! V3.0 仅有进行攻击时才会进行2d10
--需要2d10加值的检定项
-- ItemsNeed2D10 = {
--    "搏斗",
--    "拳术",
--    "暗器",
--    "刀剑",
--    "杖术",
--    "枪术",
--    "软兵",
--    "盾术",
--    "重钝器",
--    "弓弩",
--    "投掷",
--    "射击",
--    "炮术",
--    "爆破",
--    "兵械操作",
--    "无人机操作",
--    "铳械"
-- }

--增加了难度条目的检定
Hardness = {
   ["较难"] = function()
      if (res <= 5) then
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strCriticalSuccess}"
      elseif (res <= num - 40) then
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollExtremeSuccess}"
      elseif (res <= num - 25) then
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollHardSuccess} "
      elseif (res <= num - 10) then
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" .. "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "是较难成功，还可以吧"
      elseif (res <= 95) then
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFailure}"
      else
         reply =
            "{pc}进行ark的较难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFumble}"
      end
      return reply
   end,
   ["困难"] = function()
      if (res <= 5) then
         reply =
            "{pc}进行ark的困难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strCriticalSuccess}"
      elseif (res <= num - 40) then
         reply =
            "{pc}进行ark的困难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollExtremeSuccess}"
      elseif (res <= num - 25) then
         reply =
            "{pc}进行ark的困难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollHardSuccess}"
      elseif (res <= 95) then
         reply =
            "{pc}进行ark的困难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFailure}"
      else
         reply =
            "{pc}进行ark的困难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFumble}"
      end
      return reply
   end,
   ["极难"] = function()
      if (res <= 5) then
         reply =
            "{pc}进行ark的极难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strCriticalSuccess}"
      elseif (res <= num - 40) then
         reply =
            "{pc}进行ark的极难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollExtremeSuccess}"
      elseif (res <= 95) then
         reply =
            "{pc}进行ark的极难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFailure}"
      else
         reply =
            "{pc}进行ark的极难" ..
            obj ..
               "检定:" ..
                  "\nD100" ..
                     "=" .. string.format("%.0f", res) .. "/" .. string.format("%.0f", num) .. "{strRollFumble}"
      end
      return reply
   end,
   ["普通"] = NormalJudge,
   ["一般"] = NormalJudge
}
