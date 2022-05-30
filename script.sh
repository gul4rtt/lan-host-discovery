#!/usr/bin/env bash

index=0
address=0
range=0
version="1.0"
help="this script is a simple host discovery with ping sweep"

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
