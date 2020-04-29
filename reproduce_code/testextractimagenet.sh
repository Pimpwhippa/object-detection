#!/bin/bash

#mkdir ../heavystuffishere/testloadimagenet
cd ../heavystuffishere/testextractimagenet

# go login
# http://www.image-net.org/login
#username lertlove
#password obodroid

OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

for wnid in ${OBJECT_LIST[@]};
do 
   #mkdir "${wnid[@]}"
   cd "${wnid[@]}"

   #download images (have to be logged in/or maybe no need?)

   #wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   tar xvf "synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   cd ..
done




#cat file.txt | while read line; do
#  echo $line
#done

