filename = string.match(msg.fromMsg, "^[%s]*(.-)[%s]*$", #"&煤炉" + 1)

res,mer=http.get("https://www.mercari.com/jp/items/m79726904245")

if string.find(mer,"Price__Styled") then

    return 1
else return 0
end

--<mer-price class="Price__StyledItemPrice-sc-1b74han-0 hexbDe mer-spacing-r-8" data-testid="price" value="1530" mer-defined=""></mer-price>