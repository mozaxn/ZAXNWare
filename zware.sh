#!/bin/bash

######################
# ZAXNWare Installer #
######################
# Author: ZAXN
# Created on: 23/10/2025
# Last updated on: 23/10/2025

# ZAXNWare Installer (zware) is a lightweight package installer for ZAXNWare utilities.

######################

# Version declaration
VERSION="1.1.0"
VERSION_STAMP="ZAXNWare Installer (zware) version $VERSION"

# If no option is passed, return the version
if [[ "$#" == 0 ]]; then
	echo $VERSION_STAMP
	exit
fi

# GitHub repo base path
BASE_URL="raw.githubusercontent.com/mozaxn/ZAXNWare/main"

# Parse options
while getopts "li:" opt; do

	case $opt in
		l) list=true ;;
		i) tool="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG"; exit 1 ;;
	esac
done

# Show the list of available tools if list=true
if [[ "$list" == true ]]; then

	TOOLS=$( curl -fsL "$BASE_URL/.tools" )

	echo "Available tools in ZAXNWare:"
	for util in $TOOLS; do
		echo -e "\t- $util"
	done
	exit
fi

# Install the tool
TOOL_URL="$BASE_URL/$tool/$tool.sh"
INSTALL_DIR="/usr/local/bin"

echo "[+] Downloading ZAXNWare ($tool)..."
curl -fL "$TOOL_URL" -o "$tool.sh" || {
	echo "[!] Failed to fetch ZAXNWare ($tool)."
	exit 1
}

# Give executable permissions to the tool
chmod +x "$tool.sh"
echo "[+] Installing $tool to $INSTALL_DIR..."

# Move the tool to install directory
sudo mv "$tool.sh" "$INSTALL_DIR/$tool"
echo "[✓] ZAXNWare ($tool) installed successfully."
exit
