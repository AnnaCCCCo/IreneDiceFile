-- SenluoRebuild 森罗重铸
-- 作者：Redaction已编辑（也就是FXWHS）
-- 指令：.SeRb

msg_order={}
function introduce_SenluoRebuild (msg)
    return "无论何人，无论何时，踏入此地此地者必须清楚：\n世界即将或者已经陷入危难之中，你现在的职责是作为引导者去找到解药并引领世界走上正规。\n仅此而已。\n添加元素：.SeRb_+元素序号\n合成元素：.SeRb_C（最多加入两元素）\n列出已解明元素：.SeRb_list\n清空目前解析序列：.SeRb_re0\n清空你的一切进度（每个用户第一次使用脚本必须执行）：.SeRb_re0_true\n当你一筹莫展的时候，回望过去吧……"
end
msg_order[".SeRb"]="introduce_SenluoRebuild"

Material ={
"0 起源 \n“正与负的主宰”\n世界解析度：0 \n世界未饱和度：0 \n维度活动性：0 \n空间衰变时间：无法观测",
"1 存在 \n“存在先于意识，或是意识先于存在？”\n世界解析度：28.31sa \n世界未饱和度：9sus \n维度活动性：-273.42da \n空间衰变时间：0.0012ms",
"2 运动 \n“无法辩解的是，世界万物都在运动”\n世界解析度：31.24sa \n世界未饱和度：12sus \n维度活动性：-202.23da \n空间衰变时间：0.0009ms",
"3 控制 \n“我紧握着你，你受我所控”\n世界解析度：39.02sa \n世界未饱和度：15sus \n维度活动性：-191.11da \n空间衰变时间：0.0002ms",
"4 探知 \n“那是什么？”\n世界解析度：42.78sa \n世界未饱和度：17sus \n维度活动性：-190.32da \n空间衰变时间：0.0001ms",
"5 艺术 \n“美”\n世界解析度：48.55sa \n世界未饱和度：23sus \n维度活动性：-182.47da \n空间衰变时间：0.00009ms",
"6 历史 \n“所有逝去的”\n世界解析度：52.44sa \n世界未饱和度：25sus \n维度活动性：-178.22da \n空间衰变时间：0.00082ms",
"7 社会 \n“我，你，他”\n世界解析度：55.49sa \n世界未饱和度：27sus \n维度活动性：-162.67da \n空间衰变时间：0.00079ms",
"8 理解 \n“所能知晓”\n世界解析度：67.17sa \n世界未饱和度：33sus \n维度活动性：-154.83da \n空间衰变时间：0.00073ms",
"9 规律 \n“依照这样”\n世界解析度：70.53sa \n世界未饱和度：37sus \n维度活动性：-151.91da \n空间衰变时间：0.00065ms",
"10 时间 \n“第四维度”\n世界解析度：132.221sa \n世界未饱和度：50sus \n维度活动性：0 \n空间衰变时间：20ms",
"11 坐标 \n“你在哪？我来了”\n世界解析度：85.01sa \n世界未饱和度：64sus \n维度活动性：102da \n空间衰变时间：2002ms",
"12 概率 \n“骰子抛下，一切可知”\n世界解析度：80.34sa \n世界未饱和度：70sus \n维度活动性：132da \n空间衰变时间：2012ms",
"13 混沌 \n“他们不会停下，你所能做的只是看着”\n世界解析度：76.89sa \n世界未饱和度：78sus \n维度活动性：138da \n空间衰变时间：2233ms",
"14 极限 \n“未曾到过的所到之处”\n世界解析度：57.21sa \n世界未饱和度：79sus \n维度活动性：142da \n空间衰变时间：2398ms",
"15 宇宙 \n“那里，那里，还有那里”\n世界解析度：50.36sa \n世界未饱和度：81sus \n维度活动性：156da \n空间衰变时间：2870ms",
"16 交换 \n“改变吧”\n世界解析度：44.98sa \n世界未饱和度：82sus \n维度活动性：178da \n空间衰变时间：3574ms",
"17 乐章 \n“迎来终末”\n世界解析度：39.07sa \n世界未饱和度：84sus \n维度活动性：184da \n空间衰变时间：4000ms",
"18 衰变 \n“走向终结”\n世界解析度：32.78sa \n世界未饱和度：87sus \n维度活动性：193da \n空间衰变时间：8000ms",
"19 Senoviar \n“人类从未设想之物”\n世界解析度：30.52sa \n世界未饱和度：88sus \n维度活动性：217da \n空间衰变时间：9302ms",
"20 意识 \n“意识先于存在，或是存在先于意识”\n世界解析度：28.31sa \n世界未饱和度：90sus \n维度活动性：273.42da \n空间衰变时间：12000ms",
"21 吞噬 \n“现实和虚构的主宰”\n世界解析度：-0sa \n世界未饱和度：100sus \n维度活动性：-0wa \n空间衰变时间：无法观测",
"2=2号聚合物 突破\n“前进，前进，不断前进”\n聚合度：29fd \n世界解析度：987.1sa\n维度活动性：0.00002da",
"0-9-10号化合物 命运\n“Deceive the world”\n化合度：无法观测\n世界解析度：无法观测\n维度活动性：无法观测"
}

