name = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"放入背包"+1)
if #name==0 then
    return "{reply_inventory_add_empty}"
end
pc = getPlayerCard(msg.uid,msg.gid or 0)
list = pc._Inventory or {}
--[[若使用数量上限判定，将以下代码解除注释
if pc._Inventory_cnt_limit or 10 <= #list then --未设定_Inventory_cnt_limit则取10
    return "{reply_inventory_cnt_limited}"
end
]]--
table.insert(list,{name=name})
pc._Inventory=list
fmt = {}
for i,item in ipairs(list) do
    table.insert(fmt," - "..item.name)
end
msg.item = name
msg.inv = table.concat(fmt,"\n")

local file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\Personal\\"..msg.fromQQ..".txt", "a+")
file:write(" - "..name, "\n")
file:close()

return "{reply_inventory_add}"