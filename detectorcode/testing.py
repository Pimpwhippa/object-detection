
import sys
import glob
import errno

path = '/darknet/testsnake/*.txt'   
files = glob.glob(path)   
for name in files: # 'file' is a builtin type, 'name' is a less-ambiguous variable name.
    try:
        with open(name) as f: # No need to specify 'r': this is the default.
            sys.stdout.write(f.read())
    except IOError as exc:
        if exc.errno != errno.EISDIR: # Do not fail if a directory is found, just ignore it.
            raise


#filename = "testsnake/Checkered-keelback_004.jpg_output.txt"
#with open(filename) as f:
#       content = f.readlines()
#       for line in content:
#               print(line)



