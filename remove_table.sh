#!/bin/bash

remove_file() {
    echo "Enter the path to the file you want to remove:"
    read file_path

    if [ ! -f "$file_path" ]; then
        echo "Error: File '$file_path' not found."
        return
    fi

    rm "$file_path"
    echo "File '$file_path' removed successfully."
}

remove_file

