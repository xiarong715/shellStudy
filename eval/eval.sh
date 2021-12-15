#!/bin/sh

get_linux_version1() {
    local hostos="cat /etc/os-release | grep '^ID='"
    hosttemp=`eval $hostos`     # eval [argument ...]， 把参数数作命令执行，使用eval
    hostos=${hosttemp##*=}
    hostos=${hostos#*\"}
    hostos=${hostos%\"*}
    echo $hostos
}

get_linux_version2() {
    local hostos=`cat /etc/os-release | grep "^ID="`    # $hostos是cat命令执行后的结果
    if [ "$hostos" = "" ]; then             # 正常情况是 "$hostos" = "ID="centos""
        echo ">>> 获取当前操作系统失败"
        exit 1
    fi
    eval $hostos                            # eval $hostos 把 ID="centos" 当作一条命令执行
    echo "$ID"                              # $ID 的值为 centos
}

get_linux_version1
get_linux_version2

# 读取值的值：把一个变量名传给一个函数，在函数中给这个变量赋值，在函数外访问这个变量时，很有用
ret_url=url
url="http://192.168.10.1"
eval echo '$'"${ret_url}"   # http://192.168.10.1
eval echo \${${ret_url}}    # http://192.168.10.1
eval echo ${!ret_url}       # http://192.168.10.1

eval ret=\${${ret_url}}     # ret=http://192.168.10.1

getRepo() {
    local url=
    setUrl url  # 变量名传给setUrl函数
    echo $url
}

setUrl() {
    local ret_url=$1
    local x="http://192.168.1.10"
    [ "$ret_url" ] && {
        eval $ret_url=$x    # 给变量赋值
    }
}

getRepo

# curl -H 'Accept: text/gita' http://public:public@192.168.43.99/project/?mix


# ${}
# $()