#!/bin/bash

mkdir ../heavystuffishere/bbox3
cd ../heavystuffishere/bbox3


OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

for wnid in ${OBJECT_LIST[@]};
do 
   #mkdir "${wnid[@]}"
   #cd "${wnid[@]}"
   wget http://www.image-net.org/downloads/bbox/bbox/${wnid}.tar.gz
   tar xvf ${wnid}.tar.gz
done