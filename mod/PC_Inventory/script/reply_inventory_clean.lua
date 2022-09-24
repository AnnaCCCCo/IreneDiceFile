pc = getPlayerCard(msg.uid,msg.gid or 0)
pc._Inventory = {}
return "{reply_inventory_clean}"