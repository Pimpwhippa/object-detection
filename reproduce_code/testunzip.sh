#!/bin/bash

unzip '../heavystuffishere/train2014.zip' -d ../heavystuffishere/testunzip2/
#unzip '../heavystuffishere/val2014.zip' -d ../heavystuffishere/coco/images/ &

java -jar cocotoyolo.jar "../heavystuffishere/coco/annotations/annotations/instances_train2014.json" "../heavystuffishere/testunzip2/train2014/" "car,truck,bus" "../heavystuffishere/coco/yolo/"
