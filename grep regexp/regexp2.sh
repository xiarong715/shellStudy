#!/bin/sh

# [参考3](https://people.duke.edu/~ccc14/duke-hts-2018/cliburn/The_Unix_Shell_04___Regular_Expresssions.html)

# A regular expression (regex) is a text pattern that can be used for searching and replacing. Regular expressions are similar to Unix wild cards used in globbing, but much more powerful, and can be used to search, replace and validate text.
# Regular expressions are used in many Unix commands such as find and grep, and also within most programming languages such as R and Python.

# We will practice using grep. If a successful match is found, the line of text will be returned; otherwise nothing.

# Literal character match
echo abcd | grep abcd       # abcd
echo abcd | grep bc         # abcd

# no match for ac
echo abcd | grep ac         #

# Case insensitive match
# -i, --ignore-case         ignore case distinctions
echo abcd | grep -i A       # abcd
echo abcd | grep A          #

# .
# Matching any single character
# The . matches exactly one character
echo abcd | grep a.c        # abcd
echo abcd | grep a..c       #
echo abcd | grep a..d       # abcd

# []
# Matching a character set
echo a2b | grep [0123456789]    # a2b， 能匹配到[0123456789]字符集中的一个就成功匹配
echo a2b | grep [0-9]           # a2b，上面的简写
echo a2b | grep [abc]           # a2b
echo a2b | grep [def]           # 
echo a2b | grep [a-z]           # a2b
echo a2b | grep [A-Z]           # 
echo a2b | grep -i [A-Z]        # a2b

# ^
# Exceptions
# The ^ within a character set says match anything NOT in the set.
echo a2b | grep [A-Z]           # 
echo a2b | grep [^A-Z]          # a2b
echo a2b | grep [^0-9]          # a2b
echo a2b | grep [^a-z]          # a2b

# Pre-defined character sets
# [character classes](https://www.gnu.org/software/grep/manual/html_node/Character-Classes-and-Bracket-Expressions.html)
# Many useful sets of characters (e.g. all digits) have been pre-defined as character classes that you can use in your regular expressions. Character classes are a bit clumsy in the Unix shell, but simpler forms are often used in programming languages (e.g. ‘:raw-latex:`\d`’ instead of ‘[:digit:]’).
echo a2b | grep ['[:alpha:]']   # a2b
echo a2b | grep ['[:digit:]']   # a2b
echo a2b | grep ['[:punct:]']   # 
echo a2,b| grep ['[:punct:]']   # a2,b

# -E
# Alternative expressions
# We use the -E argument here to avoid having to escape special characters
# -E, --extended-regexp     Interpret pattern as an extended regular expression (i.e. force grep to behave as egrep).'
echo cat | grep -E '(cat|dog)'  # cat  

# Without -E
# We need to escape the special characters (, | and )
echo cat | grep '\(cat\|dog\)'  # cat
# We love dogs as well
echo dog | grep -E '(cat|dog)'  # dog
# But not foxes
echo fox | grep -E '(cat|dog)'  # 

# Be-careful - use of square brackets means something different
# 匹配到cat dog中的字母就匹配成功
echo fox | grep '[cat|dog]'     # fox

# Achors
# ^ indicates start of line and $ indicates end of line
echo abcd | grep '^ab'          # abcd
echo abcd | grep 'ab$'          # 
echo adcd | grep '^cd'          # 
echo abcd | grep 'cd$'          # abcd

# Repeating characters
# + matches one or more of the preceding character set
# * matches zero or more of the preceding character set
# {m}
# {m,n} matches between m and n repeats of the preceding character set
# {m,}
echo abbbcd | grep abcd         # 
echo abbbcd | grep 'ab*cd'      # abbbcd
echo abbbcd | grep 'ab+cd'      # 
echo abbbcd | grep 'ab\+cd'     # abbbcd
echo abbbcd | grep -E 'ab+cd'   # abbbcd

echo abbbcd | grep 'ab\{1,5\}cd'    # abbbcd
echo abbbcd | grep -E 'ab{1,5}cd'   # abbbcd
echo abbbcd | grep 'a[bc]\+d'       # abbbcd
echo abbbcd | grep -E 'a[bc]+d'     # abbbcd

# note: + | ? () {m,n} 使用 -E 选项或转义

# Matching words with word boundaries
# \< and \> indicates word boundaries. That is, \<foo\> will only match foo bar or bar foo but not foobar or barfoo.
echo 'other ones go together' | grep 'the'          # other ones go together
echo 'other ones go together' | grep '\<the\>'      # 
echo 'other ones go together' | grep '\<other\>'    # other ones go together

# Capture groups and back reference
echo '123_456_123_456' | grep -E '([0-9]+).*\1'             # 123_456_123_456
echo '123_456_123_456' | grep -E '([0-9]+)_([0-9]+)_\1_\2'  # 123_456_123_456
echo '123_456_123_456' | grep -E '([0-9]+)_([0-9]+)_\1_\2'  # 
echo '123_456_123_123' | grep -E '([0-9]+)_([0-9]+)_\1_\1'  # 123_456_123_456
echo '2021/12/9 14:32:00' | grep -E '([0-9]+)/([0-9]+)/([0-9]+) ([0-9]+):([0-9]+):([0-9]+)'     # 2021/12/9 14:32:00
echo '2021/12/9 14:32:00' | grep -E '([0-9]{4})/([0-1]?[0-9])/([0-3]?[0-9]) ([0-2][0-4]):([0-5][0-9]):([0-5][0-9])'     # 2021/12/9 14:32:00

echo 'cat' | grep -E '([a-z])'

