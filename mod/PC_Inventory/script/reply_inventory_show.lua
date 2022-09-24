--查看背包
list = getPlayerCardAttr(msg.uid,msg.gid or 0,"_Inventory",{})
if #list==0 then
    return "{reply_inventory_empty}"
end
fmt = {}
for i,item in ipairs(list) do
    table.insert(fmt," - "..item.name)
end
msg.inv = table.concat(fmt,"\n")
return "{reply_inventory_show}"