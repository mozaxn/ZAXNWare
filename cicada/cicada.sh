#!/bin/bash

####################
# ZAXNWare Cicada  #
####################
# Author: ZAXN
# Created on: 01/11/2025
# Last updated on: 01/11/2025

# Given a file containing a list of apt packages, Cicada creates a shell script which can be deployed anywhere
# to donwload the packages.
# This prevents writing multiple lines of code especially when switching devices.

####################

# Version Declaration
VERSION="1.0.0"
VERSION_STAMP="ZAXNWare Cicada version $VERSION"

# If no argument is passed, print the version.

if [[ "$#" == 0 ]]; then
	echo $VERSION_STAMP
	exit
fi

# Parse options.
while getopts "np:s:" opt; do

	case $opt in
		n) no_update=true ;;
		p) pkg_file="$OPTARG" ;;
		s) installer_name="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
	esac
done

# Check if the file exists or is it even a file
if [[ ! -f "$pkg_file" ]]; then
	echo "The package file: '$pkg_file' is either not a file or does not exist." >&2
	exit 1
fi

# Create the installer file.

echo -e "#!/bin/bash" > "$installer_name.sh"

if [[ ! "$no_update" == true ]]; then
	echo "sudo apt update" > "$installer_name.sh"
fi

# Add a command for every package in the installer.

for i in $(cat "$pkg_file"); do
	echo "sudo apt install $i" >> "$installer_name.sh"
done

# Give executable permissions to the installer.
chmod +x "$installer_name.sh"

echo "$installer_name.sh has been created successfully!"
exit
