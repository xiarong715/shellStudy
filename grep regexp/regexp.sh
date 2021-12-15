### 任务安排



#   [参考1](https://www.linuxnix.com/regular-expressions-linux-i/)
#   [参考2](https://www.linuxnix.com/regular-expressions-linux-ii)

#   1)Basic Regular expressions
# 
# ^：匹配行首
# $：匹配行尾
# *：前一字符零次或多次出现
# .：匹配任意字符
# []：字符集（范围）
# [^char]：字符集取反
# <word>：匹配单词， \<word\>
# \: 转义，匹配特殊字符
# 

# "^"的例子

# `ls -l | grep '^-'`也可

ls -l | grep ^-					# find all the files in a given directory
ls -l | grep ^d					# find all the directory in a folder
ls -l | grep ^c					# find all the character files in a folder
ls -l | grep ^b					# find all the block files in a folder

grep '^#' filename				# find the lines which are commented in file
grep '^#' /etc/ssh/ssh_config	# find the lines which are commented in /etc/ssh/ssh_config
grep '^abc' filename			# fine the lines in a file which starts with 'abc'

# "$"的例子

ls -l | grep sh$		# match all the files which ends with sh
grep 'dead$' filename	# find the lines in a file which ends with dead
grep '^$' filename		# find the empty lines in a file
grep '^#.*\.$' filename	# find the lines in a file which starts with # and ends with .   ;   .* 匹配任意字符零次或多次

# "*"的例子

ls -l | grep 'twe*t'	# match all files which have a word twt, twet, tweet etc int the file name.
grep 'ap*le' filename 	# search for apple word which was spelled wrong in a given file where apple is misspelled as ale, aple, apple, appple,apppple etc. To find all patterns.

# "."的例子

ls -l | grep 't.t' 		# filter a file which contains any single character between t and t in a file name.Here . will match any single character. It can match tat, t3t, t.t, t&t etc any single character between t and t letters.
ls -l | grep 'a.*x'		# find all the file names which starts with a and end with x. ".*" indicates any number of characters. ".*" in this combination, indicates any character and it repeated(*) 0 or more number of times.
   					# it will find all the files/folders which start with a and ends with x in our example. eg: fawx awex daweex awasfx awfjox etc.
grep '^a.*x$' filename	# match all lines which starts with a and ends with x

# "[]"的例子

ls -l | grep 'a[0-9]x'	# find all the files which contains a number in the file name between a and x. This will find all the files which is a0xsdf asea1xfwo fasda2xsfd etc.
   
# [a-z]: match's any single char betwwen a to z.
# [A-Z]: match's any single char betwwen A to Z.
# [0-9]: match's any single char betwwen 0 to 9.
# [a-zA-Z0-9]: match 's any single character either a to z or A to Z or 0 to 9.
# [!@#$%^]: match's any ! or @ or # or $ or % or ^ character. You just have to think what you want match and keep those character in the braces/Brackets.

# `"[^CHAR]"`的例子

ls | grep '[^abc]'	# match all the file names except a or b or c in it's filenames，匹配不是a b c的字符
ls | grep '[^A-Z]'	# match all the file names expcet A - Z in it's filenames, 匹配不在A-Z中的字符，即匹配名字为小写的文件或目录

# "<WORD>"的例子，\< 和 \> 确定单词边界

grep '<abc>' filename	# 不太对
grep '\<abc\>' filename	# 可正常匹配

# "\"的例子

ls | grep '\['	# find files which contain [ in it's name, as [ is a special character we have to escpe it.
grep '\[' filename # find all lines which contain [ in line.
# or 
grep '[[]' filename # find all lines which contain [ in line.

# 2)Interval Regular expressions **(Use option -E for grep and -r for sed)\**

# {n}: n occurrence of the previous character
# {n, m}: n to m times occurrence of the previous character
# {m, }: m or more occurence of the previous character

ls | grep -E 't{3}'		# find all the file names which contain "t" and t repeats for 3 times consecutively
ls | grep -E 'l{1,3}'	# find all the file names which contains l letter in filename with 1 occurrence to 3 occurrence consecutively
ls | grep -E 'k{5,}'	# find all the file names which contains k letter 5 and more in a file name
   
# This is bit tricky, let me explain this. Actually we given a range i.e 5 to infinity (just given only comma after 5).

# 3)Extended Regular expressions** (Use option -E for grep and -r for sed)\**

# +: one more occurrence of the previous character
# |: or option, we can specify either a character to present in the pattern
# ?: 0 or one occurrence of the previous character
# (): grouping of character set

ls | grep -E 'f+'	# find all the files which contains f letter, one more occurrences
ls | grep -E 'a|b'	# find all the files which may contain a or b in it's file name
ls | grep -E 't?'	# find all the files which may contain t or 1 occurrence of t in filename	
ls | grep -E '(ab)'	# find all the files which contains ab in the sequence

# 扩展的正则表达式，如果不加 -E 选项，特殊字符需要转义（\）
grep 'a\+'			regexpfile.txt
grep 'ipanel\|file' regexpfile.txt
grep 'f\?'			regexpfile.txt
grep '\(abc\)'		regexpfile.txt

# 上面只是展示正则表达式的用法
# grep 的用法
# 参考：https://www.geeksforgeeks.org/grep-command-in-unixlinux/