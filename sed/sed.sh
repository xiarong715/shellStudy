#!/bin/bash

# 参考：https://www.cnblogs.com/linux-wangkun/p/5745584.html

# sed study
# 编辑流中的字符串，流可以为文件和管道
# sed 's/原字符串/替换字符串/'  #替换最早匹配到的字符串
# sed 's/原字符串/替换字符串/g'     #替换所有匹配到的字符串
# sed 处理过的字符会直接输出到屏幕上，-i 则把输出写入到文件中
filename="testfile"
sed -i "s/LOCALHOST/127.0.0.1/g" $filename  # -i 把修改写入到文件中，而不是打印在屏幕上
sed -i "s#127.0.0.1#LOCALHOST#g" $filename

sed -i "2,3s#LOCALHOST#127.0.0.1#g" $filename # 替换第二行到第三行
sed -i "2s#LOCALHOST#127.0.0.1#g" $filename # 替换第二行
sed -i '$s#LOCALHOST#127.0.0.1#g' $filename   # 替换第后一行
sed -i '2,$s#LOCALHOST#127.0.0.1#g' $filename # 替换第二行到最后一行

# 特殊符号： ^：表示行首  $：在引号中表示行尾，在引号外表示末行（最后一行） 这是网上的解释
# 个人认为 $在和s一起时，不是在原字符串中时，代表最后一行；在原字符串中时，表示行尾
# 行首编辑
sed -i 's#^#lsy&#g' $filename   # 所有行首加lsy，注意&符号
sed -i 's#lsy##g' $filename     # 去掉lsy

# 行尾编辑
sed -i 's#$#&lsy#g' $filename   # 所有行尾加lsy，注意&符号
sed -i 's#lsy##g' $filename     # 去掉lsy

# 多条命令用";"分隔
sed -i 's#^#git clone &#g; s#$#&.git#g' $filename     # 所有行首加"git clone "，所有行尾加".git"


str="hello world"
echo $str
str=`echo ${str} | sed "s#world#lsy#g"` # 替换管道中的字符串，并重新赋给变量
echo $str