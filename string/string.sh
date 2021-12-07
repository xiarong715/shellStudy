#!/bin/bash

# 参考：https://www.cnblogs.com/kevingrace/p/5996133.html
# 字符串操作

# 计算字符串长度
str="/usr/bin/rek"

# -------------------------------------------------------------------
len=${#str} # 求长度
echo $str ":" $len

len=`expr length ${str}` # 求长度，反引号把命令引起来
echo $str ":" $len
echo "------------------------"

# -------------------------------------------------------------------
# 若字符串本身有空格，用双引号引起来
str="hello world"
len=${#str}                # 可正确处理带空格的字符串
echo $str ":" $len
# len=`expr length ${str}` # syntax error
len=`expr length "${str}"` # 字符串有空格，需用双引号引起来，因为expr length只能带一个参数，有空格会认为有多个参数
echo $str ":" $len
echo "------------------------"

# -------------------------------------------------------------------
# 若字符串本身有空格，如果用单引号引起来
str="hello world"
len=${#str}
echo $str ":" $len
len=`expr length '${str}'` # 单引号引起来, 字符串去重去空格后的长度
echo $str ":" $len
echo "------------------------"

# -------------------------------------------------------------------
# 匹配字符串长度：即匹配字符串开头子串的长度
# expr math ${string} ${substring}
# 子串可以是字符串也可以是正则表达式
# 若字符串开头匹配不到则返回0
str="lsy is good"
len=${#str}
echo $str ":" $len
len=`expr length "${str}"`
echo $str ":" $len
len=`expr match "${str}" "lsy"`    # str中有空格，需加双引号
echo "lsy" ":" $len
len=`expr match "${str}" "ls.*"`
echo "ls.*" ":" $len
len=`expr match "${str}" "good"`
echo "good" ":" $len
echo "------------------------"

# -------------------------------------------------------------------
# ${substring}可以是正则表达式
str="SAy I'm 18"
len=${#str}
echo $str ":" $len
len=`expr length "${str}"`
echo $str ":" $len
len=`expr match "${str}" "[A-Z]*"`
echo "[A-Z]*" ":" $len
len=`expr "${str}" : "[A-Z]*"`  # 这种方式没有match
echo "[A-Z]*" ":" $len
len=`expr "${str}" : "[A-Z]*[a-z]*"`
echo "[A-Z]*[a-z]*" ":" $len
echo "------------------------"

# -------------------------------------------------------------------
# 匹配字符串索引，从左到右，索引从1开始
# expr index ${string} ${substring}
# 匹配${substring}在${string}最早出现的第一个字符出现的索引
str="love wuhan"
index=`expr index "${str}" "wu"`  # 字符串str中有空格，需用双引号
echo "wu index" ":" $index
index=`expr index "${str}" "love"`
echo "love index" ":" $index
index=`expr index "${str}" "han"`
echo "han index" ":" $index
echo "------------------------"


# -------------------------------------------------------------------
# 截取字符串
# 从左到右截取，左边默认从标号0开始
# 格式一：{string:position}，即从第position个字符开始截取到字符串最后一个字符
# 格式二：{string:position:length}，从第position个字符开始，截取length个字符
str="hello world"
substring=${str:0}    # 从标号0开始截取
echo "str:0" ":" $substring
substring=${str:6}
echo "str:6" ":" $substring
substring=${str:0:5}    # 从标号0开始截取，截取5个字符
echo "str:0:5" ":" $substring
echo "------------------------"

#截取字符串
# 从右到左数，右边默认从标号-1开始，截取也是从左到右
# 格式一：${string: -position}，冒号后有一个空格
# 格式二：${string:(-position)}，加括号就不用加空格
# 前两种格式，都是从-position的位置，截取到字符串尾部
# 格式三：${string:-position:length}，从第-postion个字符开始，截取length个字符
str="hello world"
substring=${str: -2}
echo "{str: -2}" ":" $substring
substring=${str:(-1)}
echo "{str:(-1)}" ":" $substring
substring=${str:1-6:5}  # 从右开始数，从第-5个字符开始截取，截取5个
echo "{str:1-6:5}" ":" $substring

# expr substr 截取字符串，从1开始标号
# expr substr ${string} $position $length
str="hello world"
substring=`expr substr "${str}" 7 5`  # 从1开始标号
echo "expr substr ${str} 7 5" ":" "${substring}"


# 删除字符串的子串
# 删除子串是指将原字符串中符合条件的子串删除
# 格式一：{string#substring}，删除开头处与substring匹配的最短子串，substring中可有通配符
# 格式二：{string##substring}，删除开头处与substring匹配的最长子串
# 格式三：{string%substring}，删除结尾处与substring匹配的最短子串
# 格式四：{string%%substring}，删除结尾处与substring匹配的最长子串
str="/usr/local/bin/rek"
name=${str##*/}     # rek
dirpath=${str%/*}   # /usr/local/bin
echo "name" ":" $name
echo "dirpath" ":" $dirpath

secondDirName=${str#/*/}    # 删除 /usr/
secondDirName=${secondDirName%%/*}
echo "secondDirName" ":" $secondDirName

TOOLPATH="/tc-allwir329-openwrt/toolchain/bin/aarch64-openwrt-linux-"
TOOLPATH=${TOOLPATH#/}      # 从左开始删除第一个匹配到的"/"
TOOLPATH=${TOOLPATH%%/*}    # 从右开始，删除从最后一个字符开始到第后一个匹配到的"/"，使用通配符"*"
echo "TOOLPATH%%/*" ":"　"${TOOLPATH}"








# -------------------------------------------------------------------
# 获取shell变量值，只需在变量名前加一个"$"，且用大括号把变量名括起来，是一种好的编程习惯
str="shell"
echo "I love" ${str}
echo "I love" $strscript    # 不加大括号，解译器会误认为strscript是变量名
echo "I love" ${str}script  # 加大括号，正确识别变量str
echo "------------------------"
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# shell 字符串可用单引号双引号包围或不用引号包围，在一些引起解释错误的地方，需要加上引号
echo "hello lsy"
echo 'hello lsy'
echo hello lsy
echo "------------------------"
# -------------------------------------------------------------------