function SenluoRebuild_list(msg)
    local re0_check = getUserConf(msg.fromQQ,"re0_true")
    if re0_check == nil then
    return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
    end
    local request22 = getUserConf(msg.fromQQ,"request22")
    local request23 = getUserConf(msg.fromQQ,"request23")
    list = "0起源 1存在 2运动 3控制 4探知 5艺术\n6历史 7社会 8理解 9规律 10时间 11坐标\n12概率 13混沌 14极限 15宇宙 16交换 17乐章\n18衰变 19Senoviar 20意识 21 吞噬"
    if request22 == 1 then
        list = list .. " 22突破"
        goto jump
    end
    ::jump::
    if request23 == 1 then
        list = list .. " 23命运"
        goto jump2
    end
    ::jump2::
    return list
end
msg_order[".SeRb_list"] = "SenluoRebuild_list"

function re0_true_SenluoRebuild(msg)
    setUserConf(msg.fromQQ,"Terminal",0)
    setUserConf(msg.fromQQ,"request22",0)
    setUserConf(msg.fromQQ,"request23",0)
    setUserConf(msg.fromQQ,"re0_true",1)
    setUserConf(msg.fromQQ,"SeCr_Time",0)
    setUserConf(msg.fromQQ,"SeCr_Time_U",0)
    setUserConf(msg.fromQQ,"Terminal_U",0)
    setUserConf(msg.fromQQ,"check_finish",0)
    return "return 0！一切，全部归零！"
end
msg_order[".SeRb_re0_true"] = "re0_true_SenluoRebuild"

function re0_SenluoRebuild(msg)
    setUserConf(msg.fromQQ,"Terminal",0)
    setUserConf(msg.fromQQ,"SeCr_Time",0)
    setUserConf(msg.fromQQ,"SeCr_Time_U",0)
    setUserConf(msg.fromQQ,"Terminal_U",0)
    return "世界的残枝败叶清理完毕！"
end
msg_order[".SeRb_re0"] = "re0_SenluoRebuild"

function process_SenluoRebuild(msg)
local re0_check = getUserConf(msg.fromQQ,"re0_true")
if re0_check == nil then
    return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
end
local material = string.sub(msg.fromMsg,7,-1)
local material = tonumber(material)
if material >21 and material < 25 then
    local accepet = getUserConf(msg.fromQQ,"request"..material)
    if accepet == 0 then
        return "世界无法解析这种原始物质，是不存在？还是还没把他们找到？"
    end
    goto jump
end
if material <0 and material > 24 then
    return "世界无法解析这种原始物质!"
end
::jump::
local select_time = getUserConf(msg.fromQQ,"SeCr_Time")
if select_time == 2 then
    return"元素已经就绪，请开始吧！(.SeRb_C)"
end
local select_time = tonumber(select_time)
local select_time = select_time + 1
Terminal = getUserConf(msg.fromQQ,"Terminal")
Terminal = Terminal.."_"..material
setUserConf(msg.fromQQ,"Terminal",Terminal)
setUserConf(msg.fromQQ,"SeCr_Time",select_time)
return Material[material+1] .."\n现在台上的正在解析的序列为："..Terminal
end
msg_order[".SeRb_"]="process_SenluoRebuild"

function creation_SenluoRebuild (msg)
    local re0_check = getUserConf(msg.fromQQ,"re0_true")
    if re0_check == nil then
        return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
    end
    local check_finish = getUserConf(msg.fromQQ,"check_finish")
    Terminal = getUserConf(msg.fromQQ,"Terminal")
    local request22 = getUserConf(msg.fromQQ,"request22")
    local request23 = getUserConf(msg.fromQQ,"request23")
    if Terminal == "0_6_6" then
        setUserConf(msg.fromQQ,"Terminal",0)
        setUserConf(msg.fromQQ,"SeCr_Time",0)
        if check_finish == 1 then
            return "6=6号聚合物 残篇\n当你解析这个元素时，一段文字突然浮现在你的眼前：\n"..Remnant_Extra[ranint(1,10)]
        end
        return "6=6号聚合物 残篇\n当你解析这个元素时，一段文字突然浮现在你的眼前：\n"..Remnant[ranint(1,10)]
    end
    if Creation[Terminal] then local creation = Creation[Terminal]
        if  Terminal == "0_2_2" then 
        setUserConf(msg.fromQQ,"request22",1)
        if request23 == 1 then
            setUserConf(msg.fromQQ,"check_finish",1)
            setUserConf(msg.fromQQ,"Terminal",0)
            setUserConf(msg.fromQQ,"SeCr_Time",0)
            return creation.."\n“历史的残篇翻向了下一页。\n现在，元素已经齐全，开始吧（.SeRb_U_+元素）”"
        end
        goto jump2
        end
        if  Terminal == "0_9_10" then 
        setUserConf(msg.fromQQ,"request23",1)
        if request22 == 1 then
            setUserConf(msg.fromQQ,"check_finish",1)
            setUserConf(msg.fromQQ,"Terminal",0)
            setUserConf(msg.fromQQ,"SeCr_Time",0)
            return creation.."\n“历史的残篇翻向了下一页。\n现在，元素已经齐全，开始吧（.SeRb_U_+元素）”"
        end
        goto jump2
        end
        ::jump2::
        setUserConf(msg.fromQQ,"Terminal",0)
        setUserConf(msg.fromQQ,"SeCr_Time",0)
        return creation
    end
    setUserConf(msg.fromQQ,"Terminal",0)
    setUserConf(msg.fromQQ,"SeCr_Time",0)
    return "世界并未对你的序列做出答复，或是序列无解？或是世界不愿……"
end
msg_order[".SeRb_C"]="creation_SenluoRebuild"

function ultimate_creation_SenluoRebuild (msg)
    local re0_check = getUserConf(msg.fromQQ,"re0_true")
    if re0_check == nil then
        return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
    end
    local check_finish = getUserConf(msg.fromQQ,"check_finish")
    if check_finish == 0 then
        return"“现在，还没到时候”"
    end
    local material = string.sub(msg.fromMsg,9,-1)
    local material = tonumber(material)
    if material >21 and material < 25 then
        local accepet = getUserConf(msg.fromQQ,"request"..material)
        if accepet == 0 then
            return "世界无法解析这种原始物质，是不存在？还是还没把他们找到？"
        end
        goto jump
    end
    if material <0 and material > 24 then
        return "世界无法解析这种原始物质!"
    end
    ::jump::
    local select_time_U = getUserConf(msg.fromQQ,"SeCr_Time_U")
    if select_time_U == 5 then
        return"最终的句点近在咫尺，请开始吧！(.SeRb_F)"
    end
    local select_time_U = tonumber(select_time_U)
    local select_time_U = select_time_U + 1
    Terminal_U = getUserConf(msg.fromQQ,"Terminal_U")
    Terminal_U = Terminal_U.."_"..material
    setUserConf(msg.fromQQ,"Terminal_U",Terminal_U)
    setUserConf(msg.fromQQ,"SeCr_Time_U",select_time_U)
    return Material[material+1] .."\n现在台上的正在解析的序列为："..Terminal_U
end
msg_order[".SeRb_U_"]="ultimate_creation_SenluoRebuild"

function finish_creation_SenluoRebuild (msg)
    local re0_check = getUserConf(msg.fromQQ,"re0_true")
    if re0_check == nil then
        return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
    end 
    Terminal_U = getUserConf(msg.fromQQ,"Terminal_U")
    if Terminal_U == "0_2_9_1_22_23" then
        setUserConf(msg.fromQQ,"Terminal_U",0)
        setUserConf(msg.fromQQ,"SeCr_Time_U",0)
        return "随着最后一个元素放入工作台，一道光芒刺入你的身体，你的意识逐渐散去……\n这时你发现自己躺在自己的床上。“嗨，原来是梦啊，还说什么世界之树，什么重铸世界。现在，该睡个回……”\n你看到闹钟分毫不差地指在7:00处\n“呃啊啊啊啊啊啊啊，要迟到了啊啊啊啊”……\n（镜头转向楼底下站着一位裹在风衣里的少女）\n“引导者大人，看来真是有趣呢(*^▽^*)”"
    end
    setUserConf(msg.fromQQ,"Terminal_U",0)
    setUserConf(msg.fromQQ,"SeCr_Time_U",0)
    return "尽管所有元素已经放入，但是……并没有什么效果。"
end
msg_order[".SeRb_F"]="finish_creation_SenluoRebuild"

