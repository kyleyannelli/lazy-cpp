 remove_from_cmakelists() {
     local file_to_remove="$1"
     awk -v ftr="$file_to_remove" '
     BEGIN { ORS = "" }
     /add_executable/ {
         print $1 " " $2 " " $3 " "
         for (i=4; i<=NF; i++) {
             if ($i != ftr) {
                 print $i " "
             }
         }
         print "\n"
         next
     }
     { print $0 "\n" }' CMakeLists.txt > CMakeLists.tmp && mv CMakeLists.tmp CMakeLists.txt
 }

  # Get size of the .cpp and .h files
  cpp_file_size=$(du -sh "$src_directory/$1.cpp" | cut -f1)
  h_file_size=$(du -sh "$src_directory/$1.h" | cut -f1)
  
  echo "The .cpp file size is $cpp_file_size and the .h file size is $h_file_size"
  echo "Are you sure you want to delete these files? [y/n]"
  read -r answer
  if [[ $answer == "y" || $answer == "Y" ]]; then
    # Deleting the .cpp and .h files
    rm "$src_directory/$1.cpp" "$src_directory/$1.h"
    echo "Files deleted."
    remove_from_cmakelists "$src_directory/$1.cpp"
    echo "Removed from CMakeLists.txt."
  
    # Check if the directory is empty
    if [ -z "$(ls -A $src_directory)" ]; then
      echo "Directory is empty, do you want to delete it? [y/n]"
      read -r answer
      if [[ $answer == "y" || $answer == "Y" ]]; then
        rmdir "$src_directory"
        echo "Directory $src_directory deleted."
      fi
    fi
  fi