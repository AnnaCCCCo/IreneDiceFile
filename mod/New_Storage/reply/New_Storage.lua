msg_reply.New_Storage = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        search = "&团内到货",
    },
    echo = {
        lua = "reply_See_Storage"	--调用文件名对应lua
    }
}