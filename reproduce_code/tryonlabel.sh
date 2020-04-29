cd ../heavystuffishere
mkdir convert_VOC_to_yolo
cd convert_VOC_to_yolo
wget 'https://github.com/mingweihe/ImageNet/raw/master/generate_labels.py'
#mv generate_labels.py ../../../mnt/nas/objectscp/convert_VOC_to_yolo/generate_labels.py

cd ../
mkdir imagenetlabel
cd imagenetlabel
wget http://image-net.org/archive/words.txt

#python3 object-detection/relabel_code/generate_label.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0
python3 ../../heavystuffishere/convert_VOC_to_yolo/generate_labels.py ../../heavystuffishere/imagenetlabel/words.txt ../../heavystuffishere/imagenetbbox ../../heavystuffishere/imagenetlabel/ 0

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

for file in n01729322*.txt; do awk '$1==92{$1=83;print}' $file >> "$file"; done
for file in n03701391*.txt; do awk '$1==94{$1=93;print}' $file >> "$file"; done
cp -r ./* ../imagenet_allimages/
cd ../imagenet_allimages

find . -exec bash -c 'basename "$0" ".${0##*.}"' {} \; | sort | uniq --repeated > imagenetpairs.txt
awk '{print;print;}' imagenetpairs.txt > imagenetpairsdouble.txt
sed -e 's/$/.JPEG/' -i imagenetpairsdouble.txt
sed '0~2 s/$/.txt/g' < imagenetpairsdouble.txt > imagenet_allimagesandlabel.txt
sed -i 's/.JPEG.txt/.txt/g' imagenet_allimagesandlabel.txt