# download ImageNet images of the custom class
cd
mkdir ../../heavystuffishere/imagenet_allimages
cd ../../heavystuffishere/imagenet_allimages
#wget http://image-net.org/image/ILSVRC2017/ILSVRC2017_DET.tar.gz

# make a list of wnid of objects to be downloaded
OBJECT_LIST=('n01695060' 'n01729322' 'n03127747' 'n03701391')
echo ${OBJECT_LIST[*]}

# have to be logged in to be able to download
#xdg-open http://image-net.org/download-images
    #inputloginpswd.sh <<!
    #lertlove
    #obodroid
#!

for wnid in ${OBJECT_LIST[@]};
do 
   mkdir "${wnid[@]}"
   cd "${wnid[@]}"
   wget "http://www.image-net.org/download/synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   tar xvf "synset?wnid=${wnid}&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford"
   cd ..
done


# download ImageNet bounding box, have to change wnid also
cd
mkdir ../../heavystuffishere/imagenet/bbox
cd ../../heavystuffishere/imagenet/bbox

for wnid in ${OBJECT_LIST[@]};
do
    wget http://www.image-net.org/downloads/bbox/bbox/${wnid}.tar.gz
    tar xvf ${wnid}.tar.gz
done

# 2.2 ImageNet(pascal VOC) to yolo
cd
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
wget https://github.com/mingweihe/ImageNet/blob/master/generate_labels.py

# get file wnid_synset.map and put in folder imagenet/bbox
cd
mkdir ../../heavystuffishere/imagenetlabel
cd ../../heavystuffishere/imagenetlabel
wget http://image-net.org/archive/words.txt

# go to change file paths in generate_label.py
# change mapfile, xml folder, output folder
python3 object-detection/relabel_code/generate_label.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/bbox3 ../../heavystuffishere/imagenetlabel/ 0

    

# now folder imagenetlabel should be populated with subfolders of synset label files
# (for example, from n0169xxxx wnid, now monitor lizard is 8671 after map with synset)
# then have to renumber the class indexes into those from cocoimagenet.names 
# cd ../../heavystuffishere/imagenetlabel
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
    sed -i 's/^20346/95/' $file >> "$file"
done

#8854 n01729322 sandviper snake 92
#16933 n03127747 crash helmet 82
#20346 n03701391 machine gun 95
84	snake	18	83	83
85	water snake 	19	84	84
86	green snake	20	85	85
87	night snake 	21	86	86
88	king snake	22	87	87
89	garter snake	23	88	88
90	ring neck snake	24	89	89
91	vine snake	25	90	90
92	thunder snake	26	91	91
93	sandviper snake	27	92	92
94	gun 	28	93	93
93 gun 28 93 93
95	machine gun 	29	94	94
96	pistol 	30	95	95



# add superclass snake and gun with extra label
for file in ../../heavystuffishere/imagenetlabel;
do
    #for range(84, 93)  # 84, 85, 86, 87, ..., 92;
    for file in n01729322*.txt; #92
    do
        awk -i inplace '{print} $1==92{$1==83; print}' {} +
        #awk '{$1=83; print;}' $file >>"$file"
    done
    
    #for range(94, 96)  # 94, 95;
    for file in n03701391*.txt; #94
    do 
        awk '{$1=94{$1==93}; print;}' $file >>"$file"
    done
done

#for file in *.txt do
# some of imagenet synset doesn't come with label files
# just pick files that have label files
for "$wnid" in imagenetlabel;
do
    mv -r imagenetlabel/"$wnid"/* imagenet_allimages/"$wnid"/
done

cd ../../heavystuffishere/imagenet_allimages
find . -exec bash -c 'basename "$0" ".${0##*.}"' {} \; | sort | uniq --repeated
    > imagenetpairs.txt

delete files that are NOT in this list imagenetpairs.txt
rm !(textfile.txt|backup.tar.gz|script.php|database.sql|info.txt)

find . | grep -v "excluded files criteria" | xargs rm

find /path/to -type f \( ! -name "excludelist" $(printf ' -a ! -name %s\n' $(< excludelist)) \) -exec echo rm {} \;

# ImageNet traintestsplit
cd
mkdir imagenetval

# GroupKfold.split
# randomly select 10% out (.JPEG)
cd imagenet_allimages
find . -type f -name '*.JPEG'| shuf -n 630 > imagenetval.txt
mv $(< imagenetval.txt) ../imagenetval

# match the filenames with the files in wnid label folder (.txt)
sed -i 's/JPEG/txt/g' imagenetval.txt > imagenetvallabel.txt
mv $(< imagenetvallabel.txt) ../imagenetval

# copy the rest 90% images and 90% labels from imagenet_allimages 
# into imagenettrain
cd
mkdir imagenettrain
cd imagenettrain
cp -r ../imagenet_allimages/* .











