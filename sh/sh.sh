#!/bin/sh

# 参考：https://www.cnblogs.com/xunbu7/p/6187017.html

# ``和$()作用相同，都是执行一个命令
echo `which gita`   # print gita pull path
echo $(which gita)  # print gita pull path

eval $(cat /etc/os-release | grep '^ID=')   # 定义ID的值
echo $ID
eval `cat /etc/os-release | grep '^ID='`    # 定义ID的值，效果同上
echo $ID

# $(())
# 它是用来作整数运算的，bash中的运算大致有：+ - * / % & | ^ !
# 在 $(( )) 中的变量名称，可于其前面加 $ 符号来替换，也可以不用
a=3;b=4;c=5
echo $((a+b*c))

# (())，作运算，重定义变量值
a=5
((a++))
echo $a

# ${}，取变量的值，变量值字符串的查找替换，对变量是否声明初始化是否为空的判断，根据不同情况获得不同结果
# 在 ../string/string.sh中有例子
var="hello world"
echo $var
echo -e "${var}\nok"    # -e 使能反斜杠转义

# $* 和 $@ 的区别
# 都表示传递给函数或脚本所有参数
# 当 $* 和 $@ 没有被""双引号引起时，两者的结果都是："$1" "$2" "$3" ... "$n"
# 当 "$*" 和 "$@"时
# "$*"的结果为 "$1 $2 $3 ... $n"，即将所有的参数当作一个整体
# "$@"的结果为 "$1" "$2" "$3" ... "$n"
# 结论：如果在函数中，需要遍历参数，那么选择$@的形式
add() {
    local sum=0
    for item in "$@"; do
        ((sum+=item))
    done
    echo $sum
}

add 1 2 3 4 5

print() {
    echo "\$*:" $*
    echo "\$@:" $@
    echo "\"\$*\":" "$*"
    echo "\"\$@\":" "$@"
    echo "--------------------"
    echo "\$*:"
    for item in $*; do
        echo $item
    done
    echo "--------------------"
    echo "\$@:"
    for item in $@; do
        echo $item
    done
    echo "--------------------"
    echo "\"\$*\""
    for item in "$*"; do
        echo $item
    done
    echo "--------------------"
    echo "\"\$@\""
    for item in "$@"; do
        echo $item
    done
}

print a b c d

# $0 当前脚本的文件名或函数名
# $n 传递给脚本或函数的第几个参数，如：$1、$2；注意$0不是参数
# $# 传递参数的个数
# $* 传递的所有参数
# $@ 传递的所有参数，$*和$@的区别在上面有讲
# $? 上个命令的退出状态或函数的返回值
# $$ 当前shell进程ID，对于shell脚本，就是这些进程所在的进程ID

# #####################################################
# 参考：https://people.duke.edu/~ccc14/duke-hts-2018/cliburn/The_Unix_Shell_05___Shell_Scripts.html
# shell script
# The shell commands constitute a programming language, and command line programs known as shell scripts can be written to perform complex tasks.

# assigning variables
# 变量赋值
NAME="Joe"
echo "hello $NAME"      # hello Joe
echo "hello ${NAME}"    # hello Joe

# single and double parentheses
# 单引号与双引号
# The main difference between the use of '' and "" is that variable expansion only occurs with double parentheses.
echo '${NAME}'          # ${NAME}, single parentheses, 不会发生变量扩展
echo "${NAME}"          # Joe

# use of curly braces
# 大括号的使用
# Use of curly braces unambiguously specifies the variable of interest. 
# I suggest you always use them as a defensive programming technique.
echo "hello ${NAME}1"
# $NAME1 is not defined, and so returns an empty string!
echo "hello $NAME1"

# One of the quirks of shell scripts is already present - there cannot be spaces before or after the = in an assignment.
# 变量赋值时，等于号=两边没有空格
# NAME2= "Joe" # error, The previous instruction assigns the empty space to NAME2, then tries to execute ‘Joe’ as a command.
# NAME3 ="Joe" # error, The previous instruction runs the command NAME3 with =’Joe’ as its argument.

# Assigning commands to variables

CUR_DIR=$(pwd)      # $()，括号中为命令，$()取命令的值，赋给变量
dirname ${CUR_DIR}
basename ${CUR_DIR}
echo $(dirname ${CUR_DIR})"/"$(basename ${CUR_DIR})

# `` 与 $() 作用相同
CUR_DIR=`pwd`
dirname ${CUR_DIR}
basename ${CUR_DIR}
echo `dirname ${CUR_DIR}`"/"`basename ${CUR_DIR}`

# working with numbers
# Careful: Note the use of double parentheses to trigger evaluation of a mathematical expression.
# 双小括号内的变量可加$也可不加$
NUM=0
((NUM++))
echo ${NUM}

NUM=$((1+2+3+4+5))
echo ${NUM}

# generates a range of numbers
seq 3       # 1 ~ 3的序列
seq 2 5     # 2 ~ 5的序列
seq 1 2 9   # 1 ~ 9，步长为2的序列

# branching
# using if to check for file existence
    # Note the test condition must use square brackets.
if [ -f hello.txt ]; then
    cat hello.txt
else
    echo "No such file"
fi

# downloading remote files
# man wget | head -n 20
if [ -f "data/forbes.cvs" ]; then
    wget https://vincentarelbundock.github.io/Rdatasets/csv/HSAUR/Forbes2000.csv \
        -O data/forbes.cvs
fi

# some useful wget flags
# -O redirects to named path
# -O- redirects to standard output (so it can be piped)
# -q suppresses messages 
wget -qO- https://vincentarelbundock.github.io/Rdatasets/doc/HSAUR/Forbes2000.html \
    | html2text | head -n 27  | tail -n 17

# The [ -f hello.txt ] syntax is equivalent to test -f hello.txt, where test is a shell command with a large range of operators and flags that you can view in the man page.
if test -f hello.txt; then
    cat hello.txt
else
    echo "No such file"
fi

# looping
# for loop
for file in $(ls *.sh); do
    echo $file
done

# traditional c-style for loop
# We make use of the double parentheses to evaluate the counter arithmatic.
for ((i=1; i<=5; i++)); do
    echo $i
done

# Double square brackets provide enhanced test functionality
# You can use && instead of -a
# You can use || instead of -o
# You can use =~ to match regular expression patterns

# Example of regular expression matching in test condition
for file in $(ls); do 
    if [[ $file =~ ^hello.*txt ]]; then     # 正则匹配，打印匹配成功的文件名
        echo $file
    fi
done

# while loop
COUNTER=10
while [ $COUNTER -gt 0 ]; do
    echo $COUNTER
    COUNTER=$(($COUNTER-1))
done

# Careful: Note that < is the redirection operator, and hence will lead to an infinite loop. 
# Use -lt for less than and -gt for greater than, == for equality and != for inequality.
COUNTER=10
while [ $COUNTER != 0 ]; do 
    echo $COUNTER
    COUNTER=$(($COUNTER-1)) 
done

# Brace expansion
for num in {001..005}; do
    echo touch EXPT-${num}
done

echo foo.{h,cpp,c,hpp}  # 之间不能有空格

cat sh.sh | head -n 8 | tail -n 3       # 显示文件的6~8行

wc -l sh.sh     # 统计文件行数
for file in $(ls); do
    echo $file
done


cat > count_lines.sh << 'EOF'       # 遇到EOF时结束输入
#!/bin/bash

for FILE in $(ls)
do
    wc -l "${FILE}"
done
EOF