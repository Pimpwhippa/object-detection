# download ImageNet images of the custom class
cd
mkdir ../../heavystuffishere/imagenet_allimages
cd ../../heavystuffishere/imagenet_allimages

# make a list of wnid of objects to be downloaded
OBJECT_LIST=(n01739322 n03127747 n03701391 n01695060)

for wnid in $OBJECT_LIST:
do 
    mkdir "$wnid"
    cd "$wnid"
# have to change wnid for each download
# for example, wnid=n01729322
    wget http://www.image-net.org/download/synset?wnid="$wnid"&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford
    # wget http://www.image-net.org/download/synset?wnid=n01729322&username=lertlove&accesskey=0b188567e69ce114b046082cb49cbd40f1d5e414&release=latest&src=stanford
done

# download ImageNet bounding box, have to change wnid also
cd
cd ../../heavystuffishere/imagenet
mkdir bbox
cd bbox
for wnid in object_list:
do 
    mkdir "$wnid"
    cd "$wnid"
    #do mkdir n03127747
    wget http://www.image-net.org/api/download/imagenet.bbox.synset?wnid="$wnid"
    # wget http://www.image-net.org/api/download/imagenet.bbox.synset?wnid=n03127747
done

# 2.2 ImageNet(pascal VOC) to yolo
cd
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
git clone https://github.com/mingweihe/ImageNet/blob/master/generate_labels.py

# get file wnid_synset.map and put in folder imagenet/bbox
cd
mkdir ../../heavystuffishere/imagenetlabel
cd ../../heavystuffishere/imagenetlabel
for wnid, synset in wnid_synset.map:
do 
    mkdir "$wnid"
    python3 ../convert_VOC_to_yolo/generate_labels.py
    ../../objectstodetect/imagenet/bbox/wnid_synset.map
    # ../../objectstodetect/imagenet/bbox/n03127747_annotationcrash_helmet 
    ../../objectstodetect/imagenet/bbox/"$wnid"_"$synset"
    . 03127747

# now folder imagenetlabel should be populated with subfolders of synset label files
# (for example, from n0169xxxx wnid, now monitor lizard is 8671 after map with synset)
# then have to renumber the class indexes into those from cocoimagenet.names 
    sed -i 's/^8671/80/' $file >>"$file"
done

# add superclass snake and gun with extra label
for range(84, 93)  # 84, 85, 86, 87, ..., 92
do
    cd into folders with class index 84-92
    for file in *.txt; do awk '{$1=83; print;}' $file >>"$file"
done

for range(94, 96)  # 94, 95
do 
    cd into folders with class index 94, 95
    for file in *.txt do awk '{$1=93; print;}' $file >>"$file"
done

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











