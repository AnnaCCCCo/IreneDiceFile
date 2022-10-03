token = getPlayerCardAttr(msg.uid,msg.gid or 0,"_Token",{})
if #token==0 then
    return "还未绑定角色~"
end

--res,drawCards=http.get("https://ak.hypergryph.com/user/api/inquiry/gacha?page=1&token="..token.."&channelId=1")
res,drawCards = http.get("https://ak.hypergryph.com/user/api/inquiry/gacha?page=1&token=tONUUtcJEtofU%2FJi7ypmJ8JC&channelId=1")
js = require "json" --调用第三方库
j = js.decode(drawCards)

return table.concat(j.data)
