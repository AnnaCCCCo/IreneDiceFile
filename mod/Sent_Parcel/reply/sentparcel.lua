msg_reply.Sent_Parcel = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "回复了评论",
    },
    echo = {
        lua = "reply_sent_parcel"	--调用文件名对应lua
    }
}