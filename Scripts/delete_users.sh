#!/bin/env bash

if [ -z "$1" ]; then
    echo "use:sudo $0 <username>"
    exit 1
fi

USERNAME="$1"

if id "$USERNAME" &>/dev/null; then
  # tar czf "/home/<user>/backup_$(date +%Y%m%d).tar.gz" "/home/$USERNAME" # Backup the user's home directory
    userdel -r "$USERNAME"
    echo "User $USERNAME deleted."
else
    echo "User $USERNAME does not exist."
fi