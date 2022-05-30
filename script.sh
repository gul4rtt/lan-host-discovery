#!/usr/bin/env bash

index=0
address=0
range=0
version="1.0"
regex="\b([0-9]{1,3}\.){3}$"
help="this script is a simple host discovery with ping sweep"

ip_is_valid(){
	if [[ $1 =~ $regex ]]
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
		-i) address=$2 && echo $address;;
	    -r) range=$2 && echo $range;;
	esac
shift
done

ip_is_valid $address
if [[ $? -eq 1 ]]
then
	echo "u entered an incorrect network id, to fix check this example: 192.168.1."
else
	echo "scanning that shit"
fi
