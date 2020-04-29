import xmltodict, json
import os

#path to the folder holding the XML
directory = 'objectstodetect/imagenet_not_use/imagenetannotations/'

#iterate over the XML files in the folder
for filename in os.listdir(directory):
    if filename.endswith(".xml"):
        f = open(filename)

        XML_content = f.read()

        #parse the content of each file using xmltodict
        x = xmltodict.parse(XML_content)
        j = json.dumps(x)
        
        with open('converted.json', 'w') as converted:
            converted.write(j)
