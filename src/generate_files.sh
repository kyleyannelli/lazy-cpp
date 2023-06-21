#!/bin/bash
source "$SCRIPT_DIR/function_scripts/headers.sh"
source "$SCRIPT_DIR/function_scripts/adjust_cmake.sh"
### START GENERATION ###
if [ -f ./CMakeLists.txt ]; then
    error_start_banner
    echo "CMakeLists.txt found in the current directory. Cannot generate project template!"
    error_end_banner
    exit 1
fi
echo -n "Generate CMakeLists.txt? [y/n]: "
read create_cmakelists
if [[ "$create_cmakelists" =~ ^[Yy]$ ]]
then
    prompt_and_create

    # Create the source directory if it doesn't exist
    if [ ! -d $src_directory ]; then
        mkdir $src_directory
        echo "Created directory $src_directory"
    fi
    # Create a main.cpp file if it doesn't exist in the source directory
    if [ ! -f $src_directory/main.cpp ]; then
            echo "//
            // Created by $header_name on $(date '+%m/%d/%Y').
            //
            #include <iostream>

            int main() {
                std::cout << \"Hello, World.\" << std::endl;
                return 0;
            }" > $src_directory/main.cpp
            echo "Created main.cpp in $src_directory"
            # Add the main.cpp to the CMakeLists.txt file
            remove_exec_parenthesis
            add_files $src_directory/main.cpp
            add_exec_parenthesis
    fi
fi
### END GENERATION ###

