#!/bin/sh

echo "Enter the path to the input text file:"
read input_file

if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

file_name=$(basename "$input_file")
file_name_without_extension="${file_name%.*}"

sed 's/  */\t/g' < "$input_file" | awk -v file_name="$file_name_without_extension" '
BEGIN {
    print ".TS"
    print "allbox;" 
    print "c s s s" 
    print "lb lb lb lb" 
    print "l l l l."
    print file_name
}
{print}
END {
    print ".TE" # end of table
}' | tbl | nroff -Tdumb
