#!/bin/bash
set -e

# Get the path of the zip file we're dealing with.
# e.g. if the incoming path is /foo/bar/baz, the package is baz.
ZIPNAME=$1/`basename $1`.zip

# Everything in the zip is contained in a subdir with the same name as the
# package; unzipping to the parent directory ensures that the contants don't
# end up in a redundant subdirectory.
ZIPTARGET=$1/..

# Unzip and delete the zip file and pass the extracted bag to createMETSDIP.rb.
unzip $ZIPNAME -d $ZIPTARGET
rm $ZIPNAME
ruby createMETSDIP.rb $1
