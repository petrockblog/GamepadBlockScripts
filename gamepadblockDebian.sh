#!/bin/bash

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo. Try 'sudo $0'"
    exit 1
fi

targetfile="/etc/modprobe.d/usbhid.conf"

# ensure that /etc/modprobe.d/usbhid.conf exists
if [[ ! -f $targetfile ]]; then
	touch $targetfile
fi

# ensure that the HID quirk for the GamepadBlock are set
toBeAdded=" usbhid.quirks=0x16D0:0x0BCC:0x040"
if grep -Fq "# GamepadBlock" $targetfile
then
    echo "USB HID quirk already present for GamepadBlock."
else
	echo -e "# GamepadBlock\noptions usbhid quirks=0x16D0:0x0BCC:0x040" >> $targetfile
	rmmod usbhid     # unload usbhid module
	modprobe usbhid  # reload usbhid module
    echo "USB HID quirk for GamepadBlock added to $targetfile"
fi
