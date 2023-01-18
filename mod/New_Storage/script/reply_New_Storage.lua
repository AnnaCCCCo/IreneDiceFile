local text = string.sub(msg.fromMsg, #"uin")

-- local temp = string.sub(text,string.find(text,"\"pics\""),"-1")
-- temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
-- temp = string.sub(temp,"1",string.find(temp,"/")-1)
-- --local pic = string.sub(temp,"1",string.find(temp,"!!")-1)

-- -- if string.find(pic,"*") then
-- --     pic = string.sub(pic,"1",string.find(pic,"*")-1)
-- -- end

-- -- msg.goodscode = pic

-- -- local temp = string.sub(text,string.find(text,"\"meta\"")+7,"-1")
-- -- local discribe = string.sub(temp,string.find(temp,"\"desc\"")+8,string.find(temp,"\"h5Url\"")-3)
-- -- msg.discribe = discribe

return temp