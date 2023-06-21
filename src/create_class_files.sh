#!/bin/bash

className=$1

# Read the settings from the .lazycpp file
add_to_cmakelists=$(grep "add_to_cmakelists" .lazycpp | cut -d'=' -f2)

# Check if the .cpp or .h files already exist
if [ -f $src_directory/$className.cpp ] || [ -f $src_directory/$className.h ]
then
    read -p "File $src_directory/$className.cpp or $src_directory/$className.h already exists. Do you want to overwrite it? [y/n]: " yn
    case $yn in
        [Nn]* ) echo "Operation cancelled."; exit;;
        * ) echo "Overwriting file(s)...";;
    esac
fi

upperClassName=$(echo $className | tr '[:lower:]' '[:upper:]')

# Create the header file
echo "//
// Created by $header_name on $(date '+%m/%d/%Y').
//

#ifndef ${upperClassName}_H
#define ${upperClassName}_H

class $className {

};

#endif //${upperClassName}_H" > $src_directory/$className.h

# Create the .cpp file
echo "//
// Created by $header_name on $(date '+%m/%d/%Y').
//

#include \"$className.h\"" > $src_directory/$className.cpp

# Get the name of the project from CMakeLists.txt
project_name=$(awk -F'[()]' '/project/ {print $2}' CMakeLists.txt)

# If the flag is set, add the files to the CMakeLists.txt
if [ "$add_to_cmakelists" = "true" ]
then
    source "$SCRIPT_DIR/function_scripts/adjust_cmake.sh"
    remove_exec_parenthesis
    add_files $src_directory/$className.cpp
    add_files $src_directory/$className.h
    add_exec_parenthesis
fi

echo "Created $className.h & $className.cpp in $src_directory"

