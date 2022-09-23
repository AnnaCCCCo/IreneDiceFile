msg_reply.get_goods = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "评论了影像",
    },
    echo = {
        lua = "reply_get_goods"	--调用文件名对应lua
    }
}