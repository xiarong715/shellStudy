#!/bin/sh

# 判断输入的字符串是否以字母数字结尾

read -p "input content: " str

if echo "${str}" | grep -q '[A-Za-z0-9]$'; then
    echo -e "${str}\nok"
else
    echo "invalid"
fi