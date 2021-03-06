#!/bin/env python3
'''Parse through a list of files, and expand any dependencies for executables.

   Currently, this only expands dependencies for standard ELF binaries
   that are parseable by the system copy of ldd. '''
from subprocess import check_output, CalledProcessError
from glob import glob
import os
import argparse
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('files', nargs='+', help='A list of files')
files = parser.parse_args().files
i = 0
while i < len(files):
    i += 1
    if files[i - 1] == '':
        continue
    if os.path.isdir(files[i - 1]) and os.access(files[i - 1], os.R_OK | os.X_OK):
        for item in glob(os.path.join(files[i - 1], '*')):
            files.append(item)
    elif os.path.isfile(files[i - 1]) and os.access(files[i - 1], os.R_OK):
        while files.count(files[i - 1]) > 1:
            del files[files.index(files[i - 1], i)]
        if os.access(files[i - 1], os.X_OK):
            try:
                ldddeps = check_output(['ldd', files[i - 1]], universal_newlines=True)
            except CalledProcessError:
                continue
            ldddeps = ldddeps.splitlines()
            for line in ldddeps:
                dep = line.lstrip().split('=>')
                if len(dep) < 2:
                    continue
                deppath = dep[1].lstrip().split()[0]
                if os.access(deppath, os.R_OK) and not (deppath in files):
                    files.append(deppath)
    else:
        files[i - 1] = ''
while files.count('') > 0:
    files.remove('')
for i in files:
    print(i)
