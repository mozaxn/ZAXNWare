#!/bin/bash

####################
# ZAXNWare CPUMon  #
####################
# Author: ZAXN
# Created on: 21/10/2025
# Last updated on: 21/10/2025

# CPUMon (CPU  Monitor) is a utility which notifies when CPU usage exceeds a certain limit.
# CPUMon  runs in the background.
# The CPU usage limit can be modified by the user.

####################

# Version Declaration
VERSION="1.2.0"
VERSION_STAMP="ZAXNWare CPUMon version $VERSION"

# If no argument is passed, print the version.

if [[ "$#" == 0 ]]; then
	echo $VERSION_STAMP
	exit
fi

# Parse options.
while getopts "tni:u:" opt; do

	case $opt in
		t) disp_terminal=true ;;
		n) notification=true ;;
		i) interval="$OPTARG" ;;
		u) limit="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
	esac
done

# If no limit is specified, default to 80%
if [[ -z "$limit" ]]; then
	limit=80
fi

# If no interval is specified, default to 10 seconds.
if [[ -z "$interval" ]]; then
	interval=10
fi

# Check if the entered limit is within bounds.
if [[ $limit -gt 100 || $limit -lt 0 ]]; then
	echo "Error: The entered CPU usage limit is out of bounds!" >^2
	exit 1
fi

# Start monitoring
while true; do
	# Read the average CPU usage every 2 seconds.
	idle=$( mpstat $interval 1 | awk 'END { print $12 }' )
	usage=$( echo "100 - $idle" | bc )
	
	if (( $(echo "$usage > $limit" | bc -l) )); then
		
		if [[ $notification == true ]]; then
			notify-send "CPUMon: High CPU usage of $usage%"
		fi

		if [[ $disp_terminal == true ]]; then
			echo "CPUMon: High CPU usage of $usage%"
		fi
	fi
done
exit
