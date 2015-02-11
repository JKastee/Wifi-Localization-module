#1/bin/bash
echo "Hello World"

	
	LSL=$(nm-tool | grep "Freq.*Strength")
	declare -a MYRA
	MYRA=($LSL)

	echo $LSL
	echo we have ${#MYRA[*]} elements.

	declare -a CH
	CH=($(iwlist wlan0 channel))

	CH_num=${#CH[*]} 
	

	echo the 60th element is ${MYRA[61]} .
	
	mult=1000.0
	CH_base=11
	CH_off=5

	ZERO=0

	get_channel()
	{	
		cnt=$CH_base	
		Channel=1	
		while [ $cnt -le $(($CH_num-7)) ]
		do
			freq_GHz=${CH[$cnt]}
			#echo $freq_GHz

			freq_Mhz=`echo $freq_GHz \* $mult | bc`
			freq_Mhz=`echo ${freq_Mhz%%.*}`
			#echo frequency is $freq_Mhz Mhz.

			if [ $freq_Mhz -eq $1 ] # ${MYRA[4]} ]
			then
				echo $Channel >> Channels		
				break		
				#echo ${MYRA[0]} ${MYRA[4]} ${MYRA[10]} "Ch 1" > test
			else
				cnt=$((cnt+5))
				Channel=$((Channel+1))
			fi
		done	
	}

	
	dB()
	{
		## Quality to dBm:
    		#if(quality <= 0)
        	#dBm = -100;
    		#else if(quality >= 100)
        	#dBm = -50;
    		#else
        	#dBm = (quality / 2) - 100;
		TWO=2	
		if [ $1 -le 0 ]
		then 
			echo "-100 dB" >> Strength_dB.txt
		elif [ $1 -ge 100 ]
		then
			echo "-500 dB" >> Strength_dB.txt
		else
			div=$(($1/2))
			echo $((div-100)) "dB" >> Strength_dB.txt
		fi
	}	



	#LIST_OFF=10
	ENC_1_OFF=11
	ENC_2_OFF=12
	ENC_1="WPA"
	ENC_2="WPA2"
	ENC_3="WEP"
	ENC_4="Enterprise"

	SSID_EXC="MASON-RESNET"

	NUM=${#MYRA[*]}	
	word=$ENC_1_OFF
	count=0	

	flag=0	

	while [ $word -le $((NUM-1)) ]
	do
		echo $word
		ENC=${MYRA[word]}
		echo $ENC
				
		if [ $flag -eq 1 ]
		then 
			echo ${MYRA[$((word-12))]} ${MYRA[$((word-11))]} >> SSID
		else
			echo ${MYRA[$((word-11))]} >> SSID
		fi
		echo ${MYRA[$((word-7))]} >> Freq
		# make a func to convert the percentage to dB
		Quality=${MYRA[$((word-1))]}		
		dB $Quality 
		echo $Quality >> Strength
		# make a func to get the channel knowing ${MYRA[$((word-7))]}
		frequency=${MYRA[$((word-7))]}
		get_channel $frequency

		flag=0

		if [ "$ENC" = "$ENC_1" -o "$ENC" = "$ENC_2" -o "$ENC" = "$ENC_3" ]
		then
			word=$((word+1))
			ENC=${MYRA[word]}
			if [ "$ENC" = "$ENC_1" -o "$ENC" = "$ENC_2" -o "$ENC" = "$ENC_3" -o "$ENC" = "$ENC_4" ]
			then	
				word=$((word+ENC_2_OFF))
			elif [ "$ENC" = "$SSID_EXC" ] 
			then 
				word=$((word+ENC_2_OFF))
				flag=1
			else
				word=$((word+ENC_1_OFF))
			fi
		elif [ "$ENC" = "$SSID_EXC" ]
		then 
			word=$((word+ENC_2_OFF))
			flag=1		
		else
			word=$((word+ENC_1_OFF))
		fi
		
		
		
		#echo ${MYRA[$word]}
		#echo $word		
		#word=$((word+1))
			
	done
	
	echo ${MYRA[60]}
	echo ${MYRA[62]}	    

	


	echo the file $1 is ${MYRA[4]} bytes.
	echo the last element is ${MYRA[0]}	

