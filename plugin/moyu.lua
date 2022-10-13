
msg_order = {}

task_call = {
	moyu_calendar="moyu_calendar",
}
notice_head = ".send notice 7 "
notice_body = "[CQ:image,url=https://api.emoao.com/api/moyu]"

function moyu_calendar()
    eventMsg(notice_head..notice_body, 0, getDiceQQ())
end

--不使用广播
--function moyu_calendar()
--	eventMsg("/摸鱼人日历",,getDiceQQ())
--end

function printChat(msg)
    if(msg.fromGroup=="0")then
        return "QQ "..msg.fromQQ
    else
        return "group "..msg.fromGroup
    end
end

function book_moyu_calendar(msg)
    eventMsg(".admin notice "..printChat(msg).." +7", 0, getDiceQQ())
    return "已订阅{self}的摸鱼人日历"
end

function unbook_moyu_calendar(msg)
    eventMsg(".admin notice "..printChat(msg).." -7", 0, getDiceQQ())
    return "已退订{self}的摸鱼人日历"
end
msg_order["订阅摸鱼人日历"]="book_moyu_calendar"
msg_order["退订摸鱼人日历"]="unbook_moyu_calendar"

function moyu(msg)
    local keyword = string.match(msg.fromMsg,"^[%s]*([^%s]*)[%s]*(.-)$",#("摸鱼人日历")+1)
    
	return "[CQ:image,url=https://api.emoao.com/api/moyu]"
end
msg_order["摸鱼人日历"] = "moyu"