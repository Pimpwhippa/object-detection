
cd ../heavystuffishere
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
#wget -o generate_labels.py https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py
wget 'https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py'

cd ../
mkdir imagenetlabel
cd imagenetlabel
wget http://image-net.org/archive/words.txt

# 3. go to change file paths in generate_label.py
# change mapfile, xml folder, output folder

#python3 object-detection/relabel_code/generate_label.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0
python3 ../../heavystuffishere/convert_VOC_to_yolo/generate_labels.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0

# now folder imagenetlabel should be populated with label files
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
cp -r ./* ../imagenet_allimages/

#now imagenet_allimages has both JPEG and txt files

#but there are only 2162 labels for 5349 images
#either create label for the other 3187 images or remove the 3187 images

# cannot create empty label files, because they are positive images
# i chose to remove the 3187 images because 2162/4, around 500 images for each class
# is sufficient

cd ../imagenet_allimages
# match label files with image files
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
ls -p | grep -v / | sed 's/\<imagenet_allimagesandlabel.txt\>//g' | sort | comm -3 - <(sort imagenet_allimagesandlabel.txt) | xargs echo | tr " " "\n"
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