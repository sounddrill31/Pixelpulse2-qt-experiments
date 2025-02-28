#!/bin/bash
set -e

# Check for udev existence
if command -v udevadm &>/dev/null; then
    # Check if rule file exists
    if [[ -f "/etc/udev/rules.d/53-adi-m1k-usb.rules" ]]; then
        echo "udev is installed and udev rule found, skipping Rule Creation"
    else
        # Create udev rule file
        echo "Displaying New udev Rule"
        echo -e "# allow \"plugdev\" group read/write access to ADALM1000 devices\nSUBSYSTEM==\"usb\", ATTRS{idVendor}==\"064b\", ATTRS{idProduct}==\"784c\", MODE=\"0664\", GROUP=\"plugdev\", TAG+=\"uaccess\"\n# allow \"plugdev\" group read/write access to ADALM1000 devices in SAM-BA mode\nSUBSYSTEM==\"usb\", ATTRS{idVendor}==\"03eb\", ATTRS{idProduct}==\"6124\", MODE=\"0664\", GROUP=\"plugdev\", TAG+=\"uaccess\"" | sudo tee /etc/udev/rules.d/53-adi-m1k-usb.rules       
        echo "Udev rules successfully created"
    fi
else
    echo "udev not found on the system... Skipping Rule Creation"
fi

# Continue with application execution
./pixelpulse2
