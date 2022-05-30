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
		-i) address=$2;;
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
		while [ $initial -ne $finish ]; do
			$(ping -c 1 $address$initial >> /dev/null)
			if [ $? -eq 0 ]
			then
				echo "$address$initial is active!"
			fi

			initial=$((initial+1))
		done
	else
		echo "scanning that shit in 254 hosts"
	fi
fi
