#!/usr/bin/env python3
# Simple script to detect potential duplicates in large unsorted image folders.
# Eventually will include recursion.

# TODO: Add recursion support
# TODO: Add support to examine file data.

# import required libraries
import hashlib                              # For checksums
from os import listdir                      # To list directory contents
from os.path import isfile, isdir, join     # To determine files vs directories, and join paths
from collections import Counter             # To keep track of unique names

# constant variable: blocksize is 65536
BLOCKSIZE = 65536

# Enumerate files in directory. Working directory should be wherever the script was invoked from.
# Include flag for recursion.
# Recursion not working, figure out why.
checksums = {}
#dirlist = ['.'] # Add something to dirlist so it's not empty.
#while len(dirlist) != 0:
filelist = [f for f in listdir('.') if isfile(join('.', f))]
    #dirlist = [f for f in listdir('.') if isdir(join('.',f))]

# Take each file in the directory
for f in filelist:
    # Generate the checksum for the file.
    hasher = hashlib.sha256()
    with open(f,"rb") as afile:
        buf = afile.read(BLOCKSIZE)
        while len(buf) > 0:
            hasher.update(buf)
            buf = afile.read(BLOCKSIZE)
    # Store the checksum
    filehash = hasher.hexdigest()
    if filehash not in checksums:
        checksums[filehash] = []
    checksums[filehash].append(f)
# Print all sets of exact duplicate files
for csum in checksums:
    if len(checksums[csum]) > 1:
        print("Duplicates!",checksums[csum])

# Next, enumerate all filenames, chop off extensions, find duplicates.
# Need a case for .jpg, jpg large.jpg, .jpeg, .png, .webp, .mp4
# Focus on the non-three-letter extensions/headers. Should work best.
baselist = []
for f in filelist:
    if f.endswith(".jpg large.jpg"):
        baselist.append(f[0:-14])
    elif f.endswith("-sample.jpg"):
        baselist.append(f[0:-11])
    elif f.endswith(".jpeg") or f.endswith(".webp") or f.endswith(".webm"):
        baselist.append(f[0:-5])
    elif f.startswith("sample-") or f.startswith("sample_"):
        if f.endswith(".jpg large.jpg"):
            baselist.append(f[7:-14])
        elif f.endswith(".jpeg") or f.endswith(".webp") or f.endswith(".webm"):
            baselist.append(f[7:-5])
        else:
            baselist.append(f[7:-4])
    else:
        baselist.append(f[0:-4])
# Get the files that occur more than once.
cnt = Counter(baselist)
multiples = [k for k, v in cnt.items() if v > 1]

# Use the multiples list to point out potential duplicates in the original set.
print("Potential duplicates!")
print(multiples)