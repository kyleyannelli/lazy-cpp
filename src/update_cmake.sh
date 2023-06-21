#!/bin/bash
source "$SCRIPT_DIR/function_scripts/adjust_cmake.sh"
source "$SCRIPT_DIR/function_scripts/headers.sh"
# look in $src_directory for all .cpp and .h files
files_array=($(find $src_directory -type f \( -name "*.cpp" -o -name "*.h" \)))

# display files that arent in CMakeLists.txt
echo "The following files are not in CMakeLists.txt:"
TOTAL_FILES=0
for file in "${files_array[@]}"
do
  if ! grep -q $file CMakeLists.txt; then
    echo $file
    TOTAL_FILES=$((TOTAL_FILES+1))
  fi
done
# if total files is 0, exit
if [ $TOTAL_FILES -eq 0 ]; then
  warning_start_banner
  echo "No new .cpp or .h files found. Exiting..."
  exit 1
fi
# display total number of files found
echo "(Total $TOTAL_FILES)"
read -p "Do you want to add these files to CMakeLists.txt?" yn
yn=${yn:-n}
if [[ "$yn" =~ ^[Nn]$ ]]
then
  echo "No changes made. Exiting..."
  exit 1
fi

# add the files
remove_exec_parenthesis
for file in "${files_array[@]}"
do
  if ! grep -q $file CMakeLists.txt; then
    add_files $file
  fi
done
add_exec_parenthesis
echo "Done!"