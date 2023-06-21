#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
generate_files=0 # generate CMake Project with main.cpp and CMakeLists.txt
generate_cmake=0 # generate CMakeLists.txt from existing files
remove_files=0 # remove class from CMakeLists.txt and delete .cpp and .h files
update_cmake=0 # update CMakeLists.txt with new classes that may have been manually added

# If CMakeLists.txt exists, get project name
if [ -f CMakeLists.txt ]; then
  project_name=$(awk -F'[()]' '/project/ {print $2}' CMakeLists.txt)
fi

# Check for updates
# Make sure user did not pass --no-update flag
if [ "$1" != "--no-update" ]; then
    source "$SCRIPT_DIR/welcome.sh"
    echo "Checking for updates..."
    source "$SCRIPT_DIR/updater.sh"
fi

source "$SCRIPT_DIR/argument_parsing.sh"
# src_directory and header_name variables are created in load_or_create
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

if [ $update_cmake -eq 1 ]; then
    source "$SCRIPT_DIR/update_cmake.sh"
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
      "$SCRIPT_DIR"/lazy-cpp.sh --no-update -h
      exit 1
fi

source "$SCRIPT_DIR/check_cmakelists.sh"

if [ $generate_files -eq 0 ]; then
  source "$SCRIPT_DIR/create_class_files.sh"
fi
