#!/bin/bash

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo. Try 'sudo $0'"
    exit 1
fi

toBeAdded=" usbhid.quirks=0x16D0:0x0BCC:0x040"
if grep -Fq "$toBeAdded" /boot/cmdline.txt
then
    echo "USB HID quirk already present for GamepadBlock."
else
	sed -i " 1 s/.*/& $toBeAdded/" /boot/cmdline.txt
    echo "USB HID quirk for GamepadBlock added to /boot/cmdline.txt. You need to restart your system to take these changes into effect!"
fi

