#!/bin/bash

clear
echo "Please connect your phone to start debloating"
adb wait-for-device
clear
wget -q https://github.com/rickastlee/ShapeShiftOS/raw/refs/heads/main/debloater/apps.txt && echo -e "Successfully downloaded the list of apps to debloat\n" || (echo "Error while downloading the list of apps to debloat" && exit 1)
while IFS= read -r app; do
	name=${app%%:*}
	package_name=${app#*:}
	adb shell pm clear "$package_name" </dev/null > /dev/null 2>&1 && echo Successfully cleared app data for "$name" || echo Failed to clear app data for "$name"
	adb shell pm disable-user --user 0 "$package_name" </dev/null > /dev/null 2>&1 && echo Successfully disabled "$name" || echo Failed to disable "$name"
	echo ""
done < apps.txt
rm apps.txt
