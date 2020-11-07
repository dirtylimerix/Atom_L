#!/bin/bash

export TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export BUILD_DIR=$TOP_DIR/build
export LINEAGE_DIR=$BUILD_DIR/android/lineage
export TARGET_DIR=$LINEAGE_DIR/out/target/product/Atom_L

cd $LINEAGE_DIR
repo sync --force-sync
mv device/Unihertz/Atom_L/device_tree/* device/Unihertz/Atom_L
source build/envsetup.sh
breakfast Atom_L
ccache -M 50G
croot
brunch Atom_L
cd $TOP_DIR

cd $TARGET_DIR
DATEVAL=`ls lineage-17.1-*-UNOFFICIAL-Atom_L.zip | awk -F '[-.]' '{print $4}'`
cd $TOP_DIR

mkdir $TOP_DIR/releases/$DATEVAL
cp $LINEAGE_DIR/out/target/product/Atom_L/lineage-17.1-$DATEVAL-UNOFFICIAL-Atom_L.zip $TOP_DIR/$DATEVAL/releases
cp $LINEAGE_DIR/out/target/product/Atom_L/lineage-17.1-$DATEVAL-UNOFFICIAL-Atom_L.zip.md5sum $TOP_DIR/$DATEVAL/releases
cp $LINEAGE_DIR/out/target/product/Atom_L/recovery.img $TOP_DIR/releases/$DATEVAL/lineage-17.1-$DATEVAL-recovery.img

