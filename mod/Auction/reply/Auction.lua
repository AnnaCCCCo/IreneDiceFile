msg_reply.Save_Contribute = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "&拍卖投稿",
    },
    echo = {
        lua = "reply_contribution"	--调用文件名对应lua
    }
}

msg_reply.New_Auction = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "&新建拍卖",
    },
    echo = {
        lua = "reply_new_auction"	--调用文件名对应lua
    }
}