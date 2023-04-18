raw_str = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"&抽选"+1)

local split_str_list = {}
local split_char = '，'
string.gsub(raw_str,'[^'..split_char..']+',function ( w )
    table.insert(split_str_list,w)
end)
 
local name_weight_tab = {}
weight_collection = {}

local total_select_num = 0

local info_str = split_str_list[1]
local split_info_list = {}
local split_info_char = '+'
string.gsub(info_str,'[^'..split_info_char..']+',function ( w )
    table.insert(split_info_list,w)
end)

local draw_info_table = {}
for i = 1, #split_info_list do
    draw_info_table[split_info_list[i]] = tonumber(split_info_list[i+1])
    i = i + 2
end
local draw_info = split_info_list[1]
local draw_num = tonumber(split_info_list[2])

for i = 2, #split_str_list do
    local name_weight_list = {}
    local name_weight_split_char = ' '
    string.gsub(split_str_list[i],'[^'..name_weight_split_char..']+',function ( w )
        table.insert(name_weight_list,w)
    end)
    name_weight_tab[name_weight_list[1]] = tonumber(name_weight_list[2])

    for i=1,name_weight_list[2] do
        table.insert(weight_collection,name_weight_list[1])
    end
end



local total_res_tab = {}
local total_name_tab = {}

for draw_info, draw_num in pairs(draw_info_table) do
    local cur_remaining_draw_num = draw_num
    local res_num_tab = {}
    local res_name_tab = {}
    while( cur_remaining_draw_num > 0 )
    do
        -- 直接用weight_collection的长度来进行总数计算
        local total_num = #weight_collection
        local random_num = ranint(1,total_num)

        table.insert(res_num_tab, random_num)
        table.insert(res_name_tab, weight_collection[random_num])

        -- 删除权重表里的对应项目
        table.remove(weight_collection, random_num)

        cur_remaining_draw_num = cur_remaining_draw_num - 1
    end
    local res_name_count = {}
    for i = 1, #res_name_tab do
        if res_name_count[res_name_tab[i]] == nil then
            res_name_count[res_name_tab[i]] = 1
        else
        res_name_count[res_name_tab[i]] = res_name_count[res_name_tab[i]] + 1
        end

        if total_name_tab[res_name_tab[i]] == nil then
            local init_tab = {}
            init_tab[draw_info] = 1
            total_name_tab[res_name_tab[i]] = init_tab
        else
            if total_name_tab[res_name_tab[i]][draw_info] == nil then
                total_name_tab[res_name_tab[i]][draw_info] = 1
            else
                total_name_tab[res_name_tab[i]][draw_info] = total_name_tab[res_name_tab[i]][draw_info] + 1
            end
        end
    end
    cur_res_key = draw_info..draw_num
    total_res_tab[cur_res_key] = res_name_count
end

msg.res_table = total_res_tab
msg.name_res_table = total_name_tab

return  "{reply_draw_res}"