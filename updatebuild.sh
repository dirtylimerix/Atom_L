#!/bin/bash

export TOP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export BUILD_DIR=$TOP_DIR/build
export LINEAGE_DIR=$BUILD_DIR/android/lineage

cd $LINEAGE_DIR
repo sync --force-sync
mv device/Unihertz/Atom_L/device_tree/* device/Unihertz/Atom_L
source build/envsetup.sh
breakfast Atom_L
ccache -M 50G
croot
brunch Atom_L
cp $LINEAGE_DIR/out/target/product/Atom_L/lineage-17.1-*.zip $TOP_DIR/releases
cd $TOP_DIR

