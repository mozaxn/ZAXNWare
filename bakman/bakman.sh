#!/bin/bash

#######################
# ZAXNWare Backup Man #
#######################
# Author: ZAXN
# Created on: 21/10/2025
# Last updated on: 21/10/2025

# Backup Man is a utility which creates backup files of a file or directory.
# Backup Man can also pack all the backup files into an archive (.tar).
# It can also compress the backed up archive (.tar.gz).

#######################

# Version declaration
VERSION="1.2.0"
VERSION_STAMP="ZAXNWare Backup Man version $VERSION"

# If no argument is passed, return the version.
if [[ "$#" == 0 ]]; then
	echo $VERSION_STAMP
	exit 0
fi

# Parse the options
while getopts "kzrvmf:d:" opt; do

	case $opt in
		k) archive=true ;;
		z) compress=true ;;
		r) remove=true ;;
		v) verbose=true ;;
		m) makedir=true ;;
		f) file=true; filename="$OPTARG" ;;
		d) dir=true; dirname="$OPTARG" ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
	esac
done

# Check if the directory/file exists
if [[ "$file" == true ]]; then
	if [[ ! -e "$filename" ]]; then
		echo "'$filename' does not exist!" >&2
		exit 1
	elif [[ ! -f "$filename" ]]; then
		echo "'$filename' is not a file!" >&2
		exit 1
	fi

elif [[ "$dir" == true ]]; then
	if [[ ! -e "$dirname" ]]; then
		echo "'$dirname' does not exist!" >&2
		exit 1
	elif [[ ! -d "$dirname" ]]; then
		echo "'$dirname' is not a directory!" >&2
		exit 1
	fi
fi

# Check if a separate directory is to be made for backups.
if [[ "$makedir" == true ]]; then
	if [[ ! -d "bak" ]]; then
		mkdir bak
		if [[ "$verbose" ]]; then
			echo "Creating backup folder 'bak'..."
		fi	
	fi
fi

# Make backups for the file.
if [[ "$file" == true ]]; then
	if [[ "$makedir" == true ]]; then
		cp -a "$filename" "bak/$filename.bak"

		if [[ "$verbose" ]]; then
			echo "Created backup file 'bak/$filename.bak' for '$filename'"
		fi
	else
		cp -a "$filename" "$filename.bak"
		
		if [[ "$verbose" ]]; then
			echo "Created backup file '$filename.bak' for '$filename'"
		fi
	fi

# Make backups for directories.
elif [[ "$dir" == true ]]; then
	if [[ ! -d "bak" ]]; then
		mkdir bak

		if [[ "$verbose" ]]; then
			echo "Created backup folder 'bak'"
		fi
	fi

	for directory in $( find "$dirname" -type d | sort ); do
		mkdir "bak/$directory"

		if [[ "$verbose" ]]; then
			echo "Created directory 'bak/$directory'"
		fi
	done

	for file in $( find "$dirname" -type f | sort ); do
		cp -a "$file" "bak/$file.bak"

		if [[ "$verbose" ]]; then
			echo "Created backup: '$file.bak'"
		fi
	done
	
	# Archive the backed up directory.
	if [[ "$compress" == true ]]; then
		cd bak
		tar -czf  "$dirname.tar.gz" "$dirname/"

		if [[ "$verbose" ]]; then
			echo "Compressing 'bak/$dirname/' to '$dirname.tar.gz'"
		fi
		
	elif [[ "$archive" == true ]]; then
		cd bak
		tar -cf "$dirname.tar" "$dirname/"

		if [[ "$verbose" ]]; then
			echo "Archiving 'bak/$dirname' to '$dirname.tar'"
		fi
	fi

	if [[ ( "$archive" || "$compress" ) && "$remove" == true ]]; then
		rm -r "$dirname/"

		if [[ "$verbose" ]]; then
			echo "Removing 'bak/$dirname/'..."
		fi
	fi
	cd ..

fi

if [[ "$verbose" ]]; then
	echo "Backup complete!"
fi

exit
