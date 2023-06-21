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
    # Check if the file is already listed in the CMakeLists.txt
    if ! grep -q "$src_directory/$className.cpp" CMakeLists.txt
    then
        # check the operating system
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires an empty string argument after -i
            sed -i '' "/add_executable($project_name/ s|$project_name|$project_name $src_directory/$className.cpp|" CMakeLists.txt
            sed -i '' "/add_executable($project_name/ s|$project_name|$project_name $src_directory/$className.h|" CMakeLists.txt
        else
            # Linux can use -i without an argument
            sed -i "/add_executable($project_name/ s|$project_name|$project_name $src_directory/$className.cpp|" CMakeLists.txt
            sed -i "/add_executable($project_name/ s|$project_name|$project_name $src_directory/$className.h|" CMakeLists.txt
        fi
        echo "$className.cpp & $className.h added to CMakeLists.txt"
    else
        echo "$src_directory/$className.cpp is already listed in CMakeLists.txt"
    fi
fi

echo "Created $className.h & $className.cpp in $src_directory"

