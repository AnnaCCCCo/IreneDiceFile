text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"设置token"+1)

token = string.sub(text,string.find(text,"content")+10,string.find(text,"\"},\"")-1)

pc = getPlayerCard(msg.uid,msg.gid or 0)
pc._Token = token

return "账号已绑定"