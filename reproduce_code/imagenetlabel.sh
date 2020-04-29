cd ../heavystuffishere
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
wget -o generate_labels.py https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py
#mv generate_labels.py ../../../nowinthebox/object-detection/relabel_code/
#mv generate_labels.py ../../../mnt/nas/objectscp/convert_VOC_to_yolo/generate_labels.py

cd ../
mkdir imagenetlabel
cd imagenetlabel
wget http://image-net.org/archive/words.txt

#python3 object-detection/relabel_code/generate_label.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0
python3 ../../heavystuffishere/convert_VOC_to_yolo/generate_labels.py.1 ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0
