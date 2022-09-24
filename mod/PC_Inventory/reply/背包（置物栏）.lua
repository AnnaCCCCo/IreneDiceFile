msg_reply.inventory_add = {
    keyword = {
        prefix = {"放入背包"}
    },
    limit = {
        cd = {
            user = 5
        }
    },
    echo = { lua = "reply_inventory_add" }
}
msg_reply.inventory_show = {
    keyword = {
        match = {"查看背包"}
    },
    echo = { lua = "reply_inventory_show" }
}
msg_reply.inventory_del = {
    keyword = {
        prefix = {"移出背包"}
    },
    limit = {
        cd = {
            user = 5
        }
    },
    echo = { lua = "reply_inventory_del" }
}
msg_reply.inventory_clean = {
    keyword = {
        match = {"清空背包"}
    },
    echo = { lua = "reply_inventory_clean" }
}