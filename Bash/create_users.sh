#!/bin/env bash

GROUP="deployG"
USERS=("Devo" "Testo" "Prodo")

if getent group $GROUP > /dev/null 2>&1; then
    echo "Group $GROUP already exists."
else
    groupadd $GROUP
    echo "Group $GROUP created."
fi

# Create users and add them to the group
for USER in "${USERS[@]}"; do
    if id "$USER" &>/dev/null; then
        echo "User $USER already exists."
    else
        useradd -m -G $GROUP $USER
        chage -d 0 $USER
        echo "User $USER created and added to group $GROUP."
    fi
done

