#!/bin/bash

read -p "Enter the number of fields: " num_fields
read -p "Enter the primary key field name: " primary_key

declare -A field_types_regex
field_types_regex["int"]='^[0-9]+$'
field_types_regex["float"]='^[0-9]+([.][0-9]+)?$'
field_types_regex["varchar"]='^.*$'

table_header="$primary_key"
for ((i=2; i<=num_fields; i++)); do
  read -p "Enter field $i name: " field_name
  read -p "Enter data type for field $field_name (int, float, varchar): " field_type

  if [[ -z ${field_types_regex[$field_type]} ]]; then
    echo "Invalid data type. Please try again."
    exit 1
  fi

  table_header+=", $field_name"
done

read -p "Enter the name of the table: " table_name
read -p "Enter the path where the table file should be created: " table_path

table_file="$table_path/$table_name.txt"
echo $table_header > $table_file

echo "Enter the table content (press Ctrl+D when done): "
auto_number=1
while read -ra field_values; do
  if [[ ${#field_values[@]} -ne $((num_fields - 1)) ]]; then
    echo "Invalid number of fields entered. Please try again."
    exit 1
  fi
  echo "$auto_number ${field_values[*]}" >> $table_file
  auto_number=$((auto_number + 1))
done

echo "Table created successfully in $table_file."
