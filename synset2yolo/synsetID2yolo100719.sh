
gives no error, and also outputs nothing


#!/usr/bin/env bash
tmp=$(mktemp)
declare -A synsetyolodict=([8671]=80 [16933]=81 [23297]=82 [8902]=84 [8858]=85 [8922]=86 [8887]=87 [8891]=88 [8852]=89 [8917]=90 [8850]=91 [8854]=92 [20346]=94 [22597]

while IFS= read -r file; do 
   
for i in ${!synsetyolodict[i]}; do
    #awk '{print} $1==${!synsetyolodict[i]}{$1="${synsetyolodict[@]}"; print}' "$file" > "$tmp";done &&

	awk '$1==i{${synsetyolodict[i]}; print}'"$file" > "$tmp"; done 

#for j in ${
    #another dict for snake and gun only for superclassing
 #   superclass=([83]=80 [83]=81 [83]=82 [83]=84 [83]=85 [83]=86 [83]=87 [83]=88 [83]=89 [83]=90 [83]=91 [83]=92 [93]=94 [93]=95)
  #  awk '{print} $1=="${superclass[@]"{$1=${!superclass[@]}; print}' "$file" > "$tmp" &&
   # mv "$tmp" "$file"
   
done < <(find . -maxdepth 2 -mindepth 2)
rm -f "$tmp"


