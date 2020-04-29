# 1. download training images

# download MSCOCO images
# have to use mscoco2014, if use coco2017, mAP will be less than 1%!!

# train images
mkdir coco/train2014
cd coco/train2014
wget http://images.cocodataset.org/zips/train2014.zip

# val images
cd
mkdir coco/val2014
cd coco/val2014
wget http://images.cocodataset.org/zips/val2014.zip

# train and val annotations
cd
mkdir coco/annotations
cd coco/annotations
wget http://images.cocodataset.org/annotations/annotations_trainval2014.zip

# or get from pjreddie's darknet repo
# cp scripts/get_coco_dataset.sh data
# cd data
# bash get_coco_dataset.sh

# download ImageNet images of the custom class
cd
mkdir imagenet_allimages
cd imagenet_allimages

# make a list of wnid of objects to be downloaded
for wnid in object_list:
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
mkdir imagenet/bbox
cd imagenet/bbox
for wnid in object_list:
do 
    mkdir "$wnid"
    cd "$wnid"
    #do mkdir n03127747
    wget http://www.image-net.org/api/download/imagenet.bbox.synset?wnid="$wnid"
    # wget http://www.image-net.org/api/download/imagenet.bbox.synset?wnid=n03127747
done



# 2.make sure that the coordinates of the bbox is in the format Darknet requires.
# which is 5 columns; class x y w h, where (x,y) is the coordinates of the center of the box 

# for MSCOCO and ImageNet, data comes with bbox but conversion for bbox coordinates is needed. 
# tools are here;

# 2.1 MSCOCO to yolo
cd
mkdir convert_coco_to_yolo
cd convert_coco_to_yolo

git clone https://bitbucket.org/yymoto/coco-to-yolo/src/master/

java -jar pimpwhippa/object-detection/cocotoyolo.jar 
"/mnt/nas/objectstodetect/coco/annotations/instances_train2014.json" 
"/mnt/nas/objectstodetect/coco/train2014/" 
"person,car,motorcycle,bird,cat,dog,backpack,handbag,suitcase,knife,tv,laptop,cell phone,scissors" 
"/home/user/pimpwhippa/object-detection/coco/train2014label" 
# check where is destination folder, should be like below

# save converted annotation in coco/train2014label, coco/val2014label
cd
mkdir coco/train2014label
cd
mkdir coco/val2014label

# 2.2 ImageNet(pascal VOC) to yolo
cd
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
git clone https://github.com/mingweihe/ImageNet/blob/master/generate_labels.py

# get file wnid_synset.map and put in folder imagenet/bbox
cd
mkdir imagenetlabel
cd imagenetlabel
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




# 3. divide data into train(90%) and val(10%) sets
# either use train/test split.py to split automatically or manually do below
# coco is already split trainval
# need to do the same for ImageNet and fire

# ImageNet traintestsplit
from each imagenet wnid image folder, randomly select 10% out (.JPEG)
# or just put all wnid together and randomly select 10%
match the filenames with the files in wnid label folder (.txt)
# GroupKfold.split
mkdir imagenetval
mkdir imagenettrain
cut the 10% images and 10% labels from imagenet_allimages and imagenetlabel into imagenetval
cut the 90% images and 90% labels from imagenet_allimages and imagenetlabel into imagenettrain




# 4. yolo requires label files to be in the same folder as image files
# keep image files untouched in spacious data storage
# keep label files separated and easily amendable
# put the newly revised label files for each new training with the image files

# cocotrain
find coco/train2014label -type f '*.txt' > grandyolotrain2014label.txt

for file in $(cat grandyolotrain2014label.txt); 
do mv "$file" ../train2014; done

# cocoval
find coco/val2014label -type f '*.txt' > grandyoloval2014label.txt

for file in $(cat grandyoloval2014label.txt); 
do mv "$file" ../val2014; done

# imagenettrain
done in 3. already

# imagenetval
done in 3. already



# 5. make 2 text files; train.txt and val.txt.
# these files are list of image files (.jpg) to be input for training.
# get list of images and its relative path to ./darknet (label files are in the same folder)
cd
cd pimpwhippa/object-detection/
mkdir traingrandyolo
cd traingrandyolo

find coco/train2014 -type f -name '*.jpg' > grandyolococotrain.txt

find coco/val2014 -type f -name '*.jpg' > grandyolococoval.txt

find imagenettrain -type f -name '*.JPEG' > grandyoloimagenettrain.txt

find imagenetval -type f -name '*.JPEG' > grandyoloimagenetval.txt

find firetrain -type f -name '*.jpg' > grandyolofiretrain.txt

find fireval -type f -name '*.txt' > grandyolofireval.txt

cp grandyolococotrain.txt > grandyolotrain.txt
cp grandyoloimagenettrain.txt >> grandyolotrain.txt
cp firetrain.txt >> grandyolotrain.txt

cp grandyolococoval.txt > grandyoloval.txt
cp grandyoloimagenetval.txt >> grandyoloval.txt
cp fireval.txt >> grandyoloval.txt

6. add names of the classes into .names file
# coco.names append object_list append fire

7. add train.txt, val.txt, .names, into .data file
touch grandyolo.data
classes = 99
train = grandyolotrain.txt
valid = grandyoloval.txt
backup = /backup
eval = coco

8. cfg file- more details coming soon

9. download initial weight file
wget https://pjreddie.com/media/files/darknet53.conv.74

10. train
./darknet train .data_file .cfg_file .weights file 
(train from initial random weight 
or continue from current weight file from /backup/grandyolo_last.weights)

11. measure loss and mAP (mean average precision). 
loss should decrease in a log shape, while mAP mirrors the loss graph on horizontal axis.
