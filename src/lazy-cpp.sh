#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
generate_files=0 # generate CMake Project with main.cpp and CMakeLists.txt
generate_cmake=0 # generate CMakeLists.txt from existing files
remove_files=0 # remove class from CMakeLists.txt and delete .cpp and .h files

source "$SCRIPT_DIR/welcome.sh"

# Check for updates
echo "Checking for updates..."
source "$SCRIPT_DIR/updater.sh"

source "$SCRIPT_DIR/argument_parsing.sh"
source "$SCRIPT_DIR/load_or_create_settings.sh"

# If $directory is not null or empty, append $directory to $src_directory. Remove trailing or leading slashes from $directory.
if [ -n "$directory" ]
then
    src_directory=$src_directory/$(echo $directory | sed 's:/*$::')
    # make the directory if it doesn't exist
    mkdir -p $src_directory
fi

if [ $generate_cmake -eq 1 ]; then
    source "$SCRIPT_DIR/generate_cmake.sh"
    exit 0
fi

if [ $remove_files -eq 1 ]; then
    source "$SCRIPT_DIR/remove_class_files.sh"
    exit 0
fi

if [ $generate_files -eq 1 ]; then
    source "$SCRIPT_DIR/generate_files.sh"
fi

# check if the user provided a class name and we aren't generating files
if [ $# -eq 0 ] && [ $generate_files -eq 0 ]; then
      echo "Please provide a class name (without .cpp or .h extension)."
      exit 1
fi

source "$SCRIPT_DIR/check_cmakelists.sh"

if [ $generate_files -eq 0 ]; then
  source "$SCRIPT_DIR/create_class_files.sh"
fi
