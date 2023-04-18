msg_reply.Push_Payment = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "&催肾",
    },
    limit = {
        cd = {
            user = 20
        }
    },
    echo = {
        lua = "reply_push_payments"	--调用文件名对应lua
    }
}