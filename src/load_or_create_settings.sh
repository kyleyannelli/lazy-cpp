#!/bin/bash

# Load the settings from the .lazycpp file, if it exists
if [ -f .lazycpp ]
then
    src_directory=$(grep "src_directory" .lazycpp | cut -d'=' -f2)
    src_directory=${src_directory%/} # Remove trailing slash if it exists
    header_name=$(grep "header_name" .lazycpp | cut -d'=' -f2)
else
    echo ".lazycpp file not found. Let's make one! You can change these settings later by editing the .lazycpp file."
    read -p "Enter your name for the headers (default is '$USER'): " header_name
    read -p "Enter the source directory (default is './src'): " src_directory
    src_directory=${src_directory:-src}
    read -p "Do you want to add new classes to CMakeLists.txt automatically? [y/n] (default is 'n'): " yn
    case $yn in
        [Yy]* ) add_to_cmakelists=true;;
        * ) add_to_cmakelists=false;;
    esac
    echo "src_directory=$src_directory" > .lazycpp
    echo "add_to_cmakelists=$add_to_cmakelists" >> .lazycpp
    echo "header_name=$header_name" >> .lazycpp
fi
