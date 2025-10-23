#!/bin/bash

######################
# ZAXNWare Installer #
######################
# Author: Mohammad Zain ul Abideen
# Created on: 23/10/2025
# Last updated on: 23/10/2025

# ZAXNWare Installer (zware) is a lightweight package installer for ZAXNWare utilities.

######################

# Version declaration
VERSION="1.0.0"
VERSION_STAMP="ZAXNWare Installer (zware) version $VERSION"

# If no option is passed, return the version
if [[ "$#" == 0 ]]; then
	echo $VERSION_STAMP
	exit
fi

# Parse options
while getopts "i:" opt; do

	case $opt in
		i) tool="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG"; exit 1 ;;
	esac
done

# Install the tool
BASE_URL="raw.githubusercontent.com/mozaxn/ZAXNWare/main"
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
