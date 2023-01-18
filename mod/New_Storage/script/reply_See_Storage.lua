stroage = {}

file = io.open("C:\\Users\\Administrator\\OneDrive\\Lists\\" .. msg.fromGroup .. "\\AAA_Storage.csv", "r")
filetext = file:read("*a")

msg.list = filetext

return "{reply_see_storage}"