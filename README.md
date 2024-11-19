# WiFi Network Switcher

**What does it do?**

This script automates the process of switching your device's WiFi network to a specified SSID for https://github.com/infinition/Bjorn project.

It's useful for scenarios where you want to connect to a different Wi-Fi network.

**Note:** project is under development. 

**How to use it:**

[chmod +x bjorn-out.sh]
[sudo ./bjorn-out.sh]

**Version 1.1**
**v1.1 - Enhanced Script (Basic Improvements)**

    Added Logging: All connection attempts and results were logged to /var/log/wifi_switcher.log for debugging purposes.
    Improved Error Handling:
        Exit with an error if the connection fails.
        More descriptive error messages to assist in troubleshooting.
    Cron Job Example: Provided commented-out lines to integrate with cron for automated reconnection.
    Cleaned Code Structure: Modularized logging for better readability and maintainability.

  **Advanced Diagnostics and Automation**

    Interface Validation:
        Checked if the specified interface (e.g., wlan0) exists and is managed by NetworkManager. Exits with an error if not found.
    SSID Availability Check: Verified whether the specified SSID is within range before attempting a connection.
    Cron Job Setup:
        Added an argument (--setup-cron) to automatically configure a cron job for reconnections.
        Prevented duplicate cron entries by filtering existing jobs before adding a new one.
    Custom Reconnection Interval:
        Allowed dynamic setting of reconnection intervals via the RECONNECT_INTERVAL variable (default: 20 minutes).
    Improved Logging:
        Added timestamps to logs for better traceability.
        Logged detailed error messages for invalid inputs or connection failures.
