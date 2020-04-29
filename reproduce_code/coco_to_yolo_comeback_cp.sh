#!/bin/bash

### Recommended to run 'nohup ./<this_script> &' to prevent interruption from SSH session termination.

# Misc. utilities
echo "Installing git."
apt-get -q -y install git
apt-get -q -y install unzip
mkdir -p ../heavystuffishere/coco/images/ ../heavystuffishere/coco/annotations/

#download_pids=()

### 2014 COCO Dataset ###

echo "Downloading COCO dataset..."
#curl -OL "http://images.cocodataset.org/zips/train2014.zip"  &
#download_pids+=("$!")
#curl -OL "http://images.cocodataset.org/zips/val2014.zip" &
#download_pids+=("$!")
#curl -OL "http://images.cocodataset.org/annotations_trainval2014.zip" &
#wget -c https://pjreddie.com/media/files/instances_train-val2014.zip &
#download_pids+=("$!")

#wait_to_finish download_pids

#inflate_pids=()

#เมื่อตอนสั่งดาวโหลดมา ให้มาลงหน้าบ้าน แต่นี่ย้ายมาวางในห้องเก็บของตั้งกะเมื่อไหร่
unzip '../heavystuffishere/train2014.zip' -d ../heavystuffishere/coco/images/
#inflate_pids+=("$!")
unzip '../heavystuffishere/val2014.zip' -d ../heavystuffishere/coco/images/ 
#inflate_pids+=("$!")
unzip 'instances_train-val2014.zip' -d ../heavystuffishere/coco/annotations/  # Inflates to 'coco/annotations'.
#inflate_pids+=("$!")

#wait_to_finish inflate_pids

mkdir -p ../heavystuffishere/coco/labels

### Annotation Converter ###
curl -OL "http://commecica.com/wp-content/uploads/2018/07/cocotoyolo.jar"

#java -jar cocotoyolo.jar "$PWD/../heavystuffishere/coco/annotations/annotations/instances_train2014.json" "$PWD/../../heavystuffishere/coco/images/train2014/" "car,truck,bus" "$PWD/../../heavystuffishere/coco/yolo/"
java -jar cocotoyolo.jar "../heavystuffishere/coco/annotations/annotations/instances_train2014.json" "../heavystuffishere/coco/images/train2014/" "car,truck,bus" "../heavystuffishere/coco/yolo/"

mv ../heavystuffishere/coco/yolo/image_list.txt ../heavystuffishere/coco/train2014_images.txt
mv ../heavystuffishere/coco/yolo/ ../heavystuffishere/coco/labels/train2014/

java -jar cocotoyolo.jar "../heavystuffishere/coco/annotations/annotations/instances_val2014.json" "../heavystuffishere/coco/images/val2014/" "car,truck,bus" "../heavystuffishere/coco/yolo/"

mv ../heavystuffishere/coco/yolo/image_list.txt ../heavystuffishere/coco/val2014_images.txt
mv ../heavystuffishere/coco/yolo/ ../heavystuffishere/coco/labels/val2014/