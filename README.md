shell study daily

# 各命令的作用

############################
# awk
# awk [options] 'selection _criteria {action }' input-file [> output-file]
# 官方解释：Awk is a scripting language used for manipulating data and generating reports. The awk command programming language requires no compiling and allows the user to use variables, numeric functions, string functions, and logical operators. 
# 参考：https://www.geeksforgeeks.org/awk-command-unixlinux-examples/
# 支持正则表达式，用于匹配行
# 操作：
    1）一行一行扫描文件
    2）每一行输入分隔成域（字段）
    3）匹配输入的行或域
    4）对匹配的行执行操作
# 用处：
    1）转换数据文件
    2）产生格式化的报告
# 编程结构：
    1）格式化输出行
    2）算术和字符串运算
    3）条件与循环
# 个人总结：处理文件，统计数据，格式化产生报告
# 样例1：awk '/abc/ {print $NF}' filename    # 匹配abc的行，打印出最后一个字段
# 样例2：awk '/^#/ {print}' filename         # 匹配#开头的行，打印出该行
# 样例3：awk '{print $1, $NF}' filename > savefilename     # 每行的第一个字段和最后一个字段，输入到文件中
# 样例4：awk '{ if (length($0) > max) max = length($0)} END {print max}' employee.txt       # 统计最长的行，打印出长度
# 样例5：awk 'BEGIN {for(i=1;i<=5;i++) print "square of", i, "is", i*i}'    # 打印出1~5的平方，不是从文件中读的内容，需要有BEGIN标识
# 样例6：awk 'BEGIN {FS = ":"} {print $1,$NF}' /etc/passwd                  # 分隔符改为":"，打印第一个字段和最后一个字段

############################
# sed
# 
# 官方解释：SED command in UNIX is stands for stream editor and it can perform lot’s of function on file like, searching, find and replace, insertion or deletion. 
# 参考：https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/
# sed 是一个强大的文件流编辑器，可以插入、删除、查找替换文本，sed支持正则表达式（匹配行），允许执行复杂的模式匹配
# sed 命令作用于行

# 个人总结：处理文件或管道中的文本，包括插入、删除、查找替换操作；
# 样例1：sed '1,3 /s/no/yes/g' filename       # 第一行至第三行中的no替换为yes
# 样例2：seq 10 | sed '2,$ d'                 # 删除第二行至最后一行
# 样例3：seq 10 | sed '2~3 d'                 # 从第二行开始，每三行给删除
# 样例4：seq 10 | sed '5 d'                   # 删除第五行
# 样例5：seq 10 | sed '$ d'                   # 删除最后一行
# 样例6：sed '/^ipanel/ d' filename           # 删除以ipanel开头的行
# 样例7：sed '/file$/ d' filename              # 删除以file结尾的行
# 样例8：echo -e "lsy\ntxt file\ntracker\ndir\nfile" | sed '/file$/ d'    # 删除以file结尾的行

############################
# grep 
# 官方解释：`grep` prints lines that contain a match for a pattern.
# 参考：https://www.linuxnix.com/regular-expressions-linux-i/
# 参考：https://www.linuxnix.com/regular-expressions-linux-ii
# 参考：https://www.geeksforgeeks.org/grep-command-in-unixlinux/

# grep [OPTIONS] PATTERN [INPUT_FILE_NAMES]
# 个人总结：匹配文件中或管道中文本的行，使用正则表达式匹配行，并打印行
# 样例1：grep -i "UNix" filename        # 不区分大小写，查找UNix的行，默认输出到标准输出
# 样例2：grep -c "Unix" filename        # 统计匹配到的行数
# 样例3：grep -l "awk"  filename        # 显示匹配到的字符串所在的文件
# 样例4：grep -w "Linux" filename       # 查找Linux单词所在的行
# 样例5：grep -o "Unix" filename        # 仅仅显示匹配到的模式，默认显示匹配字符串所在的行
# 样例6：grep -n "Unix" filename        # 显示匹配字符串所在的行数和行
# 样例7：grep -v "Unix" filename        # 显示没匹配字符串的行
# 样例8：grep "^Unix" filename          # 匹配以Unix开头的行
# 样例9：grep "\.$" filename            # 匹配以.结尾的行
# 样例10：grep -e "Unix" -e "UNix" -e "UNIX" filename   # 指定多个匹配，同时匹配Unix、UNix和UNIX