#!/bin/bash

add_column_headers() {
  while true; do
    echo "Enter the column headers (separated by tabs):"
    read -a headers
    joined_headers=$(IFS=$'\t'; echo "${headers[*]}")
    if echo "${joined_headers}" | awk '/^[a-zA-Z0-9_-]+$/ { print }'; then
      echo -e "$joined_headers" > "$table_file"
      echo "Column headers added successfully."
      break
    else
      echo "Invalid input. Column headers can only contain letters, numbers, and underscores."
    fi
  done
}

write_content() {
  while true; do
    echo "Enter the content for each row (separated by tabs):"
    read -a content
    joined_content=$(IFS=$'\t'; echo "${content[*]}")
    if echo "${joined_content}" | awk '/^[a-zA-Z0-9_]+$/ { print }'; then
      echo -e "$joined_content" >> "$table_file"
      echo "Content written successfully."
      break
    else
      echo "Invalid input. Content can only contain letters, numbers, and underscores."
    fi
  done
}

create_table() {
  echo "Enter the name of the table file:"
  read table_file
  touch "$table_file"

  echo "Table '$table_file' created successfully."

  while true; do
    echo "Table Menu"
    echo "1. Add Column Headers"
    echo "2. Write Table Content"
    echo "3. Exit"
    read -p "Enter your choice: " choice
    case $choice in
      1) add_column_headers ;;
      2) write_content ;;
      3) break ;;
      *) echo "Invalid choice. Please try again." ;;
    esac
  done
}

create_table
