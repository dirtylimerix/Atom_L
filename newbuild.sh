#!/bin/bash

# Run with "sudo -u username command" ??


export TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export BUILD_DIR=$TOP_DIR/build
export LINEAGE_DIR=$BUILD_DIR/android/lineage
export LOCAL_MANIFEST_DIR=$LINEAGE_DIR/.repo/local_manifests
export VENDOR_DIR=$BUILD_DIR/unihertz

source $TOP_DIR/profile.sh

mkdir -p $BUILD_DIR

mkdir -p $LINEAGE_DIR
cd $LINEAGE_DIR
repo init -u https://github.com/LineageOS/android.git -b lineage-17.1
repo sync
cd $TOP_DIR

mkdir -p $LOCAL_MANIFEST_DIR
cp roomservice.xml $LOCAL_MANIFEST_DIR

cd $LINEAGE_DIR
repo sync --force-sync
mv device/Unihertz/Atom_L/device_tree/* device/Unihertz/Atom_L
cd $TOP_DIR

mkdir -p $VENDOR_DIR
cp latest_ROM.zip $VENDOR_DIR
cd $VENDOR_DIR
unzip latest_ROM.zip -d latest_ROM
imjtool latest_ROM/2020*/super.img extract
imjtool extracted/image.img extract
cd extracted
mkdir -p system
sudo mount -o loop system.img system/
sudo mount -o loop system.img system/vendor/
$LINEAGE_DIR/device/Unihertz/Atom_L/extract-files.sh .
sudo umount system/vendor
sudo umount system
cd $TOP_DIR

