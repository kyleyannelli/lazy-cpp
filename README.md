# lazy-cpp
```

  ██╗      █████╗ ███████╗██╗   ██╗      ██████╗██████╗ ██████╗
  ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝     ██╔════╝██╔══██╗██╔══██╗
  ██║     ███████║  ███╔╝  ╚████╔╝█████╗██║     ██████╔╝██████╔╝
  ██║     ██╔══██║ ███╔╝    ╚██╔╝ ╚════╝██║     ██╔═══╝ ██╔═══╝
  ███████╗██║  ██║███████╗   ██║        ╚██████╗██║     ██║
  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝         ╚═════╝╚═╝     ╚═╝
  Version 0.2.2-beta | Written by Kyle Yannelli (KMFG)

```
For the CLI programmers, lazy-cpp creates CMake projects, and main.cpp from a command. It also generates .cpp &amp; .h files while managing the CMakeLists.txt for you! Try it out.
# Getting Started
### Single Command Install!
1. Run `curl cpp.kmfg.dev | bash` and you're done! Note: On linux you may have to manually install the man page, but the -h or --help achieves the same
### 3 Step Method
1. In ~/Downloads/ or /tmp/ clone and cd into the repository with `git clone https://github.com/kyleyannelli/lazy-cpp && cd lazy-cpp`
2. Run `chmod u+x install.sh && ./install.sh`
3. Installed! Just make sure to run `exec bash_or_zsh` OR `source ~./bash_or_zsh.rc`
# How to Update
Just repeat getting started instructions 1 through 3.
# Compatibility
- MacOS
- Linux
</br>
I don't think I will be adding Windows support, but feel free to make an issue on this repo if you want it on Windows.

# Help

This is straight output directly from `lazy-cpp -h` or `lazy-cpp --help`

```
Usage: lazy-cpp [class_name] [-g|--generate] [-d|--directory <path>]
Simply run 'lazy-cpp your_new_class' to create a new class in your source directory.
Please check the .lazycpp file for your settings if you have already set them.
Options:
  -g, --generate             Generate a new CMake project. CMakeLists.txt and a main.cpp will be created for you.
  -d, --directory <path>     Specify the directory for your .cpp and .h files. This directory will be AFTER/IN your source directory.
  -rm, --remove              Remove the class files. This will delete the .cpp & .h files, as well as remove them from CMakeLists.txt.
  -h, --help                 Display this help message.
Lazy-CPP Install Location: ~/.local/bin/kmfg/lazy-cpp
```

To go in more detail...
- `-g` does not expect anything else and should be ran with no other parameters. This is to generate a boilertemplate CMake project in an empty folder
- `-d` expects a class_name before it and a directory after it. This directory is a sub directory of your source path! The source path is in your .lazycpp file in the root of your project.
- `-rm` expects a class_name before it and will remove the .cpp and .h files in the source directory. If your files are in a different directory please specify with `-d` as shown below.

```
 kyle@Kyles-MacBook-Pro ~/Tools/tmp: lazy-cpp your_class_name -rm -d directory_name

  ██╗      █████╗ ███████╗██╗   ██╗      ██████╗██████╗ ██████╗
  ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝     ██╔════╝██╔══██╗██╔══██╗
  ██║     ███████║  ███╔╝  ╚████╔╝█████╗██║     ██████╔╝██████╔╝
  ██║     ██╔══██║ ███╔╝    ╚██╔╝ ╚════╝██║     ██╔═══╝ ██╔═══╝
  ███████╗██║  ██║███████╗   ██║        ╚██████╗██║     ██║
  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝         ╚═════╝╚═╝     ╚═╝
  Version 0.1.1-beta | Written by Kyle Yannelli (KMFG)

The .cpp file size is 4.0K and the .h file size is 4.0K
Are you sure you want to delete these files? [y/n]y
Files deleted.
Removed from CMakeLists.txt.
Directory is empty, do you want to delete it? [y/n]
y
Directory src/directory_name deleted.
```
# Issues
Just make an issue on this repo. Provide as much detail as you can. Specify expected vs actual behavior. Copy and paste from your terminal, the whole 9. Thank you.
