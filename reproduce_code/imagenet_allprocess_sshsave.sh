#!/bin/bash

# download ImageNet images of the custom class
cd ../heavystuffishere/
mkdir imagenet_allimages
cd imagenet_allimages
#wget http://image-net.org/image/ILSVRC2017/ILSVRC2017_DET.tar.gz

# 1. make a list of wnid of objects to be downloaded
OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

# 2. have to be logged in to be able to download
# go log in 
# http://image-net.org/download-images
    #username lertlove
    #password obodroid

for wnid in ${OBJECT_LIST[@]};
do 
   wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   tar xvf "synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   cd ..
done


# download ImageNet bounding box, have to change wnid also
cd ../
mkdir imagenetbbox
cd imagenetbbox

for wnid in ${OBJECT_LIST[@]};
do
    wget "http://www.image-net.org/downloads/bbox/bbox/${wnid}.tar.gz"
    tar "xvf ${wnid}.tar.gz"
done

# 2.2 ImageNet(pascal VOC) to yolo
cd ../
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
wget 'https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py'

# get file wnid_synset.map and put in folder imagenetlabel
cd ../
mkdir imagenetlabel
cd imagenetlabel
wget http://image-net.org/archive/words.txt

# 3. go to change file paths in generate_labels.py
# change mapfile, xml folder, output folder

python3 ../..heavystuffishere/convert_VOC_to_yolo/generate_labels.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0
    

# now folder imagenetlabel should be populated with synset label files
# (for example, from n01695060 wnid, now monitor lizard is 8671 after map with synset)
# then have to renumber the class indexes into those from cocoimagenet.names 

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

#8854 n01729322 sandviper snake 92
#16933 n03127747 crash helmet 82
#20346 n03701391 machine gun 94

# add superclass snake and gun with extra label
# all kinds of snakes 84, 85, 86, 87, ..., 92; add super class snake 83
#92 sandviper snake, add 83
for file in n01729322*.txt; do awk '$1==92{$1=83;print}' $file >> "$file"; done

#94 machine gun, 95 pistol, add superclass 93 gun
for file in n03701391*.txt; do awk '$1==94{$1=93;print}' $file >> "$file"; done

# some of imagenet synset doesn't come with label files
# just pick image files that have matched label files
# copy label files into image files folder (append, not replace)
# only the content, not the folder
cp -r ./* ../imagenet_allimages/

#now imagenet_allimages has both JPEG and txt files

#but there are only 2162 labels for 5349 images
#either yolo_mark new 3187 labels or remove the 3187 images

# cannot create empty label files, because they are positive images
# i chose to remove the 3187 images because 2162/4, around 500 images for each class
# is sufficient

# match label files with image files
cd ../imagenet_allimages
find . -exec bash -c 'basename "$0" ".${0##*.}"' {} \; | sort | uniq --repeated > imagenetpairs.txt

# matched files down to 1846 pairs instead of 2162
# almost worth label new 3187 images for better training

# now there are names of matched double files
# have to double the lines then add .txt and .JPEG
awk '{print;print;}' imagenetpairs.txt > imagenetpairsdouble.txt
sed -e 's/$/.JPEG/' -i imagenetpairsdouble.txt
sed '0~2 s/$/.txt/g' < imagenetpairsdouble.txt > imagenet_allimagesandlabel.txt
sed -i 's/.JPEG.txt/.txt/g' imagenet_allimagesandlabel.txt

# delete files that are NOT in this list imagenetpairs.txt
shopt -s extglob
# dry run
#ls -p | grep -v / | sed 's/\<imagenet_allimagesandlabel.txt\>//g' | sort | comm -3 - <(sort imagenet_allimagesandlabel.txt) | xargs echo | tr " " "\n"
# rm
ls -p | grep -v / | sed 's/\<imagenet_allimagesandlabel.txt\>//g' | sort | comm -3 - <(sort imagenet_allimagesandlabel.txt) | xargs rm


# ImageNet traintestsplit
cd ../
mkdir imagenetval

# GroupKfold.split
# randomly select 10% out (.JPEG)
cd imagenet_allimages

find . -type f -name '*.JPEG'| shuf -n 185 > imagenetval.txt
sed -i 's;^./;;' imagenetval.txt
mv $(< imagenetval.txt) ../imagenetval

# take the matched files label(.txt)
sed 's/JPEG/txt/g' imagenetval.txt > imagenetvallabel.txt
mv $(< imagenetvallabel.txt) ../imagenetval

# copy the rest 90% images and 90% labels from imagenet_allimages 
# into imagenettrain
cd ../
mkdir imagenettrain
cd imagenettrain
cp -r ../imagenet_allimages/* .

# make train images list to feed to darknet
find . -type f -name "*.JPEG" > imagenettrain.txt
sed -i 's;^./;;' imagenettrain.txt

# now we got the required 2 folders; imagenettrain and imagenetval
# each folder comprises of JPEG and its corresponding txt label file
# and a list of imagenettrain.txt and imagenetval.txt
# to give to darknet

mv imagenet_allimagesandlabel.txt ../
mv imagenetval.txt ../
mv imagenetvallabel.txt ../
mv imagenettrain.txt ../











