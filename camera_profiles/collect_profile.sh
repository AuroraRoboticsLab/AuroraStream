#!/bin/sh
# Collect a camera profile
name="$1"
device="$2"

log() {
	echo "\n$@" || exit 1
	"$@" || exit 1
}

mkdir "$name" || exit

cd "$name"
echo "Profile for $name as device $device" | tee NOTES.txt || exit 1
log v4l2-ctl --list-formats -d "$device"  | tee -a NOTES.txt
log ffmpeg -f video4linux2 -list_formats all -i "$device" 2>&1 | grep "v4l2"  | tee -a NOTES.txt
log v4l2-ctl --list-formats-ext -d "$device"  | tee -a NOTES.txt
 
