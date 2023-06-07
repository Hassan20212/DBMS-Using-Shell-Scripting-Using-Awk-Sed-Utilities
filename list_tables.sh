#!/bin/bash

read -p "Enter the database path: " directory

list_text_files() {
    local path=$1

    while IFS= read -r -d '' file; do
        if [[ -f "$file" && $(awk 'BEGIN{FS="."} NF>1 && $NF ~ /^(txt|text)$/ {print "true"}' <<< "$file") == "true" ]]; then
            echo "$file"
        fi
    done < <(find "$path" -type f -print0)
}
list_text_files "$directory"
