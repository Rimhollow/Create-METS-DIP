#!/bin/bash
set -e

# Find the name of the incoming zip file, based on the incoming path.
# e.g. if the incoming path is /foo/bar, zipName = /foo/bar/bar.zip
zipName = $1/`basename $1`.zip

# Get the name of the bag we're about to uncompress.
bagName = $1/`basename $1`

# Unzip and delete the zip file and pass the bag to createMETSDIP.rb.
unzip zipName
delete zipName
ruby createMETSDIP.rb bagName

#!/bin/bash

#source /etc/archivematica/archivematicaConfig.conf
set -e
DIRNAME="`dirname "$1"`"
sudo chown -R archivematica:archivematica "$1"
sudo chmod 777 -R "$1"
exitCode=0
#for a in `ls "${1}"*.zip`; do
find "${1}" -name "*.zip" -printf "%f:%h\n" | while IFS=":" read a PATH
do
	extractedDirectory="${DIRNAME}"
	echo Extracting to: "$extractedDirectory" 1>&2
	#/bin/mkdir "$extractedDirectory"
	/usr/bin/7z x -bd -o"${extractedDirectory}" "${1}${a}"
	exitCode=$(($exitCode + $? ))
	/usr/bin/sudo /bin/chown -R archivematica:archivematica "${extractedDirectory}"
	/usr/bin/sudo /bin/chmod -R 770 "${extractedDirectory}"
	/usr/bin/sudo /bin/chmod 777 "${1}${a}"
	/bin/rm "${1}${a}" 
done
/bin/rm "${1}" -r 
exit $exitCode

