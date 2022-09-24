-----------------------------------------------------------------------------
-- Choose for Selective phobia :D
-- Author:简律纯
-- 2022/07/02 2:28
-----------------------------------------------------------------------------

msg_order={}

msg_order["选择"]="choose"
msg_order["选"]="choosen"

choose = function(msg)

local rest = string.sub(msg.fromMsg,#"选择"+1)
local rest = string.gsub(rest,"还是"," ")
local text = ""
local items = {}

    repeat
        item,rest = string.match(rest,"^([^%s]*)[%s]*(.-)$")
        table.insert(items, item)
    until(rest=="")
    
    for i=1,#items do
        text = text..i.."."..items[i].."\n"
    end
    
    return "> {nick}\n你的选项有:\n".. text.."根据{self}的判断，你最终会选择"..items[ranint(1,#items)].."\n不要后悔哦~"
    
end

choosen = function(msg)

local rest = string.sub(msg.fromMsg,#"选"+1)
local rest = string.gsub(rest,"还是"," ")
local text = ""
local items = {}

    repeat
        item,rest = string.match(rest,"^([^%s]*)[%s]*(.-)$")
        table.insert(items, item)
    until(rest=="")
    
    for i=1,#items do
        text = text..i.."."..items[i].."\n"
    end
    
    return "> {nick}\n你的选项有:\n".. text.."根据{self}的判断，你最终会选择"..items[ranint(1,#items)].."\n不要后悔哦~"
    
end