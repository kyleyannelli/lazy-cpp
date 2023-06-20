#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
generate_files=0
remove_files=0

source "$SCRIPT_DIR/welcome.sh"

source "$SCRIPT_DIR/argument_parsing.sh"
source "$SCRIPT_DIR/load_or_create_settings.sh"

# If $directory is not null or empty, append $directory to $src_directory. Remove trailing or leading slashes from $directory.
if [ -n "$directory" ]
then
    src_directory=$src_directory/$(echo $directory | sed 's:/*$::')
    # make the directory if it doesn't exist
    mkdir -p $src_directory
fi

if [ $remove_files -eq 1 ]; then
    source "$SCRIPT_DIR/remove_class_files.sh"
    exit 0
fi

if [ $generate_files -eq 1 ]; then
    source "$SCRIPT_DIR/generate_files.sh"
fi

source "$SCRIPT_DIR/check_cmakelists.sh"

if [ $generate_files -eq 0 ]; then
  if [ $# -eq 0 ]; then
      echo "Please provide a class name."
      exit 1
  fi

  source "$SCRIPT_DIR/create_class_files.sh"
fi
