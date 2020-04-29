#!/bin/bash

# download ImageNet images of the custom class
cd ../heavystuffishere/
#mkdir bigtest
cd bigtest
#wget http://image-net.org/image/ILSVRC2017/ILSVRC2017_DET.tar.gz

# 1. make a list of wnid of objects to be downloaded
OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

# 2. have to be logged in to be able to download
# go log in 
# http://image-net.org/download-images
    #username lertlove
    #password obodroid

#for wnid in ${OBJECT_LIST[@]};
#do 
   #mkdir "${wnid[@]}"
   #cd "${wnid[@]}"
   #wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   #tar xvf "synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   #cd ..
#done


# download ImageNet bounding box, have to change wnid also

#cd ../
#mkdir imagenetbbox
#cd imagenetbbox

#for wnid in ${OBJECT_LIST[@]};
#do
    #wget http://www.image-net.org/downloads/bbox/bbox/${wnid}.tar.gz
    #tar xvf ${wnid}.tar.gz
#done

# 2.2 ImageNet(pascal VOC) to yolo
cd ../
mkdir convert
cd convert
wget 'https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py'

# get file wnid_synset.map and put in folder imagenetlabel
cd ../
mkdir biglabel
cd biglabel
wget http://image-net.org/archive/words.txt

# 3. go to change file paths in generate_label.py
# change mapfile, xml folder, output folder

#python3 ../../../mnt/nas/objectscp/convert_VOC_to_yolo/generate_labels.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/bbox3 ../../heavystuffishere/imagenetlabel/ 0

#below is correccccccccccccccccccccccccct paths if run from inside container
python3 ../../heavystuffishere/convert/generate_labels.py ../../heavystuffishere/biglabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/biglabel/ 0 

# now folder imagenetlabel should be populated with synset label files
# (for example, from n0169xxxx wnid, now monitor lizard is 8671 after map with synset)
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
#84	snake	18	83	83
#85	water snake 	19	84	84
#86	green snake	20	85	85
#87	night snake 	21	86	86
#88	king snake	22	87	87
#89	garter snake	23	88	88
#90	ring neck snake	24	89	89
#91	vine snake	25	90	90
#92	thunder snake	26	91	91
#93	sandviper snake	27	92	92
#94	gun 	28	93	93
#95	machine gun 	29	94	94
#96	pistol 	30	95	95

# add superclass snake and gun with extra label
#for file in ../../heavystuffishere/imagenetlabel;
#do
    # all kinds of snakes 84, 85, 86, 87, ..., 92; add super class snake 83
    #92 sandviper snake, add 83
for file in n01729322*.txt; do awk '$1==92{$1=83;print}' $file >> "$file"; done

    #94 machine gun, 95 pistol, add superclass 93 gun
for file in n03701391*.txt; do awk '$1==94{$1=93;print}' $file >> "$file"; done

# some of imagenet synset doesn't come with label files
# just pick files that have label files
# copy label files into image files folder (append, not replace)
cp -r ./* ../bigtest/

#now imagenet_allimages has both JPEG and txt files

#but there are only 2162 labels for 5349 images
#either create label for the other 3187 images or remove the 3187 images

# cannot create empty label files, because they are positive images
# i chose to remove the 3187 images because 2162/4, around 500 images for each class
# is sufficient

cd ../bigtest
# match label files with image files
find . -exec bash -c 'basename "$0" ".${0##*.}"' {} \; | sort | uniq --repeated > imagenetpairs.txt

# matched files down to 1846 pairs instead of 2162
# almost worth label new 3187 images for better training

# now there are names of matched double files
# have to double the lines then add .txt and .JPEG
awk '{print;print;}' imagenetpairs.txt > imagenetpairsdouble.txt
sed -e 's/$/.JPEG/' -i imagenetpairsdouble.txt
sed '0~2 s/$/.txt/g' < imagenetpairsdouble.txt > bigtestandlabel.txt
sed -i 's/.JPEG.txt/.txt/g' bigtestandlabel.txt

# delete files that are NOT in this list imagenetpairs.txt
shopt -s extglob
# dry run
#ls -p | grep -v / | sed 's/\<bigtestandlabel.txt\>//g' | sort | comm -3 - <(sort bigtestandlabel.txt) | xargs echo | tr " " "\n"
# rm
ls -p | grep -v / | sed 's/\<bigtestandlabel.txt\>//g' | sort | comm -3 - <(sort bigtestandlabel.txt) | xargs rm


# ImageNet traintestsplit
cd ../
mkdir imagenetwow

# GroupKfold.split
# randomly select 10% out (.JPEG)
cd bigtest

find . -type f -name '*.JPEG'| shuf -n 165 > imagenetwow.txt
sed -i 's;^./;;' imagenetwow.txt
mv $(< imagenetwow.txt) ../imagenetwow

# take the matched files label(.txt)
sed 's/JPEG/txt/g' imagenetwow.txt > imagenetwowlabel.txt
mv $(< imagenetwowlabel.txt) ../imagenetwow

# copy the rest 90% images and 90% labels from imagenet_allimages 
# into imagenettrain
cd ../
mkdir imagenett
cd imagenett
cp -r ../bigtest/* .

# make train images list to feed to darknet
find . -type f -name "*.JPEG" > imagenett.txt
sed -i 's;^./;;' imagenett.txt

# now we got the required 2 folders; imagenettrain and imagenetval
# each folder comprises of JPEG and its corresponding txt label file
# and a list of imagenettrain.txt and imagenetval.txt
# to give to darknet

#mv bigtestandlabel.txt ../
mv imagenetwow.txt ../
#mv imagenetvallabel.txt ../
mv imagenett.txt ../





