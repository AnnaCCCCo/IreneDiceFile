name = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"移出背包"+1)
if #name==0 then
    return "{reply_inventory_del_empty}"
end
pc = getPlayerCard(msg.uid,msg.gid or 0)
list = pc._Inventory or {}
if #list==0 then
    return "{reply_inventory_empty}"
end
fmt = {}
for i,item in ipairs(list) do
    if item.name==name and not idx then
        idx=i
    else
        table.insert(fmt," - "..item.name)
    end
end
msg.item = name
if not idx then
    return "{reply_inventory_not_found}"
else
    table.remove(list,idx)
    pc._Inventory=list
end
msg.inv = table.concat(fmt,"\n")
return "{reply_inventory_del}"