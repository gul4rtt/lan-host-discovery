#!/usr/bin/env bash

initial=0
finish=0
index=0
address=0
range=0
version="1.0"
regex_netid="\b([0-9]{1,3}\.){3}$"
regex_range="[0-9]-[0-9]"
help="this script is a simple host discovery with ping sweep"

ping_sweep(){
	$(ping -c 1 $1$2 >> /dev/null)
	if [ $? -eq 0 ]
	then
		echo "$1$2 is active!"
	else
		echo "$1$2 is not active!"
	fi
}

ip_is_valid(){
	if [[ $1 =~ $regex_netid ]]
	then
		 return 0
	elif [ $1 -eq 0 ]
	then
		 echo $help && exit 0	
	else
		 return 1
	fi
}

range_is_valid(){
	if [[ $1 =~ $regex_range ]]
	then
		return 0
	else
		return 1
	fi
}

while test -n "$1"
do
	case "$1" in 
		-h) echo $help && exit 0;;
		-v) echo $version && exit 0;;
		-ni) address=$2;;
	    -r) range=$2;;
	esac
shift
done

ip_is_valid $address
if [[ $? -eq 1 ]]
then
	echo "u entered an incorrect network id, to fix check this example: 192.168.1."
else
	range_is_valid $range
	if [[ $? -eq 0 ]]
	then
		initial=$(echo $range | cut -f1 -d"-")
		finish=$(echo $range | cut -f2 -d"-")
		echo starting in $initial
		echo ending in $finish
		while [ $initial -le $finish ]; do
			ping_sweep $address $initial	
			initial=$((initial+1))
		done
	else
		initial=1
		echo starting in $initial
		echo ending ing 254
		while [ $initial -le 254 ]; do
			ping_sweep $address $initial
			initial=$((initial+1))
		done
	fi
fi
