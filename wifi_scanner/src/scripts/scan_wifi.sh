# script to run the script.sh file certain times/sec

count=0
while [ $count -le 5 ]
do
	echo "" > SSID
	echo "" > Freq
	echo "" > Strength
	echo "" > Channels
	echo "" > Strength_dB.txt
	./script.sh
	sleep 0.1	
	word=$((word+1))
done
