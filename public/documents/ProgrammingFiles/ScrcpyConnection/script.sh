#!/bin/bash

# Prompt the user for the connection type.
echo "Select connection type:"
echo "1) USB"
echo "2) Wireless"
echo "3) Both"
read -p "Enter option (number or text): " option

# Normalize the input to lowercase.
option=$(echo "$option" | tr '[:upper:]' '[:lower:]')

case "$option" in
    1|usb)
       mode="usb"
       ;;
    2|wireless)
       mode="wireless"
       ;;
    3|both)
       mode="both"
       ;;
    *)
       echo "Invalid option."
       exit 1
       ;;
esac

# Retrieve list of connected devices in the 'device' state.
DEVICES=$(adb devices | tail -n +2 | awk '/device$/ {print $1}')

# Filter devices based on the selected mode.
case "$mode" in
  usb)
    FILTERED=$(echo "$DEVICES" | grep -v ':')
    ;;
  wireless)
    FILTERED=$(echo "$DEVICES" | grep ':')
    ;;
  both)
    FILTERED="$DEVICES"
    ;;
esac

# If no devices are found, exit.
if [ -z "$FILTERED" ]; then
    echo "No devices found for mode '$mode'."
    exit 1
fi

# If multiple devices are found, let the user choose one.
DEVICE_COUNT=$(echo "$FILTERED" | wc -l)
if [ "$DEVICE_COUNT" -gt 1 ]; then
    echo "Multiple devices found:"
    i=1
    for device in $FILTERED; do
        echo "  $i) $device"
        i=$((i+1))
    done

    read -p "Select device number: " choice
    DEVICE=$(echo "$FILTERED" | sed -n "${choice}p")
    if [ -z "$DEVICE" ]; then
        echo "Invalid selection."
        exit 1
    fi
else
    DEVICE="$FILTERED"
fi

echo "Using device: $DEVICE"

# Prompt the user to select the display mode.
echo "Select display mode:"
echo "1) Fullscreen"
echo "2) Windowed"
read -p "Enter option (number or text): " display_option

# Normalize display option.
display_option=$(echo "$display_option" | tr '[:upper:]' '[:lower:]')

# Determine scrcpy display flag based on the user's choice.
case "$display_option" in
    1|fullscreen)
        display_flag="--fullscreen"
        ;;
    2|windowed)
        display_flag=""
        ;;
    *)
        echo "Invalid display option. Defaulting to windowed mode."
        display_flag=""
        ;;
esac

# Run scrcpy with the selected device and options.
scrcpy -s "$DEVICE" --gamepad=uhid --max-size 0 --video-bit-rate 12M --max-fps 60 $display_flag
