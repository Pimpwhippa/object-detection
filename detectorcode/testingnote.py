change code to print result (class, and coordinates)
change to cv2.waitkey(delay) so i don't have to press to continue (waitkey(0)have to press)
#code for testing

#get command 
#required files adrianyolosnake.py, yolov3snake/cfg, weights, snake.names
#python3 ../detectorcode/adrianyolosnake.py --image ../testimages/russellsviper_003.jpg --yolo ../yolov3snake

#loop name of files from a folder into --image argument
#import os, subprocess
#for filename in os.listdir(darknet/testimages): do 
#  python3 ../detectorcode/adrianyolosnake.py --image subprocess.((pwd)/testimages) --yolo ../yolov3snake
#; done

#the following works. will be even better with -regex *.jpe?g
for file in ../testimages/*.jpeg: do
 python3 ../detectorcode/adrianyolosnake.py --image "$file" --yolo ../yolov3snake
; done

#record result (class, and coordinates (results of yolov3 is offsets from anchor--> how to compare with the box from test dataset?))
#text = "{}: {:.4f}".format(LABELS[classIDs[i]], confidences[i])
for each run;
result record = variable 1, 2, 3

#class label
ref. line 111 from adrianyolov3-tiny.py
text = "{}: {:.4f}".format(LABELS[classIDs[i]], confidences[i])
assign variables 1,2
print (class label, confidences)
save as result record/predicted_class_filename

#(cv) root@0f22b717f3ef:/darknet/detectorcode# 
# >output.txt  print output [INFO] load yolo to disk, class, confidence to file
# if it doesn't detect, it outputs nothing
#how to make it print even if it is nothing
#doesn't have filename, can't identify which file it cannot detect
#or save each iteration in each file? or in a variable? or in a dictionary?
for file in ../testimages/*.jpg; do  python3 ../detectorcode/adrianyolosnake.py --image "$file" --yolo ../yolov3snake; done > output.txt

#try to save each output to each file with the same name as input. but only output one last file
#for file in ../testimages/*.jpg; do  python3 ../detectorcode/adrianyolosnake.py --image "$file" --yolo ../yolov3snake; done > "${file}"_output.txt
#File: ../testimages/zeusknife.jpg_output.txt

#save output of each iteration in each file, even if it detects nothing
for file in ../testimages/*.jpg; do name="${file##*/}"; python3 ../detectorcode/adrianyolosnake.py --image "$file" --yolo ../yolov3snake > res/"${name}"_output.txt;done

for file in Yolo_mark/x64/Release/data/img/*.jpg; do name="${file##*/}"; python3 AdrianRosebrock/adrianyolosnake.py --image "$file" --yolo snake > testsnake/"${name}"_output.txt;done

#output from actual detector
#/darknet/testsnake
snake: 0.8852
#output from labelling
#darknet/Yolo_mark/x64/Release/data/img
0 0.427344 0.520833 0.689062 0.402778


#coordinates
ref. line 110 from adrianyolov3-tiny.py
cv2.rectangle(image, (x, y), (x + w, y + h), color, 2)
assign a variable 3 
save as result record/predicted_blob_filename

#take blob from test dataset
#what does blob include, in case of test dataset. do class, confidence,
#and ground truth?? box comes in one file when you annotate them?

#finish from bash get result in text files. now start python script in comparing

#read every file into a list
import glob
path = '/darknet/testsnake/*.txt'   
files = glob.glob(path)   
for name in files:
        #filename = "testsnake/indpython2l.jpg_output.txt"

        with open(name, 'r') as filehandle:  
                filehandle.seek(0) #ensure you're at the start of the file..
                first_char = filehandle.read(1)
#try to print even empty files
if first_char == s:
        count 1
if not
#if first_char != s:
        count 0
#if it detects something
#if first_char !=0:
#       count 1
        print (first_char)
accuracy = count/count(first_char counted1)+count(first_char counted0)
print (accuracy)
if not first_char:
        print ("file is empty")
#               for line in filehandle:
#                       print(line)
#if not line:
#               print ("file is empty")

#old versions
import glob
path = '/darknet/testsnake/*.txt'   
files = glob.glob(path)   
for name in files:
        #filename = "testsnake/indpython2l.jpg_output.txt"
	with open(name, 'r') as filehandle:  
                for line in filehandle:
                        print(line),
               	if not line:
                	print ("nothing")


