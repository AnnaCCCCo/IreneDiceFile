# IreneDiceFile

代码具体逻辑位于mod/Get_Goods下

dice！开发手册：https://v2docs.kokona.tech/zh/latest/Develop_Manual.html#mod

dice！论坛：https://forum.kokona.tech/

### 开发计划：
1. 接转单逻辑（已完成）
2. txt手速表自动转为excel肾表（进行中）
3. 将cn-qq号对应文件存到本地，而不是写到脚本里（未开始）
4. 查询明日方舟干员精二/专三材料（已完成）
5. 定时催肾（未开始）
6. txt手速表自动转为excel排表（未开始）
7. 根据排表自动更新余量（未开始）
8. 定时推送余量图（未开始）
9. html自动制作余量图（未开始）
10. 根据群不同而自动区分背包（未开始）

### 已知问题：
1. 转单/撤排也会被读取到排表里。目前没有想到较好的关键词识别方式
2. 某些神奇的情况下reply_get_goods.lua的第16行（读取群内群名片）功能会返回空值，无报错，未知bug触发条件。暂时的解决方法是将该行最后的【""】改为【0】，保存，运行，再改回来即可
3. 无法及时读取群名片更改（怀疑与Dice！的刷新时间有关系？）

### 11.9更新日志
1. 新上传图片的描述会被自动读取，但因为tx会省略较长的描述，这段描述通常只能显示一半
2. 上传了全新的mirai框架一键安装器

### 11.4更新日志
1. 将排的谷按照群号+谷的格式存到了本地个人文档里
2. 更改Lists的存储路径为OneDrive，现在支持远程查看了

### 10.15更新日志：
1. 能识别肾表了
2. 谷子名称的本地文件以群号区分

### 10.8更新日志：
1. 可查询明日方舟干员精英化/专精材料（爬取prts）
2. 现在没有改群名片就排谷的会读取qq昵称
3. 优化了一下本地排表存储形式

### 9.29更新日志：
1. 在本地user文件夹下找到了PlayerCards_Inventory，即背包mod的本地存储路径。该文件是二进制.bak文件，使用文本编辑器打开会显示一部分代码和一部分list，够用。
2. 增加了一键催肾功能（使用方法：【催肾 [qq号] [qq号] [qq号] 消息：[具体催肾消息]】，注意“消息：”不能省略，qq号排列无数量限制但每项之间需要有空格）

### 9.26更新日志：
1. 在goodlist里记录了图片序列号的长度，以方便进行谷子序列号与名字之间的对应查找。
2. 目前可以识别妈位图
3. 目前可以识别接转单，但是无法识别转单，并且没有想到一个很好的方法去识别转单（如果识别词定为“转”，那如果以后出了一个谷，里面带着个字就会被疯狂识别为转单）。因此目前的解决方案是将转单与接转均记录至本地文件，之后由打表咪手动改表。
4. 定位到了某些相册无法识别图片序列号的bug，已改完。（原因是某些相册的序列号内含有“！！”字符，与图片序列号的判定冲突，导致查找字符串的时候会提前结束。目前的解决方案是跳过相册序列号，再进行图片序列号的查找）

### 9.24更新日志：
1. 更新了蓝山咪的cn
2. 现在可以使用命令设置谷子图片名称了（使用方法：【设置谷子名称 [谷子序列号] 名：xxxxx】注意命令无任何形式的括号）
3. 谷子名称本地读取
4. 读取手速排表（使用方法：看看手速排表[谷子名称]）
5. 文档以群组名称分类