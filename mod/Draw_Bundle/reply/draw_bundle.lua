msg_reply.reply_draw_res = {
    keyword = {
        prefix = {"&抽选"}
    },
    limit = {
        cd = {
            user = 5
        }
    },
    echo = { lua = "reply_draw_bundle" }
}
