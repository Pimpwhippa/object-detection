i can do as Vignesh SP told me! 15 times and then im done!

for file in ``find . -name "*.txt"``; do awk '{print "\n9997 "$2,$3,$4,$5}' $file >> $file; done


!/usr/bin/env bash
tmp=$(mktemp)
declare -A synsetyolodict=([8671]=80 [16933]=81 [23297]=82 [8902]=84 [8858]=85 [8922]=86 [8887]=87 [8891]=88 [8852]=89 [8917]=90 [8850]=91 [8854]=92 [20346]=94 [22597$

while IFS= read -r file; do 
   
    #awk '{print} $1==k{$1=v; print}' "$file" > "$tmp" &&
    #awk '{print} $1==key{$1="${synsetyolodict[@]}"; print}' "$file" > "$tmp" &&
  for i in synsetyolodict; do
	  awk '$1=="${!synsetyolodict[i]}"{${synsetyolodict[@]}; print}'"$file" > "$tmp" &&

#another dict for snake and gun only for superclassing
    superclass=([83]=80 [83]=81 [83]=82 [83]=84 [83]=85 [83]=86 [83]=87 [83]=88 [83]=89 [83]=90 [83]=91 [83]=92 [93]=94 [93]=95)
    
	awk '{print} $1=="${superclass[@]"{$1=$keysuper; print}' "$file" > "$tmp" &&
   
mv "$tmp" "$file"
   
done < <(find . -maxdepth 2 -mindepth 2)
rm -f "$tmp"


declare -A synsetyolodict
#declare -A animals=( ["moo"]="cow" ["woof"]="dog")
    
synsetyolodict = (["8671"]="80" ["16933"]="81" ["23297"]="82" ["8902"]="84" ["8858"]="85" ["8922"]="86" ["8887"]="87" ["8891"]="88" ["8852"]="89" ["8917"]="90" ["8850"]="91" ["8854"]="92" ["20346"]="94" ["22597"]="96")
#Use animals['key']='value' to set value, "${animals[@]}" to expand the values, and "${!animals[@]}" (notice the !) to expand the keys.
    
#for k,v in synsetyolodict;
for key in "${!synsetyolodict[@]}"; do echo "$key - ${animals[$key]}"; done


declare -A MYMAP=( [foo]=bar [baz]=quux [corge]=grault )


declare -A persons
# now, populate the values in [id]=name format
persons=([1]="Bob Marley" [2]="Taylor Swift" [3]="Kimbra Gotye")
# To search for a particular name using an id pass thru the keys(here ids) of the array using the for-loop below

# To search for name using IDS

read -p "Enter ID to search for : " id
re='^[0-9]+$'
if ! [[ $id =~ $re ]] 
then
 echo "ID should be a number"
 exit 1
fi
for i in ${!persons[@]} # Note the ! in the beginning gives you the keys
do
if [ "$i" -eq "$id" ]
then
  echo "Name : ${persons[$i]}"
fi
done
# To search for IDS using names
read -p "Enter  name to search for : " name
for i in "${persons[@]}" # No ! here so we are iterating thru values
do
if [[ $i =~ $name ]] # Doing a regex match
then
  echo "Key : ${!persons[$i]}" # Here use the ! again to get the key corresponding to $i
fi
done



#!/usr/bin/env python
import sys, yourmodule
saw_errors = 0
for k, v in yourmodule.data.iteritems():
    if '\0' in k or '\0' in v:
        saw_errors = 1 # setting exit status is nice-to-have but not essential
        continue       # ...but skipping invalid content is important; otherwise,
                       #    we'd corrupt the output stream.
    sys.stdout.write('%s\0%s\0' % (k, v))
sys.exit(saw_errors)

# this is bash 4.x's equivalent to a Python dict
declare -A items=()
while IFS= read -r -d '' key && IFS= read -r -d '' value; do
    items[$key]=$value
done < <(python_script) # where 'python_script' behaves as given above

...whereafter you can access the items from your Python script:

echo "Value for hello is: ${items[hello]}"

...or iterate over the keys:

printf 'Received key: %q\n' "${!items[@]}"

...or iterate over the values:

printf 'Received value: %q\n' "${items[@]}"


awk '{print "sed -i s/^"$1"/"$2"/ data"}' lookup | bash
the following works
awk '{print "sed -i s/^"$1"/"$2"/ n01695060_6821.txt"}' subsnakes | bash

#!/bin/sh
for file in "$@" ; do
    awk '...' "$file"
done

awk '
BEGIN{ FS=OFS="," }
NR==FNR { map[$1] = $2; next }
{ $3 = map[$3]; print }
' subsnakes n01695060_6508.txt


$ awk -F 'NR==1{$1=81;OFS="";}1' input.txt

'NR==2 {{sub(" x ", " y ")}1'

sed '2s/ x / y /'


I have 15 folders that represent 15 objects with an id. Each file in the folder contains one line, for example, object with id 8852

> 8852 0.53451 0.55959 0.65494 0.36047

and another file in another folder of object id 8671 would contain
> 8671 0.65748 0.84756 0.36251 0.46525

I would like to replace in all the files of object id 8852 with number 80 and all of the object id 8671 with number 81, and so on, and save it directly in the file. I made a hash table like so

declare -A dict=([8852]=80 [8671]=81 [8988]=82 [8158]=83)



