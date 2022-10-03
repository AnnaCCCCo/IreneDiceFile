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

msg_reply.Push_Payment = {	--该条msg_reply的id，唯一对应，同名覆盖
    keyword = {
        prefix = "催肾",
    },
    echo = {
        lua = "reply_push_payments"	--调用文件名对应lua
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

--msg_reply.Draw_Cards = {	--该条msg_reply的id，唯一对应，同名覆盖
--    keyword = {
--        Match = "查询抽卡记录",
--    },
--    echo = {
--        lua = "reply_draw_cards"	--调用文件名对应lua
--    }
--}
--
--msg_reply.Set_Token = {	--该条msg_reply的id，唯一对应，同名覆盖
--    keyword = {
--        Prefix = "设置token",
--    },
--    echo = {
--        lua = "reply_set_token"	--调用文件名对应lua
--    }
--}