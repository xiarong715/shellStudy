#!/bin/bash

for FILE in $(ls)
do
    wc -l "${FILE}"
done
