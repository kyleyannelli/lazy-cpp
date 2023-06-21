#!/bin/bash
function prompt_and_create() {
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
}

function add_files() {
  # store first parameter as $file
  file=$1
  # Check if the file is already listed in the CMakeLists.txt
  if ! grep -q "$file" CMakeLists.txt
  then
    # check the operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS requires an empty string argument after -i
      #sed -i '' "/add_executable($project_name/ s|add_executable($project_name|& $file|" CMakeLists.txt
      sed -i '' "/add_executable/ s|$| $file|" CMakeLists.txt
    else
      # Linux can use -i without an argument
      #sed -i "/add_executable($project_name/ s|add_executable($project_name|& $file|" CMakeLists.txt
      sed -i "/add_executable/ s|$| $file|" CMakeLists.txt
    fi
    echo "$file added to CMakeLists.txt"
  else
    echo -e "\033[2m$file already listed in CMakeLists.txt... skipping\033[0m"
  fi
}

function remove_exec_parenthesis() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS requires an empty string argument after -i
    sed -i '' "/add_executable($project_name/ s/)//" CMakeLists.txt
  else
    # Linux can use -i without an argument
    sed -i "/add_executable($project_name/ s/)//" CMakeLists.txt
  fi
}

function add_exec_parenthesis() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS requires an empty string argument after -i
    sed -i '' "/add_executable/ s|$|)|" CMakeLists.txt
  else
    # Linux can use -i without an argument
    sed -i "/add_executable/ s|$|)|" CMakeLists.txt
  fi
}