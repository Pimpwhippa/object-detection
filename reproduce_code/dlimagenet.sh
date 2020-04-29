#!/bin/bash

mkdir ../../heavystuffishere/imagenet_allimages
cd ../../heavystuffishere/imagenet_allimages

OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')

for wnid in ${OBJECT_LIST[@]};
do 
   wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   tar xvf "synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
done