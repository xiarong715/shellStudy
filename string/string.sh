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

# 截取字符串
# 使用正则表达式截取子串，但只能截取string开头或结尾的子串
# 截取字符串开头的子串，格式
# 格式一：expr match $string ''
# 格式二：expr $string : ''

# 截取字符串结尾的子串，格式
# 格式一：expr match $string '.*'
# 格式二：expr $string : '.*'       # note:  .* 表示任意字符的任意重复，一个 . 表示一个字符
# 与匹配字符串长度的区别是：截取字符串的正则达式用小括号括起来了
str="20211207helloWORLDwuhan"
echo `expr match "${str}" '\([0-9]*\)'`     # 20211207
echo `expr match "${str}" '\([0-9]*\)'`     # 20211207
echo `expr "${str}" : '\([0-9]*\)'`         # 20211207

echo `expr match "${str}" '.*\(.\)'`        # n         # 一个 . 表示一个字符
echo `expr match "${str}" '.*\(..\)'`       # an
echo `expr "${str}" : '.*\(..\)'`           # an

str="helloWORLD20211207wuhan"
echo `expr match "${str}" '\([a-z]*\)'`     # hello
echo `expr match "${str}" '\([a-Z]*\)'`     # helloWORLD
echo `expr match "${str}" '\([a-Z]*[0-9]*\)'` # helloWORLD20211207
echo `expr match "${str}" '.*\(.....\)'`   # wuhan，截取字符串结尾的子串时，只能指字符的个数吗


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

