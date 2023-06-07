#!/bin/bash

read -p "Enter the path to the table file: " table_file

if [[ ! -f $table_file ]]; then
  echo "Table file not found."
  exit 1
fi

while true; do
  echo "Menu:"
  echo "1. Open table file manually"
  echo "2. Remove row by primary key"
  echo "3. Remove column"
  echo "4. Edit row values"
  echo "5. Exit"
  read -p "Enter your choice: " choice

  case $choice in
    1)
      nano $table_file
      ;;
    2)
      read -p "Enter the primary key of the row to remove: " primary_key
      sed -i "/^$primary_key\s/d" $table_file
      echo "Row removed successfully."
      ;;
    3)
      read -p "Enter the column number to remove (starting from 1): " column_number
      awk -v col=$column_number -F, '{ $col = ""; sub(/,,/, ",") }1' OFS=, $table_file > temp.txt
      mv temp.txt $table_file
      echo "Column removed successfully."
      ;;
    4)
      read -p "Enter the primary key of the row to edit: " primary_key
      read -p "Enter the new values for the row (separated by tabs): " new_values
      sed -i "/^$primary_key\s/s/.*/$primary_key $new_values/" $table_file
      echo "Row edited successfully."
      ;;
    5)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac
done

