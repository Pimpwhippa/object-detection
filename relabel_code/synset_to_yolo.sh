#!/bin/bash

#for file in *.txt;
#do
 #   sed -i 's/^8671/80/' $file >>"$file"
 #   sed -i 's/^8854/93/' $file >>"$file"
 #   sed -i 's/^16933/82/' $file >>"$file"
 #   sed -i 's/^20346/95/' $file >>"$file"
#done
cd ../../heavystuffishere/imagenetlabel

for file in n01729322*.txt;
do
    sed -i 's/^8854/92/' $file >> "$file"
done

for file in n01695060*.txt;
do 
    sed -i 's/^8671/80/' $file >> "$file"
done

for file in n03127747*.txt;
do
    sed -i 's/^16933/82/' $file >> "$file"
done

for file in n03701391*.txt;
do
    sed -i 's/^20346/94/' $file >> "$file"
done

