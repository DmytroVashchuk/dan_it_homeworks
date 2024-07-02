#!/bin/bash

#Checking number input arguments in shell

if [ $# -ne 1 ];
then
	echo "Usage: $0 filename"
	exit 1
fi

# Storring argument in the variables

filename=$1


#Checking exists file

if [ -e "$filename" ];
then
#Find the number of lines
	count=$(wc -l < "$filename")
	echo "The file '$filename' has $count lines."
else
	echo "The file '$filename' doesn't exists."
	exit 1
fi



