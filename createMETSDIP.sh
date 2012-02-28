#!/bin/bash
set -e

echo "***** Create METS DIP shell script"
echo "pwd:"
pwd

# Incoming parameters:
# $1 relative location (working path)
# $2 path to client scripts directory
# $3 path to Solrize watch directory

# Get the path of the zip file we're dealing with, 
# and of the bag we're about to extract.
# e.g. if the incoming path is /foo/bar/baz, the package is baz.
ZIPNAME=$1/`basename $1`.zip
BAGNAME=$1/`basename $1`

# Unzip the zip file, pass the extracted bag to createMETSDIP.rb,
# and move the created METS DIP into the Solrize watch dir.
unzip $ZIPNAME -d $1
ruby $2/createMETSDIP.rb $BAGNAME
mv $BAGNAME $3
