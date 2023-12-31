#!/bin/bash
source "$SCRIPT_DIR/function_scripts/headers.sh"
# Check if CMakeLists.txt exists in the current directory
if [ ! -f ./CMakeLists.txt ]; then
    echo
    error_start_banner
    echo "Please create a CMakeLists.txt file or make sure you are in your projects root directory, then rerun the script"
    error_end_banner
    echo
    info_start_banner
    echo "Note you can use the -g or --generate flag to generate a base CMake project"
    echo "You can use -gm or --generate-make to generate CMake from existing source files"
    info_end_banner
    echo
    exit 1
fi

