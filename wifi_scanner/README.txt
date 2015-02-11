
******* HOW TO GET THE PACKAGE WORKING *******

1. run the script ./src/scripts/scan_wifi.sh . This creates four files: SSID,      Freq, Strength_dB.txt, and Channels.
2. In ./src/scan.cpp , provide the correct full path starting from /home/.. to     the files SSID, Freq, Strength_dB.txt, and Channels 
3. catkin_make to compile the wifi_scanner package
4. rosrun wifi_scanner scan_wifi
5. It post the SSID, Frequency, Strength, and Channel data on the topic /signals
