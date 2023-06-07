#!/bin/bash

read -p "Enter the directory name: " dir_name

directories=$(find / -type d -name "$dir_name" 2>/dev/null)

if [[ -z "$directories" ]]; then
  echo "No directories found with the name '$dir_name'."
  exit 1
fi

processed_directories=()

while IFS= read -r directory; do
  formatted_directory=$(echo "$directory" | awk -F '/' '{print $(NF-1), $NF}' | sed 's/[^ ]*//')
  if [[ ! " ${processed_directories[@]} " =~ " ${formatted_directory} " ]]; then
    processed_directories+=("$formatted_directory")
    echo "Found datadase: $formatted_directory" 
    echo "$directory"
  fi
done <<< "$directories"

