#!/bin/env bash

GROUP_NAME="deployG"

# Check if the group exists
if getent group "$GROUP_NAME" > /dev/null 2>&1; then
    echo "Group $GROUP_NAME exists."
else
    echo "Group $GROUP_NAME does not exist."
    exit 1
fi

# Get list of users in the group in a format suitable for processing
getent group "$GROUP_NAME" | cut -d: -f4 | tr "," "\n" > members.txt

# Get Non-group members
getent passwd | cut -d: -f1 | grep -vxFf members.txt > non_members.txt