function observation (msg)
    local re0_check = getUserConf(msg.fromQQ,"re0_true")
if re0_check == nil then
    return"世界尚未开始转动，请进行真正的重置(.SeRb_re0_true)"
end
    local check_finish = getUserConf(msg.fromQQ,"check_finish")
    if check_finish == 1 then
        return"(空灵的声音)“收到，引导者大人\n现在开始合成最终聚合物，请按以下顺序进行合成：\n 1、修补时间维\n 2、修补速度维\n 3、修补生物线\n 4、以此使用那两个元素吧！”"
    end
    return "(空灵的声音)“收到，引导者大人\n现在您需要合成具有如下特征的元素：\n具有极大运动能力\n在任何时间线所必定收束之物\n当两个元素收集之后，我会告知您下一步”"
end
msg_order[".SeRb_O"]="observation"


Creation = {}
Creation["0_0_0"] = "FFFFFF聚合物 无\n“ ”\n聚合度：[已屏蔽]\n世界解析度：[已屏蔽]\n维度活动性：[已屏蔽]\n________________\n起源+起源"
Creation["0_0_23"] = "FFFFFF聚合物 无-\n“ ”\n聚合度：[数据删除]\n世界解析度：[数据删除]\n维度活动性：[数据删除]\n还有人能看到这段留言吗，救救她……\n起源+命运"
Creation["0_1_20"] = "0-1-20号化合物 对立\n“镜之彼岸”\n化合度：100fd \n世界解析度：3.123sa\n维度活动性：0\n存在+意识"
Creation["0_1_10"] = "0-1-10号化合物 矗立\n“fest und unbezwingbar”\n化合度： fd \n世界解析度： sa\n维度活动性： \n存在+时间"
Creation["0_1_1"] = "1=1号聚合物 唯物\n“天地合而万物生，阴阳接而变化起”\n聚合度：100fd \n世界解析度：281.732da\n维度活动性：0\n存在+存在"
Creation["0_1_2"] = "0-1-2号化合物 生命\n“有机”\n化合度：98fd \n世界解析度：583.34sa\n维度活动性：5003da\n存在+运动"
Creation["0_1_6"] = "0-1-2号化合物 先者\n“曾经，他们也存活于这个世界上”\n化合度：94fd \n世界解析度：567.12sa\n维度活动性：4978da\n存在+历史"
Creation["0_2_2"] = "2=2号聚合物 突破\n“终抵彼方”\n聚合度：29fd \n世界解析度：987.1sa\n维度活动性：0.00002da\n运动+运动\n或许，这个物质可以加以利用？第22？"
Creation["0_2_3"] = "0-2-3号化合物 傀儡\n“最可悲的一点，每一个人都得受到这种束缚”\n化合度：42fd \n世界解析度：99.02sa\n维度活动性：1002wa\n运动+控制"
Creation["0_2_4"] = "0-2-4号化合物 掠夺\n“我们捕食……我们被捕食……”\n化合度：86fd \n世界解析度：437.49sa\n维度活动性：6786da\n运动+感知"
Creation["0_2_6"] = "0-2-6号化合物 发展\n“1→2”\n化合度：27fd \n世界解析度：352sa\n维度活动性：7455da\n运动+历史"
Creation["0_3_2"] = "0-4-3号化合物 欲望\n“请给我，请给我！”\n化合度：87fd \n世界解析度：231.92sa\n维度活动性：1002da\n控制+运动"
Creation["0_3_4"] = "0-3-4号化合物 追踪\n“我会找到你，我会找到你！”\n化合度：74fd \n世界解析度：92.09sa\n维度活动性：4231da\n控制+感知"
Creation["0_3_5"] = "0-3-5号化合物 骗术\n“信任的背离”\n化合度：29fd \n世界解析度：442.72sa\n维度活动性：3452da\n控制+艺术"
Creation["0_4_2"] = "0-4-2号化合物 探索\n“前往那未知的彼岸”\n化合度：47fd \n世界解析度：574.4sa\n维度活动性：4423da\n感知+运动"
Creation["0_4_3"] = "0-4-3号化合物 自律\n“约束，但并非奴役”\n化合度：78fd \n世界解析度：325.43sa\n维度活动性：1423da\n感知+控制"
Creation["0_4_11"] = "0-4-11号化合物 传感\n“把你的感知交给我吧！”\n化合度：71fd \n世界解析度：192.12sa\n维度活动性：7381da\n感知+坐标"
Creation["0_5_6"] = "0-5-6号化合物 遗迹\n“被黄沙掩埋的真相”\n化合度：93fd\n世界解析度：187.22sa\n维度活动性：1234da\n艺术+历史"
Creation["0_5_5"] = "5=5号聚合物 美学\n“：）”\n聚合度 39fd \n世界解析度：109.28sa\n维度活动性：0.0008da\n艺术+艺术"
Creation["0_5_7"] = "0-5-7号化合物 调和\n“众多颜色融为一体，便成了画”\n化合度：40fd \n世界解析度：432sa\n维度活动性：4738da\n艺术+社会"
Creation["0_5_17"] = "0-5-17号化合物 悲歌\n“所谓悲剧，就是把有价值的东西毁灭给人看”\n化合度：82.3fd \n世界解析度：931.89sa\n维度活动性：6922da\n艺术+乐章\n0-5-17-1号衍生物 乐曲\n“所谓喜剧，就是把有无价值的东西毁灭给人看”\n化合度：82.3fd \n世界解析度：931.89sa\n维度活动性：6922da\n艺术+乐章"
Creation["0_6_4"] = "0-6-4号化合物 解放\n“自由之声响彻山谷”\n化合度：47fd \n世界解析度：623sa\n维度活动性：2963da\n历史+探知"
Creation["0_6_5"] = "0-6-5号化合物 回忆\n“那便是，归宿”\n化合度：89fd \n世界解析度：960.9sa\n维度活动性：6577da\n历史+艺术"
Creation["0_6_10"] = "0-6-10号化合物 时代\n“Novi proximo capite”\n化合度：0.021fd \n世界解析度：1.32sa\n维度活动性：6da\n历史+时间"
Creation["0_7_3"] = "0-7-3号化合物 阶级\n“掌握，控制，统治”\n化合度：23fd \n世界解析度：746sa\n维度活动性：2398da\n社会+控制"
Creation["0_7_0"] = "0-7-0号化合物 起点\n“0→1”\n化合度：99.87fd \n世界解析度：928sa\n维度活动性：9203755da\n社会+起源"
Creation["0_7_4"] = "0-7-4号化合物 斗争\n“反抗，挣脱，革命”\n化合度：24fd \n世界解析度：764sa\n维度活动性：2400da\n社会+控制"
Creation["0_7_5"] = "0-7-5号化合物 诗歌\n“为世界所咏唱”\n化合度：47fd \n世界解析度：329sa\n维度活动性：1024da\n社会+艺术"
Creation["0_7_8"] = "0-7-8号化合物 纲领\n“用它，改变世界”\n化合度：99fd \n世界解析度：232.17sa\n维度活动性：998da\n社会+理解"
Creation["0_7_9"] = "0-7-9号化合物 进度\n“低级会不断向更高阶段发展”\n化合度：56fd \n世界解析度：652.83sa\n维度活动性：4302da\n社会+规律"
Creation["0_8_4"] = "0-8-4号化合物 研究\n“？”\n化合度：23fd \n世界解析度：395.132sa\n维度活动性：7921da\n理解+感知"
Creation["0_8_5"] = "0-8-5号化合物 温暖\n“谢谢你，救赎了我”\n化合度：62fd \n世界解析度：249.92sa\n维度活动性：4301da\n理解+艺术"
Creation["0_8_7"] = "0-8-7号化合物 共识\n“达成一致”\n化合度：94fd \n世界解析度：74sa\n维度活动性：1028.32da\n理解+社会"
Creation["0_8_8"] = "8=8号聚合物 感染\n“你=我”\n聚合度：38fd \n世界解析度：286sa\n维度活动性：0.00187da\n理解+理解"
Creation["0_9_0"] = "0-9-0号化合物 进化\n“人类在道德文化方面最高级的阶段，就是当我们认识到应当用理智控制思想时。”\n化合度：97.5fd \n世界解析度：1217sa\n维度活动性：91283182da\n规律+起源"
Creation["0_9_2"] = "0-9-2号化合物 运动学\n“以速度，掠过每一个空间”\n化合度：24fd \n世界解析度：194sa\n维度活动性：8374da\n规律+运动"
Creation["0_9_10"] = "0-9-10号化合物 命运\n“El．Psy．Kongroo”\n化合度：无法观测\n世界解析度：无法观测\n维度活动性：无法观测\n规律+时间\n或许，这个物质可以加以利用？第23？"
Creation["0_9_11"] = "0-9-11号化合物 系\n“联属关系”\n化合度：94fd \n世界解析度：289sa\n维度活动性：0.111da\n规律+坐标"
Creation["0_9_12"] = "0-9-11号化合物 概率论\n“随机：决定”\n化合度：92fd \n世界解析度：327sa\n维度活动性：0.218da\n规律+概率"
Creation["0_10_6"] = "0-10-6号化合物 流逝\n“Verschwinde in die Geschichte”\n化合度：0.029fd \n世界解析度：0.98sa\n维度活动性：9da\n时间+历史"
Creation["0_10_9"] = "0-10-9号化合物 收束\n“Die Welt manipulieren”\n化合度：0.032fd \n世界解析度：0.67sa\n维度活动性：7da\n时间+规律"
Creation["0_10_11"] = "0-10-9号化合物 节点\n“Einrichtung,Beobachtung,Rückverfolgung”\n化合度：0.012fd \n世界解析度：0.78sa\n维度活动性：8da\n时间+坐标"
Creation["0_11_11"]= "投影空间 坐标系\n“维度逐渐升高，尽头遥不可及”\n折射范围：-\n乐章+混沌"
Creation["0_11_13"] = "0-11-13号化合物 虚空\n“撕裂一切”\n化合度：47.2fd \n世界解析度：312sa\n维度活动性：5352da\n坐标+混沌"
Creation["0_11_14"] = "0-11-14号化合物 区间\n“正于此地”\n化合度：26fd \n世界解析度：632sa\n维度活动性：3522da\n坐标+极限"
Creation["0_11_15"] = "0-11-15号化合物 信标\n“贯穿世界”\n化合度：36.43fd \n世界解析度：823sa\n维度活动性：1432da\n坐标+宇宙"
Creation["0_11_16"] = "0-11-16号化合物 闪烁\n“光暗交错，万物更新”\n化合度：13.2fd \n世界解析度：721.32sa\n维度活动性：4324.57da\n坐标+交换"
Creation["0_12_3"] = "0-12-3号化合物 期望\n“到此为止了”\n化合度：42fd \n世界解析度：918.11sa\n维度活动性：2329.02da\n概率+控制"
Creation["0_12_13"] = "0-12-13号化合物 无序\n“毫无规律”\n化合度：31fd \n世界解析度：872.31sa\n维度活动性：4142da\n概率+混沌"
Creation["0_12_14"] = "0-12-14号化合物 希望\n“你们应该亲自奋起对抗……因为与绝望对抗本身才是“希望”啊。”\n化合度：32.5fd \n世界解析度：592.13sa\n维度活动性：3333.21da\n概率+极限"
Creation["0_12_19"] = "0-12-19号化合物 灵感\n“就是那一瞬间！”\n化合度：41.3fd \n世界解析度：482.7sa\n维度活动性：3278da\n概率+Senoviar"
Creation["0_13_2"] = "0-13-17号化合物 熵增\n“万物的结局”\n化合度：32.78fd \n世界解析度：423.42sa\n维度活动性：4231da\n混沌+运动"
Creation["0_13_17"] = "0-13-17号化合物 叹息\n“只是看着……”\n化合度：19.28fd \n世界解析度：521.92sa\n维度活动性：9812da\n混沌+乐章"
Creation["0_13_19"] = "0-13-19号化合物 恐惧\n“人最恐惧的，就是未知，不断扩大，不断袭来的未知”\n化合度：39.122fd \n世界解析度：235.124sa\n维度活动性：8789da\n混沌+Senoviar"
Creation["0_13_21"] = "0-13-21号化合物 黑洞\n“不断长大的巨口”\n化合度：91.21fd \n世界解析度：923.76sa\n维度活动性：921321872.36da\n混沌+吞噬"
Creation["0_14_11"] = "0-14-11号化合物 微积分\n“→”\n化合度：39.23fd \n世界解析度：3121.23sa\n维度活动性：8923.1da\n极限+坐标"
Creation["0_14_14"] = "14=14号聚合物 微观\n“.”\n化合度：13fd \n世界解析度：4123sa\n维度活动性：0.00321da\n极限+极限"
Creation["0_14_15"] = "0-14-15号化合物 无限\n“∞”\n化合度：∞fd \n世界解析度：∞sa\n维度活动性：∞da\n！受到认知干扰！\n极xiaidarea+yyzyjqwdaj宙"
Creation["0_14_18"] = "0-14-18号化合物 门扉\n“通向另一个世界”\n化合度：31.213fd \n世界解析度：542.729sa\n维度活动性：2434da\n极限+衰变"
Creation["0_15_0"] = "0-15-0号化合物 尘埃\n“尘归尘，土归土”\n化合度：97.87fd \n世界解析度：31.231sa\n维度活动性：821721313da\n混沌+咏叹调"
Creation["0_15_11"] = "0-15-11号化合物 星系\n“它们一直都在看着你，你无处可逃”\n化合度：34.9fd \n世界解析度：432.02sa\n维度活动性：2317da\n宇宙+坐标"
Creation["0_15_14"]= "投影空间：虫洞\n“一只小虫子咬破了界限，平行宇宙”\n投影范围：？\n乐章+混沌"
Creation["0_15_18"] = "0-15-18号化合物 坍缩\n“任何事物都将消逝，哪怕是宇宙”\n化合度：31.348fd \n世界解析度：219.712sa\n维度活动性：3476da\n宇宙+衰变"
Creation["0_15_19"] = "0-15-19号化合物 黑暗\n“它笼罩着那些未知的事物”\n化合度：78.4fd \n世界解析度：710.09sa\n维度活动性：7162da\n宇宙+Senoviar"
Creation["0_16_16"] = "16=16号聚合物 交易\n“以物易物”\n聚合度：129.23fd \n世界解析度：137.89sa\n维度活动性：9213da\n交换+交换"
Creation["0_16_9"] = "0-16-9号化合物 经济（纯度：低）\n“用它，掐紧一切的咽喉”\n化合度：107.61fd \n世界解析度：174.21sa\n维度活动性：8217da\n交换+社会"
Creation["0_16_13"] = "0-16-13号化合物 奉献\n“以自身和混沌交换希望”\n化合度：79.09fd \n世界解析度：217.13sa\n维度活动性：6271.91da\n交换+世界"
Creation["0_16_19"]= "0-16-19号化合物 迷惑\n“所设想的一切，走向未知，走向未解之谜”\n化合度：572.43fd \n世界解析度：393.2sa\n维度活动性：1141da\n交换+Senoviar"
Creation["0_16_22"] = "0-16-22号化合物 宽容\n“把自己放进别人的鞋子里”\n化合度：821.93fd \n世界解析度：1299.32sa\n维度活动性：32913da\n交换+突破"
Creation["0_17_0"]= "0-17-0号化合物 音\n“**--/*-**/---/-**-/*/*-*/-****”\n化合度：99.9fd \n世界解析度：23sa\n维度活动性：782319da\n乐章+起源"
Creation["0_17_13"]= "0-17-13号化合物 噪音\n“你吼那么大声干嘛”\n化合度：684.2fd \n世界解析度：428.72sa\n维度活动性：7132da\n乐章+混沌"
Creation["0_17_15"]= "投影空间： 旷野\n“聆听那自然的声音”\n折射范围：64km^2\n乐章+宇宙"
Creation["0_17_18"]= "0-17-18号化合物 谢幕曲\n“世界上最伟大的演奏，拉上帷幕！”\n化合度：416.77fd \n世界解析度：191.7sa\n维度活动性：7261da\n乐章+衰变"
Creation["0_18_10"]= "0-18-10号化合物 腐化\n“Wenn das Licht dunkel wird”\n化合度：0.021fd \n世界解析度：1.87sa\n维度活动性：7da\n衰变+时间"
Creation["0_18_13"]= "0-18-13号化合物 崩溃\n“向着一切崩塌的前方前进”\n化合度：827.12fd \n世界解析度：328.2sa\n维度活动性：3827da\n衰变+混沌"
Creation["0_18_15"]= "0-18-15号化合物 消逝\n“抵达，终点？”\n化合度：359.79fd \n世界解析度：726.3sa\n维度活动性：1108da\n衰变+宇宙"
Creation["0_18_21"]= "0-18-21号化合物 融解\n“撕扯，露出血肉”\n化合度：3291332fd \n世界解析度：8239321sa\n维度活动性：32022121da\n衰变+吞噬"
Creation["0_19_1"]= "0-19-1号化合物 空白\n“有，无？”\n化合度：fd：873 \n世界解析度：432.7sa\n维度活动性：5263da\n Senoviar+存在"
Creation["0_19_19"]= "19=19号聚合物 Vacalosk\n“未知之团”\n聚合度：- \n世界解析度：-\n维度活动性：-\n Senoviar+Senoviar"
Creation["0_19_20"]= "0-19-20号化合物 黑箱\n“黑暗的地方应该填上一些东西才对”\n化合度：873fd \n世界解析度：432.7sa\n维度活动性：5263da\n Senoviar+意识"
Creation["0_19_22"]= "0-19-22号化合物 真相\n“消灭未知”\n化合度：732.69fd \n世界解析度：923.8sa\n维度活动性：9238da\n Senoviar+突破"
Creation["0_20_1"] = "0-20-1号化合物 对立\n“镜之此岸”\n化合度：100fd \n世界解析度：3.123sa\n维度活动性：0\n意识+存在"
Creation["0_20_10"] = "0-20-10号化合物 忘却\n“Aufnahme starten”\n化合度：fd \n世界解析度：sa\n维度活动性：\n意识+时间"
Creation["0_20_20"] = "20=20号聚合物 唯心\n“存在即被感知，物是观念的集合”\n聚合度：100fd \n世界解析度：-281.732sa\n维度活动性：0\n意识+意识"
Creation["0_21_21"] = "||||||聚合物 深渊\n“■■■■■■■■■■■■■”\n聚合度：！突破最大量程！\n世界解析度：！突破最大量程！\n维度活动性：！突破最大量程！\n光感性极弱\n吞噬+吞噬"
Creation["0_21_22"] = "XXXXXX化合物 深渊+\n“■■■■■■■■■■■■■”\n聚合度：！突破最WQFTFF！\n世界解析度：！突REFVX程！\n维度活动性：！突破XASD量程！\n**合成台受损！--已自动修复**\n吞噬+吞噬"

