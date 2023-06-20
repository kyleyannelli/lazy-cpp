#!/bin/bash

# Check if CMakeLists.txt exists in the current directory
if [ ! -f ./CMakeLists.txt ]; then
    echo
    printf "\e[91m*****START ERROR*****\e[0m\n"
    echo "Please create a CMakeLists.txt file or make sure you are in your projects root directory, then rerun the script"
    printf "\e[91m*****END ERROR*****\e[0m\n"
    echo
    printf "\e[94m*****START INFO*****\e[0m\n"
    echo "Note you can use the -g or --generate flag to generate a base CMake project"
    printf "\e[94m*****END INFO*****\e[0m\n"
    echo
    exit 1
fi

