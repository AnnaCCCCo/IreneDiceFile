local text = string.sub(msg.fromMsg,#"uin")

local temp = string.sub(text,string.find(text,"\"pics\""),"-1")
temp = string.sub(temp,string.find(temp,"qungz/")+6,"-1")
local album = string.sub(temp,"1",string.find(temp,"/")-1)
temp = string.sub(temp,string.find(temp,"/")+1,"-1")
local pic = string.sub(temp,"1",string.find(temp,"!!")-1)

if string.find(pic,"*") then
    pic = string.sub(pic,"1",string.find(pic,"*")-1)
end

-- albumCodeFile = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAAlbumCodeList" .. msg.fromGroup .. ".csv", "r")
-- albumscode = goodsCodeFile:read("*a")
local temp = string.sub(text,string.find(text,"\"meta\"")+7,"-1")
local discribe = string.sub(temp,string.find(temp,"\"desc\"")+8,string.find(temp,"\"h5Url\"")-3)

for line in io.lines("C:\\Users\\Administrator\\OneDrive\\Lists\\AAAAlbumCodeList" .. msg.fromGroup .. ".txt") do
    if string.find(line,album) then
        albumName = string.sub(line,string.find(line,",")+1,"-1")
        if albumName == "囤货" then
            file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\AAA_Storage.csv", "a+")
            file:write("- "..discribe.."\n")
            file:close()
            msg.discribe = discribe
            return "{reply_upload_storage}"
        end
    else
        msg.goodscode = pic

        msg.discribe = discribe
        
        return "{reply_upload_pics}"
    end
end

-- AAA_Storage.csv
