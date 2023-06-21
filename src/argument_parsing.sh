#!/bin/bash

usage() {
    echo -e "\033[1;36mUsage: lazy-cpp [class_name] [-g|--generate] [-d|--directory <path>]\033[0m"
    echo -e "\033[1;32mSimply run 'lazy-cpp your_new_class' to create a new class in your source directory.\033[0m"
    echo -e "\033[1;32mPlease check the .lazycpp file for your settings if you have already set them.\033[0m"
    echo -e "\033[1;34mOptions:\033[0m"
    echo -e "\033[1;35m  -g, --generate             Generate a new CMake project. CMakeLists.txt and a main.cpp will be created for you.\033[0m"
    echo -e "\033[1;35m  -d, --directory <path>     Specify the directory for your .cpp and .h files. This directory will be AFTER/IN your source directory.\033[0m"
    echo -e "\033[1;35m  -rm, --remove              Remove the class files. This will delete the .cpp & .h files, as well as remove them from CMakeLists.txt.\033[0m"
    echo -e "\033[1;35m  -h, --help                 Display this help message.\033[0m"
    echo -e "\033[1;33mLazy-CPP Install Location: $(dirname $0)\033[0m"
    exit 1
}

while (( "$#" )); do
  case "$1" in
    -g|--generate)
      generate_files=1
      shift
      ;;
    -d|--directory)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        directory=$2
        shift 2
      else
        echo "Error: Argument for $1 is missing. Specify the directory beyond your source." >&2
        echo "Example, 'lazy-cpp physics_engine -d math' will create files in ./src/math/physics_engine.* if your source directory is set as src." >&2
        exit 1
      fi
      ;;
    -h|--help)
      usage
      ;;
    -rm|--remove)
      remove_files=1
      shift
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"
