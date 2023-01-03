msg_reply.Chat_New = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "&聊天",
    },
    echo = {
        lua = "reply_chat_new"	--调用文件名对应lua
    }
}