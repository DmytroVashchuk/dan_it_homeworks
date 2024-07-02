#!/bin/bash

echo -n "Enter the filename to read: "
read filename

if [ -e "$filename" ];
then
	cat "$filename"
else
	echo "Error: The file '$filename' doesn't exist."
	exit 1
fi
