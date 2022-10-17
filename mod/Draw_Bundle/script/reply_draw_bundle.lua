--pc = getPlayerCard(msg.uid,msg.gid or 0)
--raw_str = msg.fromMsg
raw_str = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"抽捆"+1)
local split_str_list = {}
local split_char = '，'
string.gsub(raw_str,'[^'..split_char..']+',function ( w )
    table.insert(split_str_list,w)
end)
 
local name_weight_tab = {}
weight_collection = {}

for i = 1, #split_str_list do
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

local total_num = 0

for name, weight_num in pairs(name_weight_tab) do      
    total_num = weight_num + total_num
end 

local random_num = ranint(1,total_num)
-- local res_name = ""
-- 
-- local normalize_total_val = 0.0
-- for name, weight_num in pairs(name_weight_tab) do      
--     normalize_total_val = weight_num/total_num + normalize_total_val
--     if (normalize_total_val > random_num)
--     then
--         res_name = name
--         break
--     end
-- end 
-- 
msg.random_num = random_num
msg.res_name = weight_collection[random_num]

return "{reply_draw_res}"
