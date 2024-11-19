#!/bin/bash

#   script that will be connected to defferent WiFi networks, user will provide SSID password and interface
#   default values will be your phone "Personal Hotspot" credentials, ** you need to change them ***!
#   
#

# Set default values
SSID="my_wifi"
PASSWORD="my_password"
INTERFACE="wlan0"

# Get user input
read -p "Enter SSID (default: $SSID): " user_ssid
read -p "Enter password (default: $PASSWORD): " user_password
read -p "Enter interface (default: $INTERFACE): " user_interface

# Use default values if user input is empty
SSID=${user_ssid:-$SSID}
PASSWORD=${user_password:-$PASSWORD}
INTERFACE=${user_interface:-$INTERFACE}

# Connect to WiFi network using nmcli
nmcli device wifi connect "$SSID" password "$PASSWORD" ifname "$INTERFACE"

# Check if connected

sleep 0.5
if nmcli device status | grep -q "connected"; then
    echo "Connected to WiFi network: $SSID"
else
    echo "Connection failed"
fi

# TODO: make it work with cron

#       it will be like dog on the walk.
#
#       from your phone/pc you send it to target network and after 20 min (or how long you need) it will reconnect to your phone/pc network
#

# * * * * *
# | | | | |
# | | | | | 
# | | | | ---- Day of the Week (0 - 7) (Sunday to Saturday, Sunday = 0 and 7)
# | | | ------ Month (1 - 12)
# | | -------- Day of the Month (1 - 31)
# | ---------- Hour (0 - 23)
# ------------- Minute (0 - 59)

