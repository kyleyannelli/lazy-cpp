#!/bin/bash

usage() {
    echo "Usage: lazy-cpp [-g|--generate] [-d|--directory <path>]"
    echo "Options:"
    echo "  -g, --generate             Generate a new CMake project. CMakeLists.txt and a main.cpp will be created for you."
    echo "  -d, --directory <path>     Specify the directory for your .cpp and .h files. This directory will be AFTER/IN your source directory."
    echo "  -h, --help                 Display this help message."
    echo "Lazy-CPP Install Location: $(dirname $0)"
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

