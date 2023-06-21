#!/bin/bash
source "$SCRIPT_DIR/function_scripts/adjust_cmake.sh"

# look in $src_directory for all .cpp and .h files
files_array=($(find $src_directory -type f \( -name "*.cpp" -o -name "*.h" \)))

# display what files have been found and ask the user if they want to add them to CMakeLists.txt
echo "Found the following files:"
for file in "${files_array[@]}"
do
    echo $file
done
# display total number of files found
echo "(Total ${#files_array[@]})"
echo "Do you want to add these files to CMakeLists.txt?"
read -p "If any are already contained in the CMakeLists.txt, they will be skipped. [y/n] (default is 'n'): " yn
yn=${yn:-n}
if [[ "$yn" =~ ^[Nn]$ ]]
then
  echo "Exiting..."
  exit 1
fi

# first we need to create the CMakeLists.txt file if it doesn't exist
if [ ! -f ./CMakeLists.txt ]; then
    prompt_and_create
else
  source "$SCRIPT_DIR/function_scripts/headers.sh"
  warning_start_banner
  echo "CMakeLists.txt found in the current directory. Are you sure you want to add files to it?"
  read -p "The script will attempt to append the files properly, but will fail if the CMakeLists is improper. [y/n]: " yn
  yn=${yn:-n}
  if [[ "$yn" =~ ^[Nn]$ ]]
  then
    echo "Exiting..."
    exit 1
  fi
fi

# First, remove the closing parenthesis from the add_executable line
remove_exec_parenthesis

# for each file in the array, add it to the CMakeLists.txt
for file in "${files_array[@]}"
do
  add_files $file
done

# After all files have been processed, append the closing parenthesis to the add_executable line
add_exec_parenthesis