for file_actual in results/*.jpg_output.txt
  with open('some_file_1.txt', 'r') as file1:
    lines = list(open('filename'))
    file1list = f1.read().splitlines()

import glob
import os

file_list = glob.glob(os.path.join(os.getcwd(), "FolderName", "*.txt"))

corpus = []

for file_path in file_list:
    with open(file_path) as f_input:
        corpus.append(f_input.read())

print corpus  

PathwayList = {}
for InFileName in FileList:
    sys.stderr.write("Processing file %s\n" % InFileName)
    InFile = open(InFileName, 'r')
    PathwayList[InFile] = InFile.readlines()
    InFile.close()

for filename, contents in PathwayList.items():
    # do something with contents which is a list of strings
    print filename, contents  


for file_expected from custom2/trainsnake/data/img/*.txt

actual.txt
expected.txt

ไฟล์ไพธอน
ทำเป็นคู่ๆไป;

    with open('some_file_2.txt', 'r') as file2:
เรียก ทุกไฟล์ใน โฟลเดอร์หนึ่ง 
เรียก ทุกไฟล์ใน โฟลเดอร์สอง
ใส่ดิก --dict obj.names
ทำดังต่อไปนี้
แล้วส่งไปที่เอ้าพุท > eh, this is not bash!
ดัน

for เริ่มจากคู่แรก
อ่านจากบรรทัดแรก ค่าแรก ไฟล์แรก 
#read all files line by line into list
#read all files into one file? or remain inside their file name?
#how to make sure that the files with same name is sorted at the same index

  งู

for all lines
# x= index[0]
  with open(filename, 'r') as f:
    for line in f:
      file1list = f1.read().splitlines()
      file2list = f2.read().splitlines()
        value = mydict.get(line.strip())
        if value is not None:
            print value

with open(myFile, "r") as f:
    excludeFileContent = list(filter(None, f.read().splitlines()))

fpath = 'dummy.txt'
with open(fpath, "r") as f: lst = [line.rstrip('\n \t') for line in f]
print lst
>>>['THIS IS LINE1.', 'THIS IS LINE2.', 'THIS IS LINE3.', 'THIS IS LINE4.']

from pathlib import Path
p = Path('my_text_file')
lines = p.read_text().splitlines()

with open(fname) as f:
    content = f.readlines()
# you may also want to remove whitespace characters like `\n` at the end of each line
content = [x.strip() for x in content] 



เทียบกับดิก 
  ได้เลขอะไร 
  จดไว้
#here is where i have to look up the dict()
# #list1length = len(file1list)
#list2length = len(file2list)
#if list1length == list2length:

#here is where i see if the index from dict() matches
      for index in range(len(file1list)):
              if file1list[index] == file2list[index]:
                  print file1list[index] + "==" + file2list[index]
              else:                  
                  print file1list[index] + "!=" + file2list[index]+" Not-Equal"
      else:
          print "difference inthe size of the file and number of lines"
  อ่านค่าจากไฟล์เรียกสอง
  จดไว้
  เทียบกับดิก
    ถ้าเป็นคีย์๘แวลู อินเด็กซ์ เลข(จากดิก)เดียวกัน ค่าแรกจากไฟล์แรก กะ ค่าจากไฟล์เรียกสอง
      ให้ส่งไปที่เอ้าพุทหนึ่งครั้ง ว่า หนึ่ง (เห็นงู) positive

    ถ้าไม่ใช่เลขเดียวกับ ค่าแรกของไฟล์เรียกสอง
      ให้ส่งไปที่เอ้าพุทหนึ่งครั้ง ว่า ศูนย์ (เห็นช้างเป็นงู) false positive

ถ้าอ่านมาจากบรรทัดแรก ค่าแรก ไฟล์แรก แล้วไม่เจอค่าอะไร

  ไม่มีอะไรไปเทียบกับดิก
    
  ให้อ่านค่าแรกของไฟล์เรียกสอง
  จดไว้
  เทียบกับดิก 
    ได้ค่า คีย์๘แวลู อินเด็กซ์ ถ้าได้คลาส งู (แต่ถ้าได้คลาสอื่นไม่เป็นไร เพราะเรากำลังเทสงูอยู่)
      ให้ส่งไปที่เอ้าพุทหนึ่งครั้ง ว่า ศูนย์ (มีงูแต่หาไม่เจอ) false negative

  ถ้าอ่านมาจากค่าแรกของไฟล์เรียกสอง 
    ไม่เจอค่าอะไร ไม่ได้คลาส ไม่มีอะไรไปเทียบกับดิก
      ให้ส่งไปที่เอ้าพุทหนึ่งครั้ง ว่า หนึ่ง (ไม่มีงูจริงๆ) negative

ทำไปจนครบทุกคู่ end for 

นับรวมได้เท่าไหร่
หารด้วยจำนวนครั้งที่ส่งมาเอ้าพุททั้งหมด
ตอบเป็นค่าความแม่น accuracy

obj.names as dictionary
for file in file_actual;
 file.readline
split string

obj actual class
obj actual bbox
obj expected class
obj expected bbox


#in case of result, the class and confidence comes together, 
#while bounding box coordinates are calculated separately.
for file in custom2/trainsnake/data/img/*.txt
test_blob_filename[0]
assign a variable 4
test_class

test_blob_filename[1:5]
assign a variable 5
-coordinates (have to convert coordinates of bounding box from test set into size 1280*720?? to be comparable with anchor?)
save as test_blob_filename

#test class: result compared to test set
assert variable 1 & 4 equal or not

output yes or no
correct = count yes
incorrect = count no

accuracy percentage = correct/sum(correct+incorrect)
print (accuracy percentage)
if accuracy percentage > 90;
  print (well done!)

#test coordinates: result compared to test set
assert variable 3 & 5
calculate IOU??
#how to calculate the area of the two bounding boxes to check if they are
#at the same/more or less position?
from variable 3
box = detection[0:4] * np.array([W, H, W, H])
			(centerX, centerY, width, height) = box.astype("int")
find the area of box
find the area of the coordinates from test_blob_filename
IOU = 
print (IOU)
if IOU > 90;
  print (there you go!)

#what about confidence? where is variable 2?

from result record
compare class with test set the same or not, output yes or no
-count yes
-count no
record probability
compare coordinates
-convert results back to anchor box
-bring in coordinates of test datasetbounding box
-compare
