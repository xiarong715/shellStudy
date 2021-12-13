#!/bin/sh

# [参考](https://www.geeksforgeeks.org/awk-command-unixlinux-examples/)

# syntax
# awk options 'selection _criteria {action}' input-file > output-file


# Default behavior of Awk: By default Awk prints every line of data from the specified file. 
awk '{print}' employee.txt      # print file line by line

# print the lines which match the given pattern
awk '/manager/ {print}' employee.txt    #  print the lines which matches with the 'manager'

# splitting a line to fields: 
# For each record i.e line, the awk command splits the record delimited by whitespace character by default and stores it in the $n variables. 
# If the line has 4 words, it will be stored in $1, $2, $3 and $4 respectively. 
# Also, $0 represents the whole line.  
awk '{print $1,$4}' employee.txt

# Built-In Variables In Awk
# Awk’s built-in variables include the field variables—$1, $2, $3, and so on ($0 is the entire line) — that break a line of text into individual words or pieces called fields. 
# $1,$2,$3 and so on ($0 is the entire line)
awk '{print $1,$4}' employee.txt
awk '{print $2}' employee.txt                                                # To return the second column/item from employee.txt
awk '{ if (length($0) > max) max = length($0)} END {print max}' employee.txt # To find the length of the longest line present in the file
awk 'length($0) > 10 {print}' employee.txt                                   # printing lines with more than 10 characters
awk '{if ($4 > 50000) print $0}' employee.txt                                # printing lines of more than 50000 salary
awk '{if ($3 == "sales" && $4 > 30000) print $0}' employee.txt               # printing lines 
awk 'BEGIN {for(i=1;i<=5;i++) print "square of", i, "is", i*i}'

# 注意BEGIN和END的用法
# 感觉在控制action： BEGIN指明开始接收输入，END指明结束输入

# NR: NR command keeps a current count of the number of input records. 保留输入行（记录）的当前行数
awk '{print NR,$0}' employee.txt    # 打印所有行，并在行首加行号
awk 'NR == 3, NR == 6 {print NR, $0}' employee.txt  # 打印第3-6行，并加上行号；多个匹配之间用逗号隔开
awk '{print NR "-" $1}' employee.txt    # To print the first item along with the row number(NR) separated with ” – “ from each line in employee.txt
awk 'END {print NR}' employee.txt   # To count the lines in employee.txt

# NF: NF command keeps a count of the number of fields within the current input record.  统计当前行（记录）域的数量
awk '{print $1, $NF}' employee.txt  # 打印最一个域和最后一个域
awk 'NF == 0 {print NR}' employee.txt   # 打印出空行的行号

# FS: FS command contains the field separator character which is used to divide fields on the input line. The default is “white space”, meaning space and tab characters. FS can be reassigned to another character (typically in BEGIN) to change the field separator.
awk -F : '{print $1, $NF}' /etc/passwd          # 使用 -F 选项设置分隔符
awk 'BEGIN {FS=":"} {print $1,$NF}' /etc/passwd # 使用 设置FS的值，设转走分隔符

# https://www.howtogeek.com/562941/how-to-use-the-awk-command-on-linux/