#!/bin/bash

# Check for updates, limit to half a second timeout
LATEST_VERSION=$(curl -m 0.5 --silent "https://api.github.com/repos/kyleyannelli/lazy-cpp/releases/latest" | grep tag_name | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')
CURRENT_VERSION=$CPP_LAZY_VERSION
# see if IGNORE_UPDATE in $SCRIPT_DIR"/.lazycpp-config is older than 1 day
if [ -f "$SCRIPT_DIR"/.lazycpp-config ]; then
  IGNORE_UPDATE=$(grep 'IGNORE_UPDATE' "$SCRIPT_DIR"/.lazycpp-config | cut -d '=' -f 2)
  # make sure IGNORE_UPDATE is a number
  if ! [[ "$IGNORE_UPDATE" =~ ^[0-9]+$ ]]; then
    IGNORE_UPDATE=0
  fi
  IGNORE_UPDATE=$(( $(date +%s) - IGNORE_UPDATE < 86400 ))
fi

if [ "$LATEST_VERSION" != "v$CURRENT_VERSION" ] && [ -n "$LATEST_VERSION" ] && [ $IGNORE_UPDATE -eq 0 ]; then
  # prompt user to update
  echo "A new version of lazy-cpp is available."
  echo -n "Would you like to update? ($CURRENT_VERSION => $LATEST_VERSION) (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    # use web script
    echo "Updating via https://cpp.kmfg.dev..."
    curl cpp.kmfg.dev | bash &> /dev/null
    echo "Update complete. Please re-run your command."
    exit 0
  else
    # ignore update
    echo "Ignoring update for 1 day."
    # if IGNORE_UPDATE line exists remove it then append
    if [ -f "$SCRIPT_DIR"/.lazycpp-config ]; then
      if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sed -i '/IGNORE_UPDATE/d' "$SCRIPT_DIR"/.lazycpp-config
      elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' '/IGNORE_UPDATE/d' "$SCRIPT_DIR"/.lazycpp-config
      fi
    fi
    echo "IGNORE_UPDATE=$(date +%s)" >> "$SCRIPT_DIR"/.lazycpp-config
  fi
fi