msg_reply.Send_Msg_Arknights = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "&推车",
    },
    limit = {
        cd = {
            user = 20
        }
    },
    echo = {
        lua = "send_msg_group"	--调用文件名对应lua
    }
}