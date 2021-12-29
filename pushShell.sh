#!/bin/sh

local_path=`pwd`

function ENTER_PRO_DIR () {
    cd $1       // $1 是ENTER_PRO_DIR函数接受到的第一个参数
}


function GET_STUDY_PRO () {
    local wspath=$1
    g_pro_list=($(ls -la ${wspath} | grep "Study$" | awk '{print $NF}' | tr '\n' ' '))
    # echo ${pro_list[@]}
}

function PUSH_PRO () {
    local path=`pwd`
    for one in ${g_pro_list[@]}; do
        echo "---------------------------"
        echo "PUSH_ONE $one"
        cd $path
        PUSH_ONE $one
    done
}

function PUSH_ONE () {
    echo "cd $1"
    cd $1
    echo -e "yes\r" | gita push
}

GET_STUDY_PRO $1
PUSH_PRO

cd $local_path