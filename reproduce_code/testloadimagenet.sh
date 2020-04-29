#!/bin/bash

mkdir ../heavystuffishere/testloadimagenet
cd ../heavystuffishere/testloadimagenet

# go login
# http://www.image-net.org/login
#username lertlove
#password obodroid

OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

for wnid in ${OBJECT_LIST[@]};
do 
   mkdir "${wnid[@]}"
   cd "${wnid[@]}"

   #download images (have to be logged in/or maybe no need?)
   wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   tar xvf synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford

   #or another way no need to login
   #first download list of urls and save into a text file

   #wget http://image-net.org/api/text/imagenet.synset.geturls?wnid=n01695060 -O n01695060.txt
   #wget http://image-net.org/api/text/imagenet.synset.geturls?wnid=${wnid} -O ${wnid}.txt
   
   
   #then wget each line or wget the whole file
   #while read line in ${wnid}.txt;do
   #for line in ${wnid}.txt; do
   #wget -i ${wnid}.txt
    #wget --tries=2 ${line}

    #but if a line hangs, skip the line and move onto next line
    #skip if hang s
    #timeout 10
   #done
   #rm ${wnid}.txt
   cd ..
done




#cat file.txt | while read line; do
#  echo $line
#done

