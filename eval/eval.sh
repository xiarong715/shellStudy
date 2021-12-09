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