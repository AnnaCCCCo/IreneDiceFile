msg_reply.get_goods = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "评论了影像",
    },
    echo = {
        lua = "reply_get_goods"	--调用文件名对应lua
    }
}

msg_reply.See_Goods = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "看看手速排表",
    },
    echo = {
        lua = "reply_see_goods"	--调用文件名对应lua
    }
}

msg_reply.Set_Goods = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "设置谷子名称",
    },
    echo = {
        lua = "reply_set_goodscode"	--调用文件名对应lua
    }
}

msg_reply.Move_Goods = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "回复了评论",
    },
    echo = {
        lua = "reply_move_goods"	--调用文件名对应lua
    }
}

msg_reply.Search_Prts = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "查询干员",
    },
    echo = {
        lua = "reply_get_prts"	--调用文件名对应lua
    }
}

msg_reply.Upload_Pics = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "新增1个影像",
    },
    echo = {
        lua = "reply_upload_pics"	--调用文件名对应lua
    }
}

msg_reply.Sent_Parcel = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        Search = "回复了评论",
    },
    echo = {
        lua = "reply_sent_parcel"	--调用文件名对应lua
    }
}