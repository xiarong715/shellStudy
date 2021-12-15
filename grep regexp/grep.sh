# 主要展示grep的用法
grep -i "UNix" filename        # 不区分大小写，查找UNix的行，默认输出到标准输出
grep -c "Unix" filename        # 统计匹配到的行数
grep -l "awk"  filename        # 显示匹配到的字符串所在的文件
grep -w "Linux" filename       # 查找Linux单词所在的行
grep -o "Unix" filename        # 仅仅显示匹配到的模式，默认显示匹配字符串所在的行
grep -n "Unix" filename        # 显示匹配字符串所在的行数和行
grep -v "Unix" filename        # 显示没匹配字符串的行
grep "^Unix" filename          # 匹配以Unix开头的行
grep "\.$" filename            # 匹配以.结尾的行
grep -e "Unix" -e "UNix" -e "UNIX" filename   # 指定多个匹配，同时匹配Unix、UNix和UNIX

