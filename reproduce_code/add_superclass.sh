#!/bin/bash

cd ../../heavystuffishere/imagenetlabel

    #for range(84, 93)  # 84, 85, 86, 87, ..., 92;
for file in n01729322*.txt; #92
    do
    done
    
    #for range(94, 96)  # 94, 95;

this works
for file in n03701391*.txt; do awk '$1==94{$1=93;print}' $file >> "$file"; done

for file in n03701391*.txt; #94
    do 
        awk '{$1=94{$1==93}; print;}' $file >>"$file"
    done
