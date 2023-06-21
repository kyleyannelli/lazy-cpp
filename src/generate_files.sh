#!/bin/bash
source "$SCRIPT_DIR/headers.sh"
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
    # Prompt for necessary information
    echo "Please provide the following information:"
    read -p "Project Name: " project_name
    read -p "Minimum Required CMake Version [Default: 3.5]: " cmake_version
    cmake_version=${cmake_version:-3.5}
    read -p "CPP Standard? [Default: 17]: " cpp_standard
    cpp_standard=${cpp_standard:-17}

    # Create the CMakeLists.txt file
    echo "cmake_minimum_required(VERSION $cmake_version)
project($project_name)

set(CMAKE_CXX_STANDARD $cpp_standard)

# Add the executable
add_executable($project_name)" > CMakeLists.txt
    echo "Created CMakeLists.txt"

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
    if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires an empty string argument after -i
            sed -i '' "/add_executable($project_name/ s|$project_name|$project_name $src_directory/main.cpp|" CMakeLists.txt
    else
            # Linux can use -i without an argument
            sed -i "/add_executable($project_name/ s|$project_name|$project_name $src_directory/main.cpp|" CMakeLists.txt
    fi
    echo "Added main.cpp to CMakeLists.txt"
    fi
fi
### END GENERATION ###

