#!/bin/bash

####################
# ZAXNWare Counter #
####################
# Author: ZAXN
# Created on: 21/10/2025
# Updated on: 21/10/2025


# ZWC is a command-line utility which prints various information regarding a file.
# * Line count
# * File size
# * Word count

####################
####################

# Version declaration
VERSION="1.4.0"
VERSION_STAMP="ZAXNWare Counter (ZWC) version $VERSION"

# If no argument is passed, return the version
if [[ $# == 0 ]]; then
	echo $VERSION_STAMP
	exit 0
fi

# Parse the flags passed.
while getopts "avwlbf:" opt; do
	
	case $opt in
		a) words=true; lines=true; bytes=true ;;
		v) echo $VERSION_STAMP; exit 0 ;;
		w) words=true ;;
		l) lines=true ;;
		b) bytes=true ;;
		f) filename="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
	esac
done

# Check if the file exists.

if [[ ! -e "$filename" ]]; then
	echo "File '$filename' does not exist!"
	exit 1
fi

# Check if the file passed is in fact a directory.

if [[ -d "$filename" ]]; then
	echo "'$filename' is a directory; not a file!" >&2
	exit 1
fi

# If no flag has been mentioned, use WORDS by default.

if [[ -z $words && -z $lines && -z $bytes ]]; then
	words=true
fi

# Check if one or more flags have been passed and pass the output accordingly.

if [[ -f "$filename" && ( $words || "$#" == 1 )  ]]; then
	echo "WORDS:$( wc -w < "$filename" )"
fi

if [[ -f "$filename" && $lines ]]; then
	echo "LINES:$( wc -l < "$filename" )"
fi

if [[ -f "$filename" && $bytes ]]; then
	echo "BYTES:$( wc -c < "$filename" )"
fi

exit