Remnant = {
"世界解析度：\n在世界为参照系下各元素的对周围元素的影响程度\n可以用作辨别不同物质。\n单位：wa（senro analysis）\n————《世界研究学会笔记》",
"维度活动性：\n元素在相邻维度间跨越所需的能量比值\n计算公式：维度跨越前能量:向高一级维度跨越后的能量\n注：所有元素所能跨越范围有限，同样，他们所能存在的维度区域也是有限的\n单位：da（dimension activity）\n————《世界研究学会笔记》",
"化合度/聚合度：\n不同元素组合时的所需元素体积之比或者能够聚合物的元素的最小体积\n化合度计算公式：化合载体元素体积:化合组合元素体积\n单位：fd（fusion degree）\n————《世界研究学会笔记》",
"世界未饱和度：\n元素的侵略性（即和其他元素渴望反应的程度）\n单位：sus（senro unsaturation)\n————《世界研究学会笔记》",
"空间衰变时间：\n元素在一个维度中的最大存活时间，可用于追踪元素轨迹。\n单位：毫秒（ms）\n————《世界研究学会笔记》",
"解析工作台：\n“解析世界之台”\n现使用的实验台提供21个已解明元素，需要进行序列解析得到更多的元素。\n已解明元素已知其世界解析度、维度活动性、世界未饱和度和空间衰变时间。\n合成的元素给出其化合度/聚合度，世界解析度和维度活动性。\n解析台的操作方式：将一种元素添加至载体元素中\n————《世界研究学会笔记》",
"再次创造出的元素由于纯度的问题无法作为载体元素，不过用于其他元素上是没有问题的\n————《世界研究学会笔记》",
"世界之树：\n引导者工作的场所，由于“隔离世界的高墙”的阻挡，只有引导者才能进入这个地方。\n————《世界研究学会笔记》",
"引导者：\n每当世界面临崩溃时，人类中能够引导世界走上正规的人就会被选择来到世界之树，他们便是引导者。\n————《世界研究学会笔记》",
"这是什么地方，难道说是，梦？\n————《█▆▋▌▋▃▄▌▆的日记》",
"观测者会提供世界损毁的信息，留意他们。（.SeRb_O）\n————《世界研究学会笔记》"
}

