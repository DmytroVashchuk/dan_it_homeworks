#!/bin/bash

echo -n "Enter a sentence: "
read sentence
reverse_sentence=$(echo $sentence | awk '{for(i=NF; i>0; i--) printf "%s ", $i; print ""}')

echo "Reversed sentence: $reverse_sentence"