# 字符串替换
# 替换子串命令可以在任意处、开头处、结尾处替换满足条件的子串，其中substring都不是正则表达式而是通配符
# 格式一：${string/substring/replacement} ， 仅替换第一次与substring匹配的子串
# 格式二：${string//substring/replacement} ，替换所有与substring匹配的子串
str="hello world world"
str=${str/world/lsy}    # 替换第一个world
echo "str" ":" $str
str=${str//world/lsy}   # 替换所有的world
str=${str/ /--} # 替换空格
echo "str" ":" $str
str=${str// /--} # 替换所有空格
echo "str" ":" $str

# 在开头处替换，格式为：${string/#substring/replacement}
# 在结尾处替换，格式为：${string/%substring/replacement}
str="good boby"
str=${str/#g/G} # 替换开头的g
echo "str" ":" $str
str=${str/%y/Y} # 替换结尾的y
echo "str" ":" $str

# ${!varprefix*} ${!varprefix@}
test="gogo"
test1="gogo1"
test2="gogo2"
test3="gogo3"
echo "{!test*}" ":" ${!test*}
echo "{!test@}" ":" ${!test@}

# 判断读取变量值
# var="string"
default="str"
ERR_MSG_DEFINE="not define"
ERR_MSG_INITIAL="not initial"
echo ${var-${default}}  # 如果var没声明，则${default}作为最终的值
echo ${var:-${default}} # 如果var没声明，或var值为空，则${default}作为最终的值
echo ${var=${default}}  # 如果var没声明，则${default}作为最终的值
echo ${var:=${default}} # 如果var没声明，或var值为空，则${default}作为最终的值
echo ${var+${default}}  # 如果var声明了，那么${default}作为最终的值
echo ${var:+${default}} # 如果var被设置了，不为空，那么${default}作为最终值
echo ${var?$ERR_MSG_DEFINE}    # 如果var没声明，那么最终值为${ERR_MSG_DEFINE}
echo ${var:?$ERR_MSG_INITIAL}   # 如果var没被设置，那么最终值为${ERR_MSG_INITIAL}

# -------------------------------------------------------------------
# 获取shell变量值，只需在变量名前加一个"$"，用大括号把变量名括起来，是一种好的编程习惯
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

# shell 正则表达式
# ^：表示匹配行首，如^d，表示以d开头
# $：表示匹配行尾，如/$，表示以/结尾
# *：通配符，表示匹配0次或多次前一字符
# +：表示匹配一个或多个前一字符
# ?：表示匹配0个或一个前一字符
# .：表示匹配任意字符，除换行符


# 如何判断一个字符串是否由字母或数字开头
str="hsol-M202"
echo $str | grep '^[A-Za-z0-9]'

# 如何判断一个字符串是否由字母或数字结尾
str="hsol-M203"
echo $str | grep '[A-Za-z0-9]$'

# 删除字符串中指定的字符
# sed 中分隔符可以换，只要一致即可
echo "2021-12-08 17:10:50" | sed 's/-//g' | sed 's/://g'    # 删除 - 和 :
echo "2021-12-08 17:10:50" | sed 's#-##g' | sed 's#:##g'
echo "2021-12-08 17:10:50" | sed 's@-@@g' | sed 's@:@@g'

# 删除字符串中的特殊字符，特殊字符使用\转义
echo "#$@abc123" | sed 's/\#//g' | sed 's/\$//g' |  sed 's/\@//g'
# 使用 tr -d 命令删除字符
echo "#$@abc123" | tr -d '#' | tr -d '$' | tr -d '@'

#  echo $$  # 打印进程号

# sed 也支持正则
echo -e "123\nabc\n456\ndef" | sed -n '/[0-9]/p'    # echo -n 使能转义字符, 将匹配数字的行打印出来, sed -n 不会把输入打印出来
sed -n '/[0-9]/p' filename                          # 将文件中匹配数字的行打印出来
sed -n '/[a-z]/p' filename
sed -n '/[A-Z]/p' filename

echo -e "123\nabc\n456\ndef" | sed '/[0-9]/d'       # 将匹配数字的行删除，有在屏幕打印出没删除的行
sed -n '/[0-9]/d' filename                          # 将文件中匹配数字的行删除，改动没写入文件，且不在屏幕上打印出没删除的行
sed -i '/[0-9]/d' filename                          # 将文件中匹配数字的行删除，并且将改动写入文件
sed -n '/[A-Z]/d' filename                          # 将文件中匹配大写字母的行删除，改动不写入文件
sed -n '/[a-z]/d' filename                          # 将文件中匹配小写字母的行删除，改动不写入文件

echo -e "123root\nabcroot\n456root" | sed '/[0-9]/s/root/ipanel/g'  # 匹配数字的行，将root替换为ipanel
echo -e "123ROOT\nabcROOT\n456ROOT" | sed '/[a-z]/s/ROOT/ipanel/g'  # 匹配小写字母的行，将ROOT替换为ipanel
echo -e "123root\nABCroot\n456root" | sed '/[A-Z]/s/root/ipanel/g'  # 匹配大写字母的行，将root替换为ipanel

# tr 也技持正则
echo "hooweek132RFS" | tr -d '[a-z]'    # 删除字符串中的小写字母
echo "hooweek132RFS" | tr -d '[A-Z]'    # 删除字符串中的大写字母
echo "hoowekk132RFS" | tr -d '[0-9]'    # 删除字符串中的数字

# 匹配邮箱
echo "xiarong2010@163.com" | grep '^[A-Za-z0-9]*\@[a-z0-9]*\.[A-Za-z]*$'        # ok
echo "xiarong2010@mail.com" | grep '^[A-Za-z0-9]*\@[a-z0-9]*\.[A-Za-z]*$'       # ok
echo "xiarong2010@QQ.com" | grep '^[A-Za-z0-9]*\@[a-z0-9]*\.[A-Za-z]*$'         # no


# shell 字符串
# shell脚本中字符串可以使用双引号、单引号、不使用引号来定义
str=helloworld
str='helloworld'
str="helloworld"
echo $str

# shell不使用引号定义字符串，在给变量赋值字符串时，字符串中不允许有空格
ID=mac
echo $ID

# shell使用单引号定义字符串，单引号内的任何字符都会原样输出，单引号字符串中变量是无效的
ID='mac'
echo $ID
str='lsy $ID'   # $ID会当作普通字符串处理
echo $str       # lsy $ID，$ID原样输出

# shell使用双引号定义字符串，双引号里可以出现变量，可以出现转义字符
ID="mac"
echo $ID
str="lsy \"$ID\""   # 双引号内有变量和转义字符
echo $str           # lsy "mac"







