-- 查看背包
list = getPlayerCardAttr(msg.uid, msg.gid or 0, "_Inventory", {})
if #list == 0 then

end
fmt = {}
for i, item in ipairs(list) do
    if (string.find(item.name, "群：")) then
        groupnum = string.sub(item.name, string.find(item.name, "群：") + 6, string.find(item.name, "谷") - 4)
        if groupnum == msg.fromGroup then
            things = string.sub(item.name, string.find(item.name, "谷：") + 6)
            --
            table.insert(fmt, " - " .. things)
        else
            if msg.gid == nil then
                table.insert(fmt, " - " .. item.name)
            end
        end
    else
        table.insert(fmt, " - " .. item.name)
    end

    -- return groupnum
end
if #fmt == 0 then
    return "{reply_inventory_empty_this}"
end
msg.inv = table.concat(fmt, "\n")
return "{reply_inventory_show}"
-- return msg.gid
