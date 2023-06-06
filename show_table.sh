#!/bin/sh

echo "Enter the path to the input text file:"
read input_file

if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

sed 's/  */\t/g' < "$input_file" | awk '
BEGIN {
    print ".TS"
    print "allbox;" 
    print "c s s s" 
    print "lb lb lb lb" 
    print "l l l l."
    print "My Table" 
}
{print}
END {
    print ".TE" # end of table
}' | tbl | nroff -Tdumb

