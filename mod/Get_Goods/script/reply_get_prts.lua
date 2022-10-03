text = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"查询干员"+1)

name = string.sub(text,"1",string.find(text," ")-1)
detail = string.sub(text,string.find(text," ")+1)

res,prts=http.get("https://prts.wiki/w/"..name)
if res == false then
    return "干员名称输入有误，请重新输入~"
end
elements = {}

if detail == "精一" then
    if string.find(prts,"精英阶段0→1") then
        temp = string.sub(prts,string.find(prts,"精英阶段0→1"),"-1")
        things = string.sub(temp,"1",string.find(temp,"</td>")+4)
    else
        return "干员"..name.."无法精一~"
    end

    table.insert(elements,"干员"..name.."精英阶段0→1总计需要材料：\n")
    repeat
        thing = string.sub(things,string.find(things,"title=\"")+7,string.find(things,"img alt=")-4)
        num = string.sub(things,string.find(things,"FFFFFF;\">")+9,string.find(things,"</span></div>")-1)
        things = string.sub(things,string.find(things,"</span></div>")+13,"-1")
        table.insert(elements,"- "..thing.." * "..num.."\n")
    until string.find(things,"</span></div>") == nil

    return table.concat(elements)
end

if detail == "精二" then
    if string.find(prts,"精英阶段1→2") then
        temp = string.sub(prts,string.find(prts,"精英阶段1→2"),"-1")
        things = string.sub(temp,"1",string.find(temp,"</td>")+4)
    else
        return "干员"..name.."无法精二~"
    end

    table.insert(elements,"干员"..name.."精英阶段1→2总计需要材料：\n")
    repeat
        thing = string.sub(things,string.find(things,"title=\"")+7,string.find(things,"img alt=")-4)
        num = string.sub(things,string.find(things,"FFFFFF;\">")+9,string.find(things,"</span></div>")-1)
        things = string.sub(things,string.find(things,"</span></div>")+13,"-1")
        table.insert(elements,"- "..thing.." * "..num.."\n")
    until string.find(things,"</span></div>") == nil

    return table.concat(elements)
end

if string.find(detail,"技能专") then
    if string.find(prts,"专精训练") then
        temp = string.sub(prts,string.find(prts,"专精训练"),"-1")
        things = string.sub(temp,"1",string.find(temp,"</tbody>")+4)
    else
        return "干员"..name.."无法进行技能专精~"
    end

    table.insert(elements,"干员"..name..detail.."需要材料：\n")
    repeat
        thing = string.sub(things,string.find(things,"title=\"")+7,string.find(things,"img alt=")-4)
        if string.len(thing)==0 then
            thing ="技巧概要·卷3"
        end
        num = string.sub(things,string.find(things,"FFFFFF;\">")+9,string.find(things,"</span></div>")-1)
        things = string.sub(things,string.find(things,"</span></div>")+13,"-1")
        table.insert(elements,"- "..thing.." * "..num.."\n")
    until string.find(things,"</span></div>") == nil

    if detail == "一技能专一" or detail == "1技能专一" or detail == "一技能专1" or detail == "1技能专1" then
        start = 2
        ed = 4
    end

    if detail == "二技能专一" or detail == "2技能专一" or detail == "二技能专1" or detail == "2技能专1" then
        start = 5
        ed = 7
    end

    if detail == "三技能专一" or detail == "3技能专一" or detail == "三技能专1" or detail == "3技能专1" then
        start = 8
        ed = 10
    end

    if detail == "一技能专二" or detail == "1技能专二" or detail == "一技能专2" or detail == "1技能专2" then
        start = 11
        ed = 13
    end

    if detail == "二技能专二" or detail == "2技能专二" or detail == "二技能专2" or detail == "2技能专2" then
        start = 14
        ed = 16
    end

    if detail == "三技能专二" or detail == "3技能专二" or detail == "三技能专2" or detail == "3技能专2" then
        start = 17
        ed = 19
    end

    if detail == "一技能专三" or detail == "1技能专三" or detail == "一技能专3" or detail == "1技能专3" then
        start = 20
        ed = 22
    end

    if detail == "二技能专三" or detail == "2技能专三" or detail == "二技能专3" or detail == "2技能专3" then
        start = 23
        ed = 25
    end

    if detail == "三技能专三" or detail == "3技能专三" or detail == "三技能专3" or detail == "3技能专3" then
        start = 26
        ed = 28
    end
    
    return table.concat(elements,"",1,1)..table.concat(elements,"",start,ed)
end

return "输入查询项有误，请重新输入~"