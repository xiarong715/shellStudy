#!/bin/bash

# 参考：https://www.cnblogs.com/linux-wangkun/p/5745584.html
# 参考：https://www.gnu.org/software/sed/manual/sed.html

# sed 流编辑，对流内容的辑辑（替换、删除、打印等）

# 语法 sed SCRIPT INPUTFILE...
# sed 's/hello/world/' input.txt > output.txt
# sed -i 's/hello/world/' input.txt

# sed study
# 编辑流中的字符串，流可以为文件和管道
# sed 's/原字符串/替换字符串/'  #替换最早匹配到的字符串
# sed 's/原字符串/替换字符串/g'     #替换所有匹配到的字符串
# sed 处理过的字符会直接输出到屏幕上，-i 则把输出写入到文件中
# sed 中分隔原字符串和替换字符串的分隔符可任意换，只要不引起歧义：如 "/"、"#"、"?" 等等都可以
filename="testfile"
sed -i "s/LOCALHOST/127.0.0.1/g" $filename  # -i 把修改写入到文件中，而不是打印在屏幕上
sed -i "s#127.0.0.1#LOCALHOST#g" $filename

sed -i "2,3s#LOCALHOST#127.0.0.1#g" $filename # 替换第二行到第三行
sed -i "2s#LOCALHOST#127.0.0.1#g" $filename # 替换第二行
sed -i '$s#LOCALHOST#127.0.0.1#g' $filename   # 替换第后一行
sed -i '2,$s#LOCALHOST#127.0.0.1#g' $filename # 替换第二行到最后一行

# 替换一行中第几次匹配到的模式
sed -i "s#LOCALHOST#127.0.0.1#2" $filename  # 替换第二次匹配到的字符串
sed -i "s/LOCALHOST/127.0.0.1/2" $filename  # 替换第二次匹配到的字符串
sed -i "s/LOCALHOST/127.0.0.1/3g" $filename # 替换第三次、第四次、第五次...匹配到的字符串


# /g /1 /2 /5g，都是针对行来説的

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


# sed
# syntax: sed OPTIONS... [SCRIPT] [INPUTFILE...]
# 参考：https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

# replacing or substituting string：Sed command is mostly used to replace the text in a file. The below simple sed command replaces the word “unix” with “linux” in the file.
# By default, the sed command replaces the first occurrence of the pattern in each line and it won’t replace the second, third…occurrence in the line.
sed 's/unix/linux/' geekfile.txt

# replacing the nth occurrence of a pattern in a line:  Use the /1, /2 etc flags to replace the first, second occurrence of a pattern in a line. 
# The below command replaces the second occurrence of the word “unix” with “linux” in a line.
sed 's/unix/linux/2' geekfile.txt

# replacing from nth occurrence to all occurrence in a line
# Use the combination of /1, /2 etc and /g to replace all the patterns from the nth occurrence of a pattern in a line. 
# The following sed command replaces the third, fourth, fifth… “unix” word with “linux” word in a line.
sed 's/unix/linux/3g' geekfile.txt

# parenthesize first character of each world: This sed example prints the first character of every word in parenthesis.
echo "Welcome To The Geek Stuff SF" | sed 's/\(\b[A-Z]\)/\(\1\)/g'      # \1 的值为前面第一个()中捕捉到的值
# \b   表示匹配文本中单词的开头或结尾字符，也能匹配字符组成的单词
# \bxx 匹配单词开头的xx位置，如\b[A-Z]匹配单词开头的大写字母，\bab匹配以ab开头的单词的ab位置
# xx\b 匹配单词结尾的xx位置，如[a-z]\b匹配单词结尾的小写字母，ab\b匹配以ab结尾的单词的ab位置
# \bxx\b 匹配单独以xx字符组成的单词，如\bgood\b匹配单词good

# \B        匹配文本中非单词开头和结尾的字符
# \Bxx      匹配单词非开头的xx位置，如\B[a-z]匹配单词非开头的小写字母，即非单词开头的小写字母的字符都被匹配到；
# xx\B      匹配单词开头的xx位置，如[A-Z]\B匹配单词开头的大写字母，即以大写字母开头的单词的首字母都被匹配到；
# \Bxx\B    匹配文本中不以xx开头和结尾的单词的xx位置，如\Btb\B匹配不以tb开头也不以tb结尾的单词的tb位置
# \bxx\B    匹配文本中以xx字符开头但不包括xx字符组成的单词的xx位置
# \Bxx\b    匹配文本中以xx字符结尾但不包括xx字符组成的单词的xx位置

# \1 代表正则捕捉到的第一个域，\2 代表正则捕捉到的第二个域，以此类推

# replacing string on a special line number: you can restrict the sed command to replacing the string on a special line number.
sed '3 s/unix/linux/g' ipanelfile.txt

# Each `sed' command consists of an optional address or address range,
# followed by a one-character command name and any additional command-specific code.

# sed command follow this syntax:
# [addr]X[options]
# addr是一个可选的行地址，可以是行号，行范围，正则匹配；
# X是一个命令，可以是s、d、p等等，可查看文档`info sed`，第3.2节'sed' commands summary；
# options根据命令不同而不同；

# s 命令
# s/REGEXP/REPLACEMENT/[FLAGS]
# [FLAGS]: 1 2 ... ， 指定第几次匹配到时替换；2g 3g .. ，指定从第几次匹配到时开始替换； g ，一行中的所有匹配到的都替换；sed命令是针一行操作的；
sed 's/abc/efg/2'   # 第二次匹配到abc时，把abc替换成efg，

sed '3 d'       ipanelfile.txt  # 删除第三行
sed '2,5 d'     ipanelfile.txt  # 删除第二行到第五行
sed '2,$ d'     ipanelfile.txt  # 删除第二行到最后一行
sed '$ d'       ipanelfile.txt  # 删除最后一行
sed '2~2 d'     ipanelfile.txt  # 从第二行开始，每二行的内容删除
sed '/abc/ d'   ipanelfile.txt  # 删除匹配abc的行
sed '/^foo/q42' ipanelfile.txt  # 打印所有行，直到foo开头的行，退出，状态码为42

sed '/abc/s/bc/aa/g' ipanelfile.txt # 匹配abc的行，修改bc为aa

