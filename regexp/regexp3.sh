#!/bin/sh

# grep 不用 -E, 或 sed 不用 -r ：  ^ $ . * [] [^char] <> \
# grep -E 或 sed -r : + | {m} {m,n} {m,} ()






# grep -v '^\.$\|^\.\.$\|^\.auto\.'  分析

# -v 选出没有匹配的行
# '^\.$' 匹配 . ，即当前目录
# '^\.\.$' 匹配 .. ，即上层目录
# '^\.auto\.' 匹配 .auto.
# grep '^\.$\|^\.\.$\|^\.auto\.'            # 匹配当前目录，上层目录，以.auto.开头的文件或目录
# grep -v '^\.$\|^\.\.$\|^\.auto\.'         # 即不匹配当前目录，上层目录，以.auto.开头的文件或目录
ls -a | grep -v '^\.$\|^\.\.$\|^\.auto\.'   # 选出不是当前目录，上层目录，以.auto.开头的文件或目录