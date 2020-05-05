#!/bin/bash

# download FireandSmoke dataset
cd ../heavystuffishere/
mkdir fire
cd fire

#wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Cq9KGYzmQ2IlFnkWyji-03DSJWZY36jS' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Cq9KGYzmQ2IlFnkWyji-03DSJWZY36jS" -O FiSMo-Images.zip && rm -rf /tmp/cookies.txt 
#unzip FiSMo-Images.zip
cd FiSmo-Images
cd Flickr-FireSmoke
#nano imagenames-classes.csv

#make this file- images-class-fire.csv- from above file (5556lines)
#second column after comma 1 is fire, 0 is not fire

awk -F "," '$2==1{print $1}' imagenames-classes.csv > images-class-fire.csv
mkdir ../../../../../../nowinthebox/Yolo_mark/x64/Release/data/imgs
# move positive images to yolo_mark
cd imgs
cp $(< ../images-class-fire.csv) ../../../../../../nowinthebox/Yolo_mark/x64/Release/data/img/

# go in yolo_mark to label all 1604 fire images
# xhost +local:docker
# ./linux_mark.sh
# git clone https://github.com/AlexeyAB/Yolo_mark.git
# cd Yolo_mark/x64/Release/data/img
# ls . > train.txt

# include true negative images for better inference (since it is provided)
cd ../heavystuffishere/fire/FiSmo-Images/Flickr-FireSmoke/

awk -F "," '$2==0{print $1}' imagenames-classes.csv > images-class-notfire.csv

# randomly select 10% out of 3952 notfire images
mkdir negative_temp
cd imgs
cp $(< ../images-class-notfire.csv) ../negative_temp
cd ../negative_temp
mkdir negative_selected
find . -type f | shuf -n 395 | xargs -i mv {} negative_selected

# create empty label.txt files with same name as these randomly selected files.jpg
cd negative_selected
for filename in *; do touch -- "${filename}.txt";  done
for file in *.txt; do mv "${file}" "${file/.jpg/}"; done
# now we have negative fire images and empty label txt files in negative_selected
cd ../../
mkdir fire_allimages

# move positive images and newly labelled files to fire_allimages
mv ../../../../../nowinthebox/Yolo_mark/x64/Release/data/img/* fire_allimages
cd negative_temp/negative_selected
mv . ../../fire_allimages
# now we have all images (1604 positive and 395 negative) and all labels in fire_allimages

mkdir fireval
cd ../fire_allimages

# select 10% of all images and mv to fireval
find . -type f -name '*.jpg' |shuf -n 200 > fireval.txt
# xargs -i mv {} ../fireval
mv $(< fireval.txt) ../fireval

# match the 10% filenames from fireval with its label in fire_allimages
# change file extension of files in fireval.txt from jpg to txt
sed -i 's/jpg/txt/g' fireval.txt > firevallabel.txt

# take the matched files and put it together with its images in fireval
mv $(< firevallabel.txt) ../fireval

# firetrain
# copy the rest 90% images and labels from fire_allimages
# put them in firetrain
cd ..
mkdir firetrain
cd firetrain
cp -r ../fire_allimages/* .
