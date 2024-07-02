#!/bin/bash

#Chekking number of arguments in shell
if [ $# -ne 2 ];
then
	echo "$0 main_file copied_file"
	exit 1
fi

#Storring arguments in the variables
main_file=$1
copied_file=$2

#Checking exists of the source file
if [ -e "$main_file" ]; then
    cp "$main_file" "$copied_file"
    echo "File copied from '$main_file' to '$copied_file'."
else
    echo "Main file '$main_file' does not exist."
    exit 1
fi


