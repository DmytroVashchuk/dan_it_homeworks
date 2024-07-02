#!/bin/bash

echo -n "Enter the filename for chekking: "
read filename

if [ -e "$filename" ];
then
	echo "The file '$filename' exists."
else
	echo "The file '$filename' doesn't exist."
fi
