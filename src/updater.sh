#!/bin/bash

# Check for updates, limit to half a second timeout
LATEST_VERSION=$(curl -m 0.5 --silent "https://api.github.com/repos/kyleyannelli/lazy-cpp/releases/latest" | grep tag_name | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')
CURRENT_VERSION=$CPP_LAZY_VERSION

if [ "$LATEST_VERSION" != "v$CURRENT_VERSION" ] && [ -n "$LATEST_VERSION" ]; then
  # prompt user to update
  echo "A new version of lazy-cpp is available."
  echo -n "Would you like to update? ($CURRENT_VERSION => $LATEST_VERSION) (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    # use web script
    echo "Updating via https://cpp.kmfg.dev..."
    curl cpp.kmfg.dev | bash &> /dev/null
    echo "Update complete. Please re-run your command."
    # refresh the shell
    exec "$SHELL"
    exit 0
  fi
fi