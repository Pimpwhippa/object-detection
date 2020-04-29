How to run custom detector using Darknet and custom yolov3


# From pimpwhippa docker hub
# pull docker image comprises of cuda, cudnn, opencv, and darknet from github of AlexeyAB (forked from pjreddie)
docker pull pimpwhippa/work:cocotoyolo

user@obd2:~/pimpwhippa $ docker run 
		--runtime=nvidia 
	-it 
	-e DISPLAY=unix$DISPLAY  # set host display to local machine display
	-v `pwd`:`pwd` 
	-v /tmp/.X11-unix:/tmp/.X11-unix  # binds mount x11 socket on local machine in the container
	# have to -v datastorage too
	-w `pwd`  # set working directory
		--name pimpwhippatotheworld
	pimpwhippa/work:cocotoyolo


cd darknet
make clean
make

wget https://pjreddie.com/media/files/yolov3.weights

# test with vanilla darknet/yolov3
root@a1ab51f3a18b:/home/user/pimpwhippa/darknet# ./darknet detector test cfg/coco.data cfg/yolov3.cfg ../yolov3.weights -thresh 0.25

# activate virtualenv with opencv
workon cv

(cv) root@3d9bfa88d625:/home/user/pimpwhippa/darknet# ./darknet detector test ../object-detection/grandyolo.data ../object-detection/grandyolo/grandyolo.cfg ../grandyolo_best.weights

1. grandyolo.data is the same file used during training

the content of grandyolo.data;
classes = 99  
train = path/to/train.txt  
valid = path/to/val.txt
names = cocoimagenet.names
backup = backup/  

classes = number of objects trained to be detected
train = list of path to images used during training
valid = list of path to images used for validation
names = names of the 99 classes
backup = localtion where newly trained weights are saved

2. grandyolo.cfg is also the same file used during training

3. grandyolo_best.weights are the custom weight trained with the default yolo 80 classes plus requested custom classes, in total 99 classes

==============================================

How to train weights file to detect custom classes

1. download images of the custom class (minimum 300 images per class)

2. label the images. make bbox using Yolo-mark. make sure that the coordinates of the bbox is in the format Darknet requires. 

for MSCOCO and ImageNet, data comes with bbox but conversion for bbox coordinates is needed. tools are here;

2.1 MSCOCO to yolo https://bitbucket.org/yymoto/coco-to-yolo/src/master/
2.2 ImageNet(pascal VOC) to yolo https://github.com/mingweihe/ImageNet/blob/master/generate_labels.py

3. divide data into train(80%) and val(20%) sets

4. make 2 text files; train.txt and val.txt. these files are list of image files (.jpg) and bbox (label,.txt) files for each set.

5. add names of the classes into .names file

6. add train.txt, val.txt, .names, into .data file

7. cfg file- more details coming soon

8. train
./darknet train .data_file .cfg_file .weights file (train from initial random weight or continue from current weight file)

9. measure loss and mAP (mean average precision). loss should decrease in a log shape, while mAP mirrors the loss graph on horizontal axis.

