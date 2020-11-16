#!/bin/bash

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export TOP_DIR=$SCRIPT_DIR/..
export RELEASE_DIR=$TOP_DIR/releases

adb reboot recovery

# Clear/Wipe all data/cache memories
# Choose "Apply Update"

cd $RELEASE_DIR
LATEST_REL_FILE=`ls -t lineage-17.1-* | head -1`
adb sideload $RELEASE_DIR/$LATEST_REL_FILE
cd $TOP_DIR