Remnant_Extra = {
    "事实上，来到这个的地方人，都将修复这个世界\n————《世界研究学会笔记》",
    "多种元素相互融合，融合出的融合体应该可以用来修补世界\n————《█▆▋▌▋▃▄▌▆的日记》",
    "观测者会提供世界损毁的信息，留意他们。（.SeRb_O）\n————《世界研究学会笔记》",
    "隔离世界的高墙立在这个地方，因此我收到的信息全是乱码，凸(艹皿艹 )\n————《█▆▋▌▋▃▄▌▆的日记》",
    "5种元素，5种元素我该试多久啊啊啊啊，谜语人滚出世界树！\n————《█▆▋▌▋▃▄▌▆的日记》",
    "第21和第1号元素相当特殊，和它融合后物质的各个性质都会激增",
    "速度维，xyz维，时间维，电磁力维，斥力维这组成了我们的八位世界，任何一个维度的破坏都会引起世界的毁灭。\n————《世界研究学会笔记》",
    "历史上出现过这样一个情况：所有的生物开始倒退，生物开始横向延伸，以至于压扁，推测是xy维和时间维遭到了破坏。\n————《观测者手记》",
    "世界研究学会是个研究这个世界组成元素以及构成原理的组织。引导者使用的所有储存元素以及工作台，都是他们杰作。\n————《观测者手记》",
    "历史上的引导者不止一位，身为观测者必须辅佐每一个引导者，哪怕献出生命。\n————《观测者手记》"
}