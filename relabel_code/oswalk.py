import os
for target, dirs, files in os.walk('../../heavystuffishere/bbox3', topdown=True):
        print (target)
        #print (dirs)
        #print (files)