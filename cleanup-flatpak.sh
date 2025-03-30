#!/bin/bash

# Error status variables
STATUS_OK=0
STATUS_ERROR=1

# Definitions
USER_NAME="${SUDO_USER:-${USER}}"
USER_DIR="/home/${USER_NAME}"

# Execute it as root user
if [ "${USER}" != root ]; then
  echo "ERROR: must be root! Exiting..."
  exit "${STATUS_ERROR}"
fi

# Current status
USED_BEFORE="$(df -k / | awk 'NR>1 {print $3}')"

# flatpak cleanup
if [ -n "$(command -v flatpak)" ]; then
  flatpak repair &> /dev/null
  # Remove flatpak cache
  rm -rf /var/tmp/flatpak-cache-*
  sudo -u "${USER_NAME}" rm -rf "${USER_DIR}"/.cache/flatpak/*
  # Remove unused flatpak runtimes
  if [ -n "$(flatpak list --runtime)" ]; then
    flatpak uninstall --unused
  fi
fi

# Current status
USED_AFTER="$(df -k / | awk 'NR>1 {print $3}')"

# Summary
echo "Freed up space: $(( (USED_BEFORE - USED_AFTER)/1024 )) MB"
exit "${STATUS_OK}"
