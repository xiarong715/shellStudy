#!/bin/sh

read -p "input content: " str

# 判断输入的字符串是否以字母或数字开头
if echo ${str} | grep -q '^[A-Za-z0-9]'; then
    echo -e "${str}\nok"
else
    echo "invalid"
fi