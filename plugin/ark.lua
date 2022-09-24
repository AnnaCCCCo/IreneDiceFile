msg_order = {}
order_ark = ".ark"
order_ark1 = "。ark"
msg_order[order_ark] = "Roll_Ark"
msg_order[order_ark1] = "Roll_Ark"

function col()
  local phy, agi, psy, pow, exp, ori, app, mon = 0, 0, 0, 0, 0, 0, 0, 0
  for i = 1, 4 do
    phy = phy + ranint(1, 6)
  end
  for i = 1, 4 do
    agi = agi + ranint(1, 6)
  end
  for i = 1, 4 do
    psy = psy + ranint(1, 6)
  end
  for i = 1, 4 do
    pow = pow + ranint(1, 6)
  end
  for i = 1, 4 do
    exp = exp + ranint(1, 6)
  end
  for i = 1, 4 do
    ori = ori + ranint(1, 6)
  end
  for i = 1, 3 do
    app = app + ranint(1, 6)
  end
  mon = mon + ranint(1, 6)

  phy = phy * 3 + 8
  agi = agi * 3 + 8
  psy = psy * 3 + 8
  pow = pow * 3 + 8
  exp = exp * 3 + 8
  ori = ori * 3 + 8
  app = app * 5
  mon = mon * 9
  total1 = phy + agi + psy + pow + exp + ori + app + mon
  total2 = phy + agi + psy + pow + exp + ori + app
  per = total2 / 352.5
  sum =
    "{nick}的泰拉人作成:\n身体素质:" ..
    string.format("%.0f", phy) ..
      "\n反应机动:" ..
        string.format("%.0f", agi) ..
          "\n生理强度:" ..
            string.format("%.0f", psy) ..
              "\n精神意志:" ..
                string.format("%.0f", pow) ..
                  "\n经验智慧:" ..
                    string.format("%.0f", exp) ..
                      "\n源石技艺适应性:" ..
                        string.format("%.0f", ori) ..
                          "\n个人魅力:" ..
                            string.format("%.0f", app) ..
                              "\n信誉:" ..
                                string.format("%.0f", mon) ..
                                  "\n共计:" ..
                                    string.format("%.0f", total2) ..
                                      "/" .. string.format("%.0f", total1) .. "\n偏离比:" .. string.format("%.2f", per)
  return sum
end
function Roll_Ark(msg)
  local cnt = nil
  local ans = ""
  if (msg.fromMsg == order_ark or msg.fromMsg == order_ark1) then
    cnt = 1
  elseif (string.find(msg.fromMsg, ".", 1) ~= nil) then
    cnt = tonumber(string.match(msg.fromMsg, "[%s]*(%d*)[%s]*", #order_ark + 1))
  else
    cnt = tonumber(string.match(msg.fromMsg, "[%s]*(%d*)[%s]*", #order_ark1 + 1))
  end
  if (cnt == nil) then
    return "参数有误请重新输入"
  end
  if (cnt < 1) then
    return "{strZeroDiceErr}"
  elseif (cnt > 5) then
    return "{strDicetooBigErr}"
  else
    for i = 1, cnt - 1 do
      ans = ans .. col() .. "\n" .. "\n"
    end
    ans = ans .. col()
    return ans
  end
end
