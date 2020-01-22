change code to print result (class, and coordinates)

#code for testing

get command 
python3 ../detectorcode/adrianyolosnake.py --image ../testimages/russellsviper_003.jpg --yolo ../yolov3snake

#loop name of files from a folder into --image argument

repeat=10
for n in $(seq $repeat); 
    do
        command1
        command2
    done

for i in 1 2 3; do
  some commands
done

for run in {1..10}
do
  command
done

for run in {1..10}; do command; done

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

#coordinates
ref. line 110 from adrianyolov3-tiny.py
cv2.rectangle(image, (x, y), (x + w, y + h), color, 2)
assign a variable 3 
save as result record/predicted_blob_filename

#take blob from test dataset
#what does blob include, in case of test dataset. do class, confidence,
#and ground truth?? box comes in one file when you annotate them?

#in case of result, the class and confidence comes together, 
#while bounding box coordinates are calculated separately.
for file in test.txt
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
