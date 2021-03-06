#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>
#include "ros/ros.h"
#include <wifi_scanner/wifi_signal_msg.h>

using namespace std;

int main(int argc, char **argv)
{

	ros::init(argc, argv, "wifi_talker");	

	ros::NodeHandle n;
	ros:: Publisher signal_pub = n.advertise<wifi_scanner::wifi_signal_msg>("signals", 1000);
	
	ros::Rate loop_rate(10);
	

	string St, Fr, C, SS;
	int valid;
	
	while (ros::ok())
	{
	
		wifi_scanner::wifi_signal_msg msg;
			
		valid = 0;
			
		int Sig_strength[20]; int count = 0;
		string Sig_SSID[20];
		int Sig_Freq[20]; 
		int Sig_Ch[20]; 
		// The paths needs to be absolute path beginning from /home/usename/...
		ifstream Strength_dB ("/home/brandhaw/Desktop/Strength_dB.txt");
		ifstream SSID ("/home/brandhaw/Desktop/SSID");
		ifstream Freq ("/home/brandhaw/Desktop/Freq");
		ifstream Ch ("/home/brandhaw/Desktop/Channels");
 		if (Strength_dB.is_open() && SSID.is_open() && Freq.is_open() && Ch.is_open())
  		{
		
    			while ( getline (Strength_dB,St) && getline (SSID,SS) && getline (Freq,Fr) && getline (Ch,C) )
    			{
      				Sig_strength[count] = atoi(St.c_str());
				if (Sig_strength[count] != 0) valid++;
				Sig_SSID[count] = SS.c_str();
				Sig_Freq[count] = atoi(Fr.c_str());
				Sig_Ch[count] = atoi(C.c_str());
			
				count++;
    			}
    			Strength_dB.close();
			SSID.close();
			Freq.close();
			Ch.close();
	
			Sig_strength[count]=1;

			/*msg.St = Sig_strength[1];
			msg.Fr = Sig_strength[2];
			msg.Ch = Sig_strength[3];
			*/
			
			int i=0;
			for (i; i<count; i++)
			{	
				msg.SSID[i] = Sig_SSID[i];
				msg.St[i] = Sig_strength[i];
				msg.Fr[i] = Sig_Freq[i];
				msg.Ch[i] = Sig_Ch[i];
			}			

			if (valid>0){	

				ROS_INFO("SSID:: %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n", msg.SSID[0].c_str(), msg.SSID[1].c_str(), msg.SSID[2].c_str(), msg.SSID[3].c_str(), msg.SSID[4].c_str(), msg.SSID[5].c_str(),msg.SSID[6].c_str(), msg.SSID[7].c_str(), msg.SSID[8].c_str(),msg.SSID[9].c_str(),msg.SSID[10].c_str());
			
			ROS_INFO("Frequency:: %d, %d,%d, %d, %d, %d,%d, %d, %d, %d, %d\n", msg.Fr[0], msg.Fr[1], msg.Fr[2], msg.Fr[3], msg.Fr[4], msg.Fr[5], msg.Fr[6], msg.Fr[7], msg.Fr[8], msg.Fr[9], msg.Fr[10]);

			ROS_INFO("Channel:: %d, %d,%d, %d, %d, %d,%d, %d, %d, %d, %d\n", msg.Ch[0], msg.Ch[1], msg.Ch[2], msg.Ch[3], msg.Ch[4], msg.Ch[5], msg.Ch[6], msg.Ch[7], msg.Ch[8], msg.Ch[9], msg.Ch[10]);

			ROS_INFO("Strength:: %d, %d,%d, %d, %d, %d,%d, %d, %d, %d, %d\n", msg.St[0], msg.St[1], msg.St[2], msg.St[3], msg.St[4], msg.St[5], msg.St[6], msg.St[7], msg.St[8], msg.St[9], msg.St[10]);
			
				signal_pub.publish(msg);
			}

			ros::spinOnce();

			loop_rate.sleep();
  		}

		
		
  		else cout << "Unable to open file"; 

		/*int i=0;
		for (i; i<count; i++)
		{
			cout << Sig_strength[i] << "\n";
		}*/
	
	}
	
	
	
  	return 0;
}
