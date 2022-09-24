# IreneDiceFile
 
//把Get_Goods.json和Get_Goods文件夹一起放到mod文件夹下

代码具体逻辑在mod/Get_Goods/script/reply_get_goods.lua下
回复语句在speech/yaml下

dice开发手册：https://v2docs.kokona.tech/zh/latest/Develop_Manual.html#mod
dice论坛：https://forum.kokona.tech/

9.24更新日志：
1.更新了蓝山咪的cn
2.现在可以使用命令设置谷子图片名称了（使用方法：【设置谷子名称 [谷子序列号] 名：xxxxx】注意命令无任何形式的括号）
3.谷子名称本地读取
4.读取手速排表（使用方法：看看手速排表[谷子名称]）
5.文档以群组名称分类

已知问题：
1.只要弹窗了就会被记下来并存到本地文档
2.某些特定相册无法读取图片序列号
3.个人list并未存储到本地文档，有数据丢失的风险
