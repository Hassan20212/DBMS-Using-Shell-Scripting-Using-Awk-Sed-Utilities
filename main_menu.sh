#!/bin/bash

create_database_script() {
    source ./create_database.sh
}

create_table_script() {
    source ./create_table.sh
}

modify_table_script() {
    source ./modify_table.sh
}

show_table_script() {
    source ./show_table.sh
}

remove_table_script() {
    source ./remove_table.sh
}

exit_script() {
    echo "Exiting..."
    exit 0
}

main_menu() {
    echo "Main Menu"
    echo "1. Create Database"
    echo "2. Create Table"
    echo "3. Modify Table"
    echo "4. Show Table"
    echo "5. Remove Table"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) create_database_script ;;
        2) create_table_script ;;
        3) modify_table_script ;;
        4) show_table_script ;;
        5) remove_table_script ;;
        6) exit_script ;;
        *) echo "Invalid choice. Please try again." ;;
    esac

    main_menu
}

main_menu

