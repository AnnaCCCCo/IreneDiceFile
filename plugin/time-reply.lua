--[[
不同时间段不同回复模板
by baigugu
version：v1.0.2
介绍：（写的比较粗糙，勿喷）
用的lua的os库，使用需要一定耐心看例子，核心函数不用管，直接看自定义部分，复制例子部分改相关文本或者参数就行，建议使用vscode之类的软件辅助修改
]]--

--初始化回复列表
msg_order={}


--核心函数，不用你改
function time_reply_main(reply_list)
    local hour=tonumber (os.date('%H'))
    for i, v in ipairs(time_config) do
        if (v[1]<= hour and v[2]>= hour) then
            if reply_list[i]==nil then
                return ""
            end
            return table_draw(reply_list[i])
        end
    end
end

function table_draw(tab)
    return tab[ranint(1,#tab)]
end

--自定义部分

--设置时间段，对应着回复列表
time_config={
    {0,4},
    {5,9},
    {10,13},
    {14,18},
    {19,23}
}

--例子：早上好
function good_morning(msg)--函数名good_morning
    return time_reply_main(list_morning)--time_reply_main(回复列表名)
end

function good_night(msg)--函数名good_morning
    return time_reply_main(list_GoodNight)--time_reply_main(回复列表名)
end

--回复列表对应全局设置的时间
list_morning={
    {
        '现在是凌晨，与其说早上好，不如说为什么博士还不去睡觉'
    },
    {
        '早安',
        '早上好哦，博士'
    },
    {
        '午好,不是早上了哦',
        '中午好，博士。虽然你刚睡醒，说早安也勉强可以吧'
    },
    {--可以空
        '......已经下午了',
        '不管什么理由，都不应该在下午说早上好'
    },
    {
        '...艾丽妮不想理在晚上说早上好的博士',
        '我可以认为博士已经困到神志不清忘记时间了，快去睡觉吧，博士'
    }
}

list_GoodNight={
    {
        '夜深了，博士快去睡觉吧，我在这里守夜就够了',
        '(打盹)'
    },
    {
        '都这个点了博士居然还没睡？！'
    },
    {
        '醒醒，博士，该开始干活了'
    },
    {--可以空
        '......这个时间，也许博士是想去午睡？'
    },
    {
        '晚上好，博士。说起来，罗德岛好像没有宵禁？那夜晚才刚刚开始',
        '这么晚了啊..我也要去睡觉了。不过睡觉之前要不要去找乔迪吃个夜宵呢？',
        '晚上好，博士，要不要去喝一杯？'
    }
}
--例子结束
--自定义部分结束

--将关键词绑定到函数
msg_order["早上好呀"]="good_morning"
msg_order["早上好"]="good_morning"
msg_order["晚上好"]="good_night"

