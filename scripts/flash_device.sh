#!/bin/bash

echo "WARNING!!!
You are solely responsible for what you do with this script and the files included with it.
I hold no responsibility and make no guarantees about how this may affect your devices.
WARNING!!!

"

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export TOP_DIR=$SCRIPT_DIR/..
export RELEASE_DIR=$TOP_DIR/releases

idx=0
for dir in $RELEASE_DIR/*/;
do
  RELEASES[$idx]=$dir;
  (( idx++ ));
done
#printf '%s\n' "${RELEASES[@]}"

echo "

Which of the following releases would you like to flash to the device?

"
idx=0
for rel in "${RELEASES[@]}"
do
  echo "$idx ) $rel";
  (( idx++ ));
done

read -p "> " RELSEL

RELSEL_DIR=${RELEASES[$RELSEL]}
RELDATE=`basename $RELSEL_DIR`

echo "
==============================
          UNLOCKING
==============================


Please unlock your device according to the process outlined below. This only needs to be done once.

1. Boot your Atom L to the official OS
2. Go into Settings - About phone, tap \"build number\" several times to enable developer settings
3. Go to Settings - System - Developer Settings, enable OEM unlocking and ADB debugging
4. Run <adb reboot bootloader> on your PC (there is no way to enter bootloader directly, only possible through adb)
5. Run <adb flashing unlock> and comfirm unlock on device (THIS WILL WIPE ALL DATA)
6. Reboot and now you should see an unlocked warning during boot screen.

"

read -p "When done, hit ENTER..." dummyvar

echo "
==============================
INSTALLING LINEAGE OS RECOVERY
==============================

For now the only working recovery is the LineageOS Recovery, because the device's kernel does not load the touch driver in recovery mode for whatever reason, rendering TWRP useless.

Before starting, do the following:
1. Connect your device via USB
2. Ensure you can connect to your device via <adb> and <fastboot>

"

read -p "When done, hit ENTER..." dummyvar


echo "

> Unpacking vbmeta.zip ...
"
unzip vbmeta.zip

echo "
> Run <adb reboot bootloader> to put your device in bootloader mode

"
adb reboot bootloader

read -p "When the device has started up in the bootloader, hit ENTER..." dummyvar

echo "

> Run <fastboot flash --disable-verification --disable-verity vbmeta vbmeta.img>
"
fastboot flash --disable-verification --disable-verity vbmeta vbmeta.img

echo "

> Run <fastboot flash --disable-verification --disable-verity vbmeta_system vbmeta_system.img>
"
fastboot flash --disable-verification --disable-verity vbmeta_system vbmeta_system.img

echo "

> Run <fastboot flash --disable-verification --disable-verity vbmeta_vendor vbmeta_vendor.img>
"
fastboot flash --disable-verification --disable-verity vbmeta_vendor vbmeta_vendor.img

echo "

> Run <fastboot flash recovery lineage_recovery_XXX.img>
"
fastboot flash recovery $RELSEL_DIR/lineage-17.1-$RELDATE-recovery.img

echo "

> Running <fastboot reboot> to reboot
"
fastboot reboot

echo "

> Wait for the device to reboot.
"
read -p "When done, hit ENTER..." dummyvar

echo "

> Running <adb reboot recovery> to reboot into the newly-installed LineageOS Recovery
"
adb reboot recovery

echo "
==============================
     INSTALL LINEAGE OS
==============================

The LineageOS Recovery is operated by volume keys as selection and power as confirmation (or entering sub-menus). To return to upper levels of menus from sub-menus, press volume up until the selection goes to the first item and then disappears, then press power (i.e. there's a hidden "Go Back" item at the very top of each sub-menu).

The recovery will show a verification failed prompt for most packages that are not signed with the AOSP keys. This is safe to ignore.

Installing LineageOS 17.1

The LineageOS image must be installed via LineageOS recovery.

> Wipe all data (factory reset) (THIS DELETES EVEN INTERNAL STORAGE)

"
read -p "When done, hit ENTER..." dummyvar

echo "

> Choose Apply Update, then Apply Update from ADB
"
read -p "When done, hit ENTER..." dummyvar

echo "

> Run <adb sideload lineage-17.1-20201031-UNOFFICIAL-Atom_L.zip> from your PC
"
adb sideload $RELSEL_DIR/lineage-17.1-$RELDATE-UNOFFICIAL-Atom_L.zip

echo "
Wait for the process to finish. (The recovery might prompt something about verification failure, just ignore
it and continue anyway)

At this point, you can then sideload the LATEST Magisk and OpenGAPPS Nano at your will (note that the size of
the system partition might only be enough for the <nano> variant of OpenGAPPS)
(If installing Magisk / OpenGAPPS fails, you can try rebooting into recovery again in advanced menus,
then try installing them again)

Reboot into system and enjoy (Note that Magisk might cause your device to boot loop once or two but it will eventually boot)
"

rm vbmeta.img
rm vbmeta_vendor.img
rm vbmeta_system.img

