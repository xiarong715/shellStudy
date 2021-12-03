#!/bin/bash

# 参考：https://www.cnblogs.com/kevingrace/p/5996133.html
# 字符串操作

# 计算字符串长度
str="/usr/bin/rek"

len=${#str} # 求长度
echo $str ":" $len

len=`expr length ${str}` # 求长度，反引号把命令引起来
echo $str ":" $len
echo "------------------------"

# 若字符串本身有空格，用双引号引起来
str="hello world"
len=${#str}                # 可正确处理带空格的字符串
echo $str ":" $len
# len=`expr length ${str}` # syntax error
len=`expr length "${str}"` # 字符串有空格，需用双引号引起来，因为expr length只能带一个参数，有空格会认为有多个参数
echo $str ":" $len
echo "------------------------"

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
len=`expr match "${str}" "lsy"`
echo "lsy" ":" $len
len=`expr match "${str}" "ls.*"`
echo "ls.*" ":" $len
len=`expr match "${str}" "good"`
echo "good" ":" $len
echo "------------------------"

# ${substring}可以是正则表达式
str="SAY I'm 18"
len=${#str}
echo $str ":" $len
len=`expr length "${str}"`
echo $str ":" $len
len=`expr match "${str}" "[A-Z]*"`
echo "[A-Z]*" ":" $len

# -------------------------------------------------------------------





