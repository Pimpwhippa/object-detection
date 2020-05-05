
# download FireandSmoke dataset
cd ../heavystuffishere/
mkdir fire
cd fire
wget https://drive.google.com/uc?id=1Cq9KGYzmQ2IlFnkWyji-03DSJWZY36jS&export=download


# 2.3 fire-label the images. make bbox using Yolo-mark. 
cd ../
mkdir yolo_mark
cd yolo_mark
git clone https://github.com/AlexeyAB/Yolo_mark.git

# label only these (positive) files
cd ..
cd fireandsmoke/FiSmo-Images/Flickr-FireSmoke/imgs

# ls images-class-fire.csv
cp -r (< images-class-fire.csv) folder_in_yolo_mark

# go label the images,
# and because yolo_mark automatcially generates labels in the same place 
# where images are, bbox will be in fire_allimages as well
cd
cd folder_in_yolo_mark
cd ..
mv folder_in_yolo_mark fire_allimages

mv fire_allimages ../../out_of_yolo_mark

# include true negative images for better inference (since it is provided)
cd
cd fireandsmoke/FiSmo-Images/Flickr-FireSmoke/negative

# randomly select 10% of negative images(otherwise there are too many negatives)
cd ..
mkdir negative_temp
cd ../negative
find . -type f | shuf -n 395 | xargs -i mv {} ../negative_temp

cd ../negative_temp
# create empty label.txt files with same name as these randomly selected files.jpg
for filename in *; do touch -- "${filename}.txt";  done

# now i got filename.jpg.txt, have to remove .jpg of every files
for file in *.txt; do mv "${file}" "${file/.jpg/}"; done

# now we have negative fire images and empty label txt files in negative_temp

# mv everything from negative_temp into fire_allimages
mv -r . ../fire_allimages
# now we have all images (positive and negative) and all labels in fire_allimages
# delete negative_temp folder
cd ..
rm -rf negative_temp

# split traintest sets
# fireval

# from fire_allimages, randomly select 10% of images files,
# mv them to fireval
cd
mkdir fireval
cd ../fire_allimages
find . -type f -name '*.jpg' |shuf -n 550 > fireval.txt
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
cd
mkdir firetrain
cp -r ../fire_allimages/* .
# keep fire_allimages untouched for further different traintestsplit
