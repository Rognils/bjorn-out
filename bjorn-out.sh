#!/bin/bash

#   script that will be connected to defferent WiFi networks, user will provide SSID password and interface
#   default values will be your phone "Personal Hotspot" credentials, ** you need to change them ***!
#   
# - version 1.1

#!/bin/bash

# Default values (update as needed)
DEFAULT_SSID="my_wifi"
DEFAULT_PASSWORD="my_password"
DEFAULT_INTERFACE="wlan0"
LOG_FILE="/var/log/wifi_switcher.log"

# Function: Log messages with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function: Check if interface is up
check_interface() {
    if ! nmcli device status | grep -q "$INTERFACE"; then
        log_message "Error: Interface $INTERFACE not found or not managed by NetworkManager."
        exit 1
    fi
}

# Function: Validate SSID
check_ssid() {
    if ! nmcli device wifi list | grep -q "$SSID"; then
        log_message "Error: SSID $SSID not found. Ensure the network is in range."
        exit 1
    fi
}

# Get user input with default values
read -p "Enter SSID (default: $DEFAULT_SSID): " user_ssid
read -p "Enter password (default: $DEFAULT_PASSWORD): " user_password
read -p "Enter interface (default: $DEFAULT_INTERFACE): " user_interface

# Assign default values if user input is empty
SSID=${user_ssid:-$DEFAULT_SSID}
PASSWORD=${user_password:-$DEFAULT_PASSWORD}
INTERFACE=${user_interface:-$DEFAULT_INTERFACE}

# Log the connection attempt
log_message "Attempting to connect to SSID: $SSID using interface: $INTERFACE"

# Check if interface is valid and up
check_interface

# Check if the SSID is available
check_ssid

# Connect to WiFi network
nmcli device wifi connect "$SSID" password "$PASSWORD" ifname "$INTERFACE" &>> "$LOG_FILE"

# Check connection status
sleep 0.5
if nmcli device status | grep -q "$INTERFACE.*connected"; then
    log_message "Successfully connected to WiFi network: $SSID"
else
    log_message "Failed to connect to WiFi network: $SSID. Check credentials and interface."
    exit 1
fi

# TODO: make it work with cron

# Cron setup for automated reconnection
RECONNECT_INTERVAL=20 # in minutes
if [[ $1 == "--setup-cron" ]]; then
    CRON_JOB="*/$RECONNECT_INTERVAL * * * * /path/to/wifi_switcher.sh"
    log_message "Setting up cron job for reconnecting every $RECONNECT_INTERVAL minutes..."
    (crontab -l 2>/dev/null | grep -v '/path/to/wifi_switcher.sh'; echo "$CRON_JOB") | crontab -
    log_message "Cron job set successfully."
    exit 0
fi

log_message "Script execution completed."

