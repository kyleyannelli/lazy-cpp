#!/bin/bash

SCRIPT_DIR="$HOME/.local/bin/kmfg/lazy-cpp"
VERSION="0.1.1-beta"

# Create the directory if it doesn't exist
mkdir -p "$SCRIPT_DIR"

# Check if the directory is not empty
if [ "$(ls -A "$SCRIPT_DIR")" ]; then
    echo "The directory $SCRIPT_DIR is not empty."
    read -p "Are you sure you want to delete all its contents? [y/n] " -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -r $SCRIPT_DIR/*
        echo "Deleted all contents in $SCRIPT_DIR."
    else
        echo "Aborted. Install script did not complete."
        exit 1
    fi
fi

# Copy the scripts
cp src/lazy-cpp.sh "$SCRIPT_DIR"
cp src/argument_parsing.sh "$SCRIPT_DIR"
cp src/load_or_create_settings.sh "$SCRIPT_DIR"
cp src/generate_files.sh "$SCRIPT_DIR"
cp src/check_cmakelists.sh "$SCRIPT_DIR"
cp src/create_class_files.sh "$SCRIPT_DIR"
cp src/welcome.sh "$SCRIPT_DIR"
cp src/remove_class_files.sh "$SCRIPT_DIR"

# Add the alias and version #
if [ -f "$HOME/.bashrc" ]; then
    if grep -q "^alias lazy-cpp=" ~/.bashrc; then
        sed -i '' '/alias lazy-cpp=/d' ~/.bashrc
    fi
    echo "alias lazy-cpp='$SCRIPT_DIR/lazy-cpp.sh'" >> ~/.bashrc

    if grep -q "^export CPP_LAZY_VERSION=" ~/.bashrc; then
        sed -i '' '/export CPP_LAZY_VERSION=/d' ~/.bashrc
    fi
    echo "export CPP_LAZY_VERSION=$VERSION" >> ~/.bashrc
    echo "Alias added to .bashrc. Please run 'source ~/.bashrc' to apply changes."
elif [ -f "$HOME/.zshrc" ]; then
    if grep -q "^alias lazy-cpp=" ~/.zshrc; then
        sed -i '' '/alias lazy-cpp=/d' ~/.zshrc
    fi
    echo "alias lazy-cpp='$SCRIPT_DIR/lazy-cpp.sh'" >> ~/.zshrc

    if grep -q "^export CPP_LAZY_VERSION=" ~/.zshrc; then
        sed -i '' '/export CPP_LAZY_VERSION=/d' ~/.zshrc
    fi
    echo "export CPP_LAZY_VERSION=$VERSION" >> ~/.zshrc
    echo "Alias added to .zshrc. Please run 'source ~/.zshrc' to apply changes."
else
    echo "Could not find .bashrc or .zshrc file to add alias. Please add the following lines to your rc file manually."
    echo "alias lazy-cpp='$SCRIPT_DIR/lazy-cpp.sh'"
    echo "export CPP_LAZY_VERSION=$VERSION"
fi

# finally copy docs/lazy-cpp.1 to /usr/local/share/man/man1/
echo "If you want to install the man page you'll need to have sudo privileges."
sudo cp docs/lazy-cpp.1 /usr/local/share/man/man1/