#!/bin/sh

# [参考](https://www.geeksforgeeks.org/awk-command-unixlinux-examples/)

# syntax
# awk options 'selection _criteria {action}' input-file > output-file

# Default behavior of Awk: By default Awk prints every line of data from the specified file. 
awk '{print}' employee.txt      # print file line by line

# print the lines which match the given pattern
awk '/manager/ {print}' employee.txt    #  print the lines which matches with the 'manager'

# splitting a line to fields
awk '{print $1,$4}' employee.txt