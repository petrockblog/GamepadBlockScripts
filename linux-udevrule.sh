#!/bin/bash

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo. Try 'sudo $0'"
    exit 1
fi


echo "ATTRS{idVendor}==\"16d0\" ATTRS{idProduct}==\"0bcc\", ENV{ID_MM_DEVICE_IGNORE}="1"" > /etc/udev/rules.d/99-ttyacms.rules
echo "Created new udev rule /etc/udev/rules.d/99-ttyacms.rules"

udevadm control --reload-rules
echo "Reloaded udev rules"
echo "Finished successfully."
