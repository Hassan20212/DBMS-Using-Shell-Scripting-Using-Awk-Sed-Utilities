#!/bin/bash

validate_input() {
    if [[ $1 =~ [[:space:]] || $1 =~ [^a-zA-Z0-9_-] ]]; then
        return 1
    fi
    return 0
}

read -p "Enter the name of the database folder (avoid spaces and special characters): " database_name

validate_input "$database_name"
input_valid=$?

while [ $input_valid -ne 0 ]; do
    echo "Invalid database folder name. Please avoid spaces and special characters."
    read -p "Enter the name of the database folder (avoid spaces and special characters): " database_name
    validate_input "$database_name"
    input_valid=$?
done

database_folder=$(find / -type d -name "$database_name" 2>/dev/null)

if [ -n "$database_folder" ]; then
    echo "The database folder exists at: $database_folder"
else
    read -p "The database folder does not exist. Do you want to create it? (Y/N): " create_database
    if [ "$create_database" = "Y" ] || [ "$create_database" = "y" ]; then
        read -p "Enter the directory to create the database folder (leave blank for current directory): " create_directory
        if [ -z "$create_directory" ]; then
            create_directory="."
        fi
        mkdir -p "$create_directory/$database_name"
        echo "The database folder has been created in: $create_directory/$database_name"
    else
        echo "Database creation skipped. Exiting script."
        exit 0
    fi
fi

